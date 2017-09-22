package cn.sdfi.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.sdfi.model.Detail;
import cn.sdfi.model.Order;
import cn.sdfi.model.Seat;
import cn.sdfi.model.User;
import cn.sdfi.operate.OrderDAO;
import cn.sdfi.tools.Const;
import cn.sdfi.tools.Tool;

public class OrderDo implements IDo {

	private OrderDAO dao = new OrderDAO();

	private String url = "";

	public String dealRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// 设置编码格式
		request.setCharacterEncoding(Const.CHARACTOR_ENCODING);
		response.setCharacterEncoding(Const.CHARACTOR_ENCODING);
		response.setContentType(Const.CONTENT_TYPE);
	
		String method = request.getParameter("method");
		if ("add".equals(method)) {
			url = this.add(request, response);
		}
		else if ("delete".equals(method)) {
			url = this.delete(request, response);
		}else if ("query".equals(method)) {
			url = this.query(request, response);
		}else if ("detail".equals(method)){
			url = this.detail(request, response);
		} else if ("deleteDetailInShopCart".equals(method)) {
			url = this.deleteDetailInShopCart(request, response);
		} else {
			System.out.println("你请求的url不存在");
		}
		return url;
	}
	/*
	 * 查询
	 */
private String query(HttpServletRequest request, HttpServletResponse response) {
		
	String username=request.getParameter("name");
	String time=request.getParameter("time");
	String orderId=request.getParameter("orderId");
	try {
		List<Order> list=dao.query(username,time,orderId);
		System.out.println("查询出 "+list.size()+" 条记录");
		request.setAttribute("query.data",list);
	} catch (Exception e) {
		e.printStackTrace();
		request.setAttribute("msg","出错了"+e);
	}
		return "order_manage.jsp";
	}
	/*
 * 删除订单操作
 */
	private String delete(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String[] id = request.getParameterValues("id");
		for (int i = 0; i < id.length; i++) {
			try {
				dao.deleteById(id[i]);
			} catch (Exception e) {
				e.printStackTrace();
				request.setAttribute("msg", "出错了，请与系统管理员联系！！！");
				return "order_manage.jsp";
			}
		}
		request.setAttribute("msg", "删除 "+id.length+" 条记录成功！！！");
		return "order_manage.jsp";
	}

	/*
	 * 删除购物车中的餐品
	 */
	private String deleteDetailInShopCart(HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		HashMap map = null;
		map = (HashMap) request.getSession().getAttribute("cart");
		String[] detailId = request.getParameterValues("detailId");
		for (int i = 0; i < detailId.length; i++) {
			System.out.println(detailId[i]);
			if (map.containsKey(detailId[i])) {
				map.remove(detailId[i]);
			}
		}
		request.getSession().setAttribute("cart", map);
		return "showCart.jsp";
	}


	/*
	 * 查询明细
	 */
	private String detail(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter("id");
		Order order = dao.queryByOrderId(id);
		request.setAttribute("view.data", order);
		return "orderDetail.jsp";

	}

	/*
	 * 新增
	 */
	private String add(HttpServletRequest request, HttpServletResponse response) {
		Order order = null;
		Detail detail = null;
		HashMap map = (HashMap) request.getSession().getAttribute("cart");
		String time = request.getParameter("time");// 获取送餐时间
		String money = request.getParameter("money");// 获取花费总金额
		User user = (User) request.getSession().getAttribute("user");
		Seat seat=(Seat)request.getSession().getAttribute("seat");
		if(seat==null){
			request.setAttribute("msg","订餐失败，你还没有预订餐位！");
			return "showCart.jsp";
		}
		order = new Order();
		order.setCreateTime(Tool.getDateTime());
		order.setDemandTime(time);
		order.setId(Tool.getOrderId());
		order.setMoney(money);
		order.setSeatId(seat.getSeatId()+"");
		order.setUser_id(user.getId());
		// 遍历 该map,转存到 List 中
		List<Detail> list = new ArrayList<Detail>();
		Set set = map.keySet();
		Iterator iter = set.iterator();
		String key = null;
		while (iter.hasNext()) {
			key = (String) iter.next();
			detail = (Detail) map.get(key);
			detail.setFk(order.getId());
			list.add(detail);
		}
		order.setList(list);
		if (1 == dao.save(order)) {
			request.setAttribute("msg", "订餐成功，谢谢你的光临!!!!");
		} else {
			request.setAttribute("msg", "操作失败，请与系统管理员联系!!!!");
		}
		return "main.jsp";
	}

}
