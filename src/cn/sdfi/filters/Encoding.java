package cn.sdfi.filters;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
public class Encoding implements Filter {
	private String encoding = "";

	public void destroy() {
		System.out.println("过滤器销毁");
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// 设置统一请求编码 UTF-8，在jsp页面中，
		// 无需在单独写 request.setCharacterEncoding("UTF-8")
		try {
			request.setCharacterEncoding(encoding);
			response.setCharacterEncoding(encoding);
		} catch (Exception e) {
			chain.doFilter(request, response);
		}
		//System.out.println("传递前");
		chain.doFilter(request, response);
		//System.out.println("传递后");
	}

	public void init(FilterConfig config) throws ServletException {
		
		System.out.println("过滤器初始化");
		this.encoding = config.getInitParameter("encoding");
		System.out.println("初始化encoding" + encoding);
	}


}
