package cn.sdfi.control;

import java.io.IOException;
import java.util.Map;
import java.util.Properties;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import cn.sdfi.service.IDo;
/*
 * 该类是控制器，负责拦截所有以 .do 结尾的请求，并加载配置文件 object.properties
 * 根据解析的 路径 找到相应的 具体执行业务的类，执行完毕进行请求转发
 */
public class Control extends HttpServlet {

	private static final long serialVersionUID = 1L;
	public void init() throws ServletException {
		System.out.println("*****************控制器初始化************************");
	}

	public void destroy() {
		super.destroy();
		System.out.println("*****************控制器销毁************************");
	}
	protected void service(HttpServletRequest resquest,
			HttpServletResponse response) {

		String cpath = resquest.getRequestURI();
		// /shop/userdo.do
		// 解析路径 -------> "abcde".substring(0,1)结果是 a
		int a = cpath.lastIndexOf("/"); // 获取 '/' 最后一次出现的位置
		int b = cpath.indexOf(".do"); // 获取 '.do' 第一次出现的位置
		String doname = cpath.substring(a + 1, b);// 截取 两个位置之间的数据
		IDo s = getServlet(doname);
		String url;
		try {
			url = s.dealRequest(resquest, response);
			if (url != null) {
				System.out.println("***********执行完毕，准备跳转**************");
				System.out.println(url);
				resquest.getRequestDispatcher(url).forward(resquest, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 接收 一个键值 ,返回该键值对应的类的实例
	IDo getServlet(String name) {
		Map<Object, Object> map = load_property_file("object.properties");
		String classname = (String) map.get(name);
		IDo obj = null;
		try {
			
			obj = (IDo) Class.forName(classname).newInstance();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("创建类 "+classname+" 的实例成功");
		return obj;
	}

	// 解析properties文件, 返回一个键值对应的 Map
	private Map<Object, Object> load_property_file(String property_file_name) {
		
		Properties prop = new Properties();
		try {
			prop.load(Thread.currentThread().getContextClassLoader()
					.getResourceAsStream(property_file_name));
		} catch (IOException e) {
			e.printStackTrace();
		}
		System.out.println("加载文件--"+property_file_name+"--成功");
		return prop;
	}

}
