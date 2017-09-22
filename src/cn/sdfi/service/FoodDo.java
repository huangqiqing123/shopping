package cn.sdfi.service;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.sdfi.model.Food;
import cn.sdfi.operate.FoodDAO;
import cn.sdfi.tools.Const;
import cn.sdfi.tools.Tool;

public class FoodDo implements IDo {

	private FoodDAO dao=new FoodDAO();
	public String dealRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
//		 设置编码格式
		request.setCharacterEncoding(Const.CHARACTOR_ENCODING);
		response.setCharacterEncoding(Const.CHARACTOR_ENCODING);
		response.setContentType(Const.CONTENT_TYPE);
		String url="";
		String method = request.getParameter("method");
		if ("add".equals(method)) {
			url=this.add(request, response);
		}
		else if ("update".equals(method)) {
			url=this.update(request, response);
		}
		else if ("query".equals(method)) {
			url=this.query(request, response);
		}
		else if ("detail".equals(method)) {
			url=this.detail(request, response);
		}
		else if ("updateToDB".equals(method)) {
			url=this.updateToDB(request, response);
		}
		else if ("delete".equals(method)) {
			url=this.delete(request, response);
		}
		else{
			System.out.println("你请求的url不存在");
		}
		return url;
	}
/*
 * 删除操作
 */
private String delete(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
	String[] id = request.getParameterValues("id");
	for (int i = 0; i < id.length; i++) {
		dao.deleteById(id[i]);
	}
	request.setAttribute("msg", "删除 "+id.length+" 条记录成功！！！");
	return "foodQuery.jsp";
	}
/*
 * 更新
 */
private String updateToDB(HttpServletRequest request, HttpServletResponse response) {
		Food view=new Food();
		view.setId(Integer.parseInt(request.getParameter("id")));
		view.setName(request.getParameter("name"));
		view.setPicture(request.getParameter("picture"));
		view.setPrice(request.getParameter("price"));
		view.setMemo(request.getParameter("memo"));
		view.setTypeId(Integer.parseInt(request.getParameter("typeId")));
		
		if(dao.update(view)==1)
			{
			request.setAttribute("msg","修改信息成功");
			
			
			request.setAttribute("view.data",dao.queryById(view.getId()+""));
			return "foodDetail.jsp";
			}
		else
		{
			request.setAttribute("msg","操作失败，请与系统管理员联系");
			return "updateFood.jsp";
		}
	}
/*
 * 查询明细
 */
	private String detail(HttpServletRequest request, HttpServletResponse response) {
		String id=request.getParameter("id");
		String privledge=request.getParameter("privledge");
		Food view=dao.queryById(id);
		request.setAttribute("view.data",view);
		if(!"3".equals(privledge))
		return "foodDetail.jsp";
		else
			return "putintocart.jsp";
		
	}
/*
 * 查询
 */
	private String query(HttpServletRequest request, HttpServletResponse response) {
			
			String privledge=request.getParameter("privledge");
			String name=request.getParameter("name");
			String style = request.getParameter("style");
			String typeId=request.getParameter("typeId");
			boolean isBlur=false;
			if(style.equals("blur"))
			{
				isBlur=true;
			}
			List list=dao.queryByNameAndType(name,Integer.parseInt(typeId),isBlur);
			request.setAttribute("view.data", list);
			if("3".equals(privledge)){
				return "help.jsp";
			}
			else
			{
				return "foodQuery.jsp";
			}
		
	}
/*
 * 更新前的查询
 */
	private String update(HttpServletRequest request, HttpServletResponse response) {
		
		String id=request.getParameter("id");
		Food view=dao.queryById(id);
		request.setAttribute("view.data",view);
		return "updateFood.jsp";
	}
/*
 * 新增
 */
	private String add(HttpServletRequest request, HttpServletResponse response) {
		String url="";
		String action=request.getParameter("action");
		dao=new FoodDAO();
		Food view = new Food();
		view.setName(request.getParameter("name"));
		view.setPicture(request.getParameter("picture"));
		view.setPrice(request.getParameter("price"));
		view.setMemo(request.getParameter("memo"));
		view.setAddTime(Tool.getDateTime());
		view.setTypeId(Integer.parseInt(request.getParameter("type")));
	
		//	 判断该类别的商品名称是否已存在
		
		List list = dao.queryByNameAndType(view.getName(), view.getTypeId(), false);
		if (list.size() > 0) 
		{
			request.setAttribute("msg", "该类别的商品名称已存在，添加失败");
			url="addFood.jsp";
		}
		else
		{	
			if(dao.save(view)==1)
			{
				request.setAttribute("msg", "操作成功");
				
				// 继续添加
				if("continue".equals(action)){
					url="addFood.jsp";
				}
				else
				{
					// 跳转到明细页面
					request.setAttribute("view.data", dao.queryByNameAndType(view.getName(),view.getTypeId(), false).get(0));
					url="foodDetail.jsp";
				}			
			}
			else
			{
				request.setAttribute("msg", "操作数据库失败，请与系统管理员联系");
				url="addFood.jsp";
			}		
		}
		return url;
	}

}
