package cn.sdfi.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface IDo  {
	public String dealRequest(HttpServletRequest request, HttpServletResponse response) throws Exception;

}
