package cn.sdfi.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cn.sdfi.model.User;
import cn.sdfi.operate.UserOperate;
import cn.sdfi.tools.Const;
import cn.sdfi.tools.Tool;

public class UserDo implements IDo {

	UserOperate dao = new UserOperate();

	public String dealRequest(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		// 设置编码格式
		request.setCharacterEncoding(Const.CHARACTOR_ENCODING);
		response.setCharacterEncoding(Const.CHARACTOR_ENCODING);
		response.setContentType(Const.CONTENT_TYPE);
		String url = "";
		String method = request.getParameter("method");
		if ("add".equals(method)) {
			url = this.add(request, response);
		} else if ("isUsed".equals(method)) {
			url = this.checkIsUsed(request, response);
		} else if ("update".equals(method)) {
			url = this.update(request, response);
		} else if ("login".equals(method)) {
			url = this.login(request, response);
		} else if ("query".equals(method)) {
			url = this.query(request, response);
		} else if ("detail".equals(method)) {
			url = this.detail(request, response);
		} else if ("updateToDB".equals(method)) {
			url = this.updateToDB(request, response);
		} else if ("delete".equals(method)) {
			url = this.delete(request, response);
		} else {
			System.out.println("你请求的url不存在");
		}
		return url;
	}

	/*
	 * 检查该用户名是否已被注册
	 */
	private String checkIsUsed(HttpServletRequest request,
			HttpServletResponse response) {
		String name = request.getParameter("name").trim();
		String privledge = request.getParameter("privledge");
		if (dao.isUsed(name)) {
			request.setAttribute("msg", "对不起，该用户名已被注册！");
			if ("3".equals(privledge)) {
				return "register.jsp";
			} else {
				return "addUser.jsp";
			}

		}
		request.setAttribute("msg", "该用户名可以使用！");
		if ("3".equals(privledge)) {
			return "register.jsp";
		} else {
			return "addUser.jsp";
		}

	}

	/*
	 * 删除操作
	 */
	private String delete(HttpServletRequest request,
			HttpServletResponse response) {
		// TODO Auto-generated method stub
		String[] id = request.getParameterValues("id");
		UserOperate dao = new UserOperate();
		for (int i = 0; i < id.length; i++) {
			dao.delete(Integer.parseInt(id[i]));
		}
		request.setAttribute("msg", "删除 " + id.length + " 条记录成功！！！");
		return "query.jsp";
	}

	/*
	 * 更新
	 */
	private String updateToDB(HttpServletRequest request,
			HttpServletResponse response) {

		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");// 当前登陆用户
		int privledge = user.getPrivledge();// 获取当前操作用户的 权限
		user = new User();
		user.setPrivledge(Integer.parseInt(request.getParameter("privledge")));
		user.setId(Integer.parseInt(request.getParameter("id")));
		user.setAddress(request.getParameter("address").trim());
		user.setEmail(request.getParameter("email"));
		user.setMemo(request.getParameter("memo").trim());
		user.setSex(request.getParameter("sex"));
		user.setPassword(request.getParameter("pass1"));
		user.setPhone(request.getParameter("phone"));
		user.setPicture(request.getParameter("picture"));
		new UserOperate().updateBySql(user);
		// 注销该用户
		if (3 == privledge) {
			session.invalidate();
			request.setAttribute("msg", "修改成功,请重新登录");
			return "main.jsp";
		}
		// 如果是管理员
		request.setAttribute("msg", "修改信息成功");
		return "userdo.do?method=query&id=" + user.getId() + "&type=accurate";

	}

	/*
	 * 查询明细
	 */
	private String detail(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter("id");
		User user = new UserOperate().query(Integer.parseInt(id));
		request.setAttribute("view.data", user);
		return "userDetail.jsp";

	}

	/*
	 * 查询
	 */
	private String query(HttpServletRequest request,
			HttpServletResponse response) {

		String type = request.getParameter("type");
		User user = new User();
		List list = new ArrayList();
		user.setName(request.getParameter("name"));
		user.setPrivledge(Integer.parseInt(request.getParameter("privledge")));
		// 执行精确查找
		if (type.equals("accurate")) {
			list = new UserOperate().query(user);
		}
		// 执行模糊查询
		else {
			list = new UserOperate().queryWithBlur(user);
		}
		request.setAttribute("list", list);

		return "query.jsp";
	}

