package cn.sdfi.listeners;

import java.util.HashMap;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import cn.sdfi.model.User;
import cn.sdfi.tools.Tool;

public class OnLineListener implements ServletContextListener,
		HttpSessionListener, HttpSessionAttributeListener {
//	 声明一个ServletContext对象
	//private ServletContext application = null ;
	public void contextDestroyed(ServletContextEvent arg0) {
		
		System.out.println("********容器销毁*******"+Tool.getDateTime());
	}

	public void contextInitialized(ServletContextEvent arg0) {
		// 容器初始化时，向application中存放一个空的容器
		System.out.println("********容器初始化*******"+Tool.getDateTime());
		//this.application = arg0.getServletContext() ;
		//this.application.setAttribute("alluser",new ArrayList()) ;
	}

	public void sessionCreated(HttpSessionEvent arg0) { 
		// TODO Auto-generated method stub
		System.out.println("********创建新session*******"+arg0.getSource()+Tool.getDateTime());
		
		}

	public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
		
//		 将用户名称从列表中删除
		System.out.println("********有sessionDestroyed*******"+Tool.getDateTime());
		HttpSession session=httpSessionEvent.getSession();//public HttpSession getSession(),Return the session that changed
		User user=(User)session.getAttribute("user");
		HashMap map = (HashMap)session.getServletContext().getAttribute("map") ;
		
		if(map.containsKey(user.getId()))
		{  
			System.out.println("********用户"+user.getName()+"下线*******"+Tool.getDateTime());
			map.remove(user.getId());
			httpSessionEvent.getSession().getServletContext().setAttribute("map",map);
		}else{
			System.out.println("********用户下线时出错*******"+Tool.getDateTime());
		}
		
	}

	public void attributeAdded(HttpSessionBindingEvent arg0) {
//		 如果登陆成功，则将用户名保存在列表之中
		System.out.println("** Session 增加属性:"+arg0.getName()+" --> "+arg0.getValue()) ;
		//List list = (List)this.application.getAttribute("alluser") ;
		//list.add(arg0.getSession().getAttribute("who"));
		//this.application.setAttribute("alluser",list) ;
	}

	public void attributeRemoved(HttpSessionBindingEvent arg0) {
		// TODO Auto-generated method stub
		System.out.println("********session有属性移出*******");
	}

	public void attributeReplaced(HttpSessionBindingEvent arg0) {
		// TODO Auto-generated method stub
		System.out.println("********session属性改变*******");
	}

}
