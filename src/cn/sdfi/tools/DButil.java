package cn.sdfi.tools;

import java.sql.Connection;
import java.sql.DriverManager;

public class DButil {

	private DButil() {

	}
	// 单态类
	private static DButil instance=null;
	public static synchronized  DButil getInstance(){
		if(instance==null){
			instance=new DButil();
		}
		return instance;
	}
	//  获取连接
	public Connection getCon() throws Exception {
		Connection conn = null;
		Class.forName(Const.DRIVER_NAME);
		conn = DriverManager.getConnection(Const.URL, Const.USER_NAME,
				Const.PASSWORD);
		System.out.println("连接数据库成功");
		return conn;
		}

	public static void main(String[] args) throws Exception {
		getInstance().getCon();
	}

}
