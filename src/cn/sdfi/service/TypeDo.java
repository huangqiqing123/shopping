package cn.sdfi.service;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import cn.sdfi.model.Type;
import cn.sdfi.operate.TypeDAO;
import cn.sdfi.tools.Const;

public class TypeDo implements IDo {

	private TypeDAO dao=new TypeDAO();
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
//		else if ("update".equals(method)) {
//			url=this.update(request, response);
//		}
		else if ("query".equals(method)) {
			url=this.query(request, response);
		}
//		else if ("detail".equals(method)) {
//			url=this.detail(request, response);
//		}
//		else if ("updateToDB".equals(method)) {
//			url=this.updateToDB(request, response);
//		}
		else if ("delete".equals(method)) {
			url=this.delete(request, response);
		}
		else{
			System.out.println("你请求的url不存在");
		}
		return url;
	}
	/*
	 * 查询
	 */
		@SuppressWarnings("unchecked")
		private String query(HttpServletRequest request, HttpServletResponse response) {
				String name=request.getParameter("name").trim();
				String style = request.getParameter("style").trim();
				List<Type> list=new ArrayList<Type>();
				try {
				if("blur".equals(style))
				{
					list = dao.queryByNameWithBlur(name);	
				}
				else
				{
					list.add(dao.queryTypeByName(name));
				}
				} catch (Exception e) {
					e.printStackTrace();
					request.setAttribute("msg", "出错了"+e);
					return "typeQuery.jsp";
				}
				request.setAttribute("view.data", list);

			return "typeQuery.jsp";
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
	return "typeQuery.jsp";
	}

/*
 * 新增
 */
	private String add(HttpServletRequest request, HttpServletResponse response) {
		String url="";
		String action=request.getParameter("action");
		String name=request.getParameter("name");
		Type view=new Type();
		try {
			view.setName(name);
			view.setParentId(Integer.parseInt(request.getParameter("parentId")));
			dao.save(view);
			request.setAttribute("msg", "操作成功");
			// 继续添加
			if("continue".equals(action)){
				url="typeAdd.jsp";
			}
			else
			{
			// 跳转到明细页面
			request.setAttribute("view.data", dao.queryTypeByName(name));
			url="typeAdd.jsp";
			}			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			request.setAttribute("msg", "出错了"+e+name);
			return "typeAdd.jsp";
		}
		
			
		return url;
	}

}
