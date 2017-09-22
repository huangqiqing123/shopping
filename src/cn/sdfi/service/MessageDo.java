package cn.sdfi.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.sdfi.model.Message;
import cn.sdfi.operate.MessageDAO;
import cn.sdfi.tools.Const;
import cn.sdfi.tools.Tool;

public class MessageDo implements IDo {

	private String url="";
	private MessageDAO dao=new MessageDAO();
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
		else if("detail".equals(method)){
			url=queryMsgById(request, response);
		}
		else if ("delete".equals(method)) {
			url=delete(request, response);
		}
		else if ("reply".equals(method)) {
			url=reply(request, response);
		}
		else{
			System.out.println("你请求的url不存在");
		}
		return url;
	}
	/*
	 * 回复留言
	 */
private String reply(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
	String id=request.getParameter("id")	;
	String reply=request.getParameter("reply");
	try {
		dao.reply(id,reply);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		request.setAttribute("msg","出错了，请与系统管理员联系！！");
		request.setAttribute("view.data",dao.queryById(id));
		return "msgDetail.jsp";
	}
	request.setAttribute("msg","回复留言成功！！");
	request.setAttribute("view.data",dao.queryById(id));
	return "msgDetail.jsp";
	}
/*
 * 查询明细
 */
private String queryMsgById(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
	String id=request.getParameter("id")	;
	request.setAttribute("view.data",dao.queryById(id));
	return "msgDetail.jsp";
	}

/*
 * 删除操作
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
			return "messageManage.jsp";
		}
	}
	request.setAttribute("msg", "删除 "+id.length+" 条记录成功！！！");
	return "messageManage.jsp";
	}

	/*
	 * 保存留言信息
	 */
	private String add(HttpServletRequest request, HttpServletResponse response) {
		
			Message msg = new Message();
			String userId=request.getParameter("userId");
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			msg.setUserId(Integer.parseInt(userId));
			msg.setTitle(title);
			msg.setContent(content.trim());
			msg.setLeaveTime(Tool.getDateTime());
			if(1==dao.save(msg)){
			request.setAttribute("msg", "留言成功！！！");
			return "showAllMessages.jsp";	
			}
			else
			{
				request.setAttribute("msg", "操作数据库失败，请与系统管理员联系！！！");
				return "leaveMessage.jsp";	
			}
		}
}