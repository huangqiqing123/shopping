package cn.sdfi.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.sdfi.model.Seat;
import cn.sdfi.model.User;
import cn.sdfi.operate.SeatDAO;
import cn.sdfi.tools.Const;
import cn.sdfi.tools.Tool;

public class SeatDo implements IDo {

	private String url="";
	private SeatDAO dao=new SeatDAO();
	public String dealRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
//		 设置编码格式
		request.setCharacterEncoding(Const.CHARACTOR_ENCODING);
		response.setCharacterEncoding(Const.CHARACTOR_ENCODING);
		response.setContentType(Const.CONTENT_TYPE);
		
		String method = request.getParameter("method");
		if ("add".equals(method)) {
			url=add(request, response);
		}
		else if("query".equals(method)){
			url=query(request, response);
		}
		else if("detail".equals(method)){
			url=this.querySeatById(request, response);
		}
		else if ("delete".equals(method)) {
			url=delete(request, response);
		}
		else if ("update".equals(method)) {
			url=update(request, response);
		}
		else if ("changeState".equals(method)) {
			url=changeState(request, response);
		}
		else{
			System.out.println("你请求的url不存在");
		}
		return url;
	}
	/*
	 * 执行更新操作
	 */
	private String update(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String seatId=request.getParameter("seatId");
		Seat view = new Seat();
		view.setSeatId(Integer.parseInt(seatId));
		view.setAvailable(request.getParameter("available"));
		view.setLocation(request.getParameter("location"));
		view.setMemo(request.getParameter("memo"));
		view.setMoney(request.getParameter("money"));
		view.setNums(request.getParameter("nums"));
		view.setPicture(request.getParameter("picture"));
		try {
			dao.update(view);
			request.setAttribute("msg", "操作成功");
		} catch (Exception e) {
			request.setAttribute("msg", "出错了，请与系统管理员联系"+e);
			e.printStackTrace();
		}
		return "seatdo.do?method=detail&seatId="+seatId;
	}
	/*
	 * 按 餐位位置、容纳人数 查询
	 */
	private String query(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String location=request.getParameter("location").trim();
		String nums=request.getParameter("nums").trim();
		request.setAttribute("view.data",dao.queryByLocationAndNums(location, nums));

		return "seatQuery.jsp";
	}
	/*
	 *  预订餐位
	 */
private String changeState(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
	String seatId = request.getParameter("seatId").trim();
	String newState = Tool.codeToChina(request.getParameter("newState").trim());
	HttpSession session=request.getSession();
	try {
		User user=(User)session.getAttribute("user");
		if(user==null||"".equals(user.getPrivledge()))
		{
			request.setAttribute("msg", "你还没有登录，不能执行该操作！");
			return "main.jsp";
		}
		if(session.getAttribute("seat")!=null)
		{
			request.setAttribute("msg", "你已经预订餐位，不能重复预订！");
			return "main.jsp";
		}
		
		if (dao.changState(seatId, newState) == 1) {
				session.setAttribute("seat", dao.queryById(seatId));
				request.setAttribute("msg", "预订餐位成功，请你点餐！！");
				return "help.jsp";
		} 
	} catch (Exception e) {
		request.setAttribute("msg", "操作失败，请与系统管理员联系");
		System.out.println( "操作失败，请与系统管理员联系");
		e.printStackTrace();
	}
	return null;
	}


/*
 * 查询明细
 */
private String querySeatById(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
	String action=request.getParameter("action");
	String id=request.getParameter("seatId").trim();
	request.setAttribute("view.data",dao.queryById(id));
	
	if("forupdate".equals(action)){
		// 跳转到更新页面
		return "seatUpdate.jsp";
	}
	else
	{
		//跳转到明细页面
		return "seatDetail.jsp";
	}
	}

/*
 * 删除操作
 */
private String delete(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
	String[] id = request.getParameterValues("seatId");
	for (int i = 0; i < id.length; i++) {
		try {
			dao.deleteById(id[i]);
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "出错了，请与系统管理员联系！！！");
			return "seatQuery.jsp";
		}
	}
	request.setAttribute("msg", "删除 "+id.length+" 条记录成功！！！");
	return "seatQuery.jsp";
	}

	/*
	 * 新增餐位信息
	 */
	private String add(HttpServletRequest request, HttpServletResponse response) {
		
			Seat view = new Seat();
			view.setAvailable("是");
			view.setLocation(request.getParameter("location"));
			view.setMemo(request.getParameter("memo"));
			view.setMoney(request.getParameter("money"));
			view.setNums(request.getParameter("nums"));
			view.setPicture(request.getParameter("picture"));
			
			if(1==dao.save(view)){
			request.setAttribute("msg", "新增餐位成功！！！");
			if("continue".equals(request.getParameter("action")))
			{
				return "seatAdd.jsp";	
			}
			return "seatQuery.jsp";	
			}
			else
			{
				request.setAttribute("msg", "操作数据库失败，请与系统管理员联系！！！");
				return "seatAdd.jsp";	
			}
		}
}