	/*
	 * 登陆处理
	 */
	@SuppressWarnings("unchecked")
	private String login(HttpServletRequest request,
			HttpServletResponse response) {

		List list = null;
		String privledge = request.getParameter("privledge").trim();
		String username = request.getParameter("name").trim();
		String pwd = request.getParameter("password").trim();

		// 管理员登陆需要检测验证码
		if (!"3".equals(privledge)) {
			String checknumber = request.getParameter("checkNumber");
			System.out.println(checknumber);
			if (!request.getSession().getAttribute("rand").equals(checknumber)) {
				request.setAttribute("msg", "验证码不正确!!!");
				return "login.jsp";
			}
		}

		// 判断该用户是否已经登录
		HashMap<Object, User> map = (HashMap) request.getSession()
				.getServletContext().getAttribute("map");
		if (map != null) {
			User temp = null;
			Set set = map.keySet();
			Iterator iter = set.iterator();
			while (iter.hasNext()) {
				temp = (User) map.get(iter.next());
				if (username.equals(temp.getName().trim())) {
					request.setAttribute("msg", "对不起，该用户已登录！");
					if ("3".equals(privledge)) {
						return "main.jsp";
					} else {
						return "login.jsp";
					}
				}
			}
		}
		// 封装信息
		User user = new User();
		user.setName(username);
		user.setPassword(pwd);
		user.setPrivledge(Integer.parseInt(privledge));
		list = new UserOperate().checkLogin(user);
		if (list.size() == 1) {
			// 登录成功，存储该用户信息
			user = new User();
			user = (User) list.get(0);
			user.setLoginTime(Tool.getDateTime());// 记录登陆时间
			request.getSession().setAttribute("user", user);

			// 存储在线用户
			if (map == null) {
				map = new HashMap<Object, User>();
			}
			map.put(user.getId(), user);
			request.getSession().getServletContext().setAttribute("map", map);
			if (user.getPrivledge() == 1) {
				return "manageMain.jsp";

			} else {
				return "main.jsp";
			}
		} else {
			// 如用户不存在....
			request.setAttribute("msg", "登陆失败，用户名或密码错误！！");
			if (user.getPrivledge() == 3) {
				return "main.jsp";
			} else {
				return "login.jsp";
			}
		}
	}

	/*
	 * 更新前的查询
	 */
	private String update(HttpServletRequest request,
			HttpServletResponse response) {

		String id = request.getParameter("id");
		if(id==null||"".equals(id))
		{
			request.setAttribute("msg","你还没有登录！！！");
			return "main.jsp";
		}
		User user = new UserOperate().query(Integer.parseInt(id));
		request.setAttribute("query.data", user);
		if(request.getParameter("privledge")!=null){
			return "updateInfor.jsp";
		}
		return "updateUser.jsp";
	}

	/*
	 * 新增
	 */
	private String add(HttpServletRequest request, HttpServletResponse response) {
		String url = "";
		String privledge = request.getParameter("privledge").trim();
		String name = request.getParameter("name").trim();
		// 判断该用户名是否已存在
		if (dao.isUsed(name)) {
			request.setAttribute("msg", "用户名已被注册，注册失败");
			if (privledge.equals("3")) {
				return "register.jsp";
			} else {
				return "addUser.jsp";
			}
		}
		User user = new User();
		user.setName(name);
		user.setAddress(request.getParameter("address"));
		user.setEmail(request.getParameter("email"));
		user.setMemo(request.getParameter("memo").trim());
		user.setSex(request.getParameter("sex"));
		user.setPassword(request.getParameter("pass1"));
		user.setPhone(request.getParameter("phone"));
		user.setPicture(request.getParameter("picture"));
		user.setPrivledge(Integer.parseInt(privledge));
		user.setRegisterTime(Tool.getDateTime());
		new UserOperate().add(user);
		if (privledge.equals("3")) {
			request.setAttribute("msg", "注册成功，恭喜你成为我们的会员！！");
			url = "main.jsp";
		} else {
			request.setAttribute("msg", "添加用户成功");
			String action = request.getParameter("action").trim();
			if ("continue".equals(action)) {
				url = "addUser.jsp";
			} else {
				url = "userdo.do?method=query&id=" + user.getId()
						+ "&type=accurate";
			}

		}
		return url;
	}

}
