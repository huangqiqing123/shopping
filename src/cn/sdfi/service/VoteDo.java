package cn.sdfi.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.sdfi.operate.VoteDAO;

public class VoteDo implements IDo {
	
	String url="";
	public String dealRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
			String method=request.getParameter("method");
			if("vote".equals(method))
			{
				url=vote(request, response);
			}
		return url;
	}

	/*
	 * 投票操作
	 */
		private String vote(HttpServletRequest request, HttpServletResponse response) {
			// TODO Auto-generated method stub
			int id=Integer.parseInt(request.getParameter("itermId"));
			VoteDAO  dao=new VoteDAO();
			try {
				if(1==dao.doVote(id)){
					request.setAttribute("msg","投票成功,谢谢你的参与!!!");
				}else{
					request.setAttribute("msg","操作失败，请与系统管理员联系!!");
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
			return "vote.jsp?showResult=true";
		}	
}
