package cn.sdfi.operate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import cn.sdfi.model.Type;
import cn.sdfi.tools.DButil;

public class TypeDAO {
	
	private Connection conn = null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	
//	 执行保存
	public void save(Type type) throws Exception{

		StringBuffer sql = new StringBuffer();
		sql.append("insert into t_type(name,parentId)values(?,?)");
	
			conn = DButil.getInstance().getCon();
			ps = conn.prepareStatement(sql.toString());
			ps.setString(1, type.getName());
			ps.setInt(2, type.getParentId());
			ps.executeUpdate();
			if (ps != null)
				ps.close();
			if (conn != null)
				conn.close();

	}
	/*
	 * 查询全部
	 */
	public List<Type> queryAll(){
		
		List<Type> list=new ArrayList<Type>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT t1.*,t2.name parentName FROM t_type t1 , t_type t2 WHERE t1.parentId=t2.id");
		try {
			conn = DButil.getInstance().getCon();
			ps = conn.prepareStatement(sql.toString());
			rs=ps.executeQuery();
			list=changeResultSet(rs);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
	
				try {
					if (ps != null)
					ps.close();
					if (conn != null)
						conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					System.out.println("关闭连接出错");
				}
		}
			
		return list;
	}
	/*
	 * 按 名称 精确查询
	 */
	public Type queryTypeByName(String name) throws Exception{
	
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT t1.*,t2.name as parentName FROM t_type t1  ,t_type t2 where t1.parentId=t2.id  AND t1.name=?");

			conn = DButil.getInstance().getCon();
			ps = conn.prepareStatement(sql.toString());
			ps.setString(1, name);
			rs=ps.executeQuery();
			Type type=changeRsToType(rs);
	
					if (ps != null)
					ps.close();
					if (conn != null)
						conn.close();

		return type;
	}
	// 把 ResultSet 纪录封装到 list 中
	private List<Type> changeResultSet(ResultSet rs) {
		// TODO Auto-generated method stub
		List<Type> list=new ArrayList<Type>();
		Type type=null;
		if (rs==null) {
			return list;
		}
		try {
			while(rs.next()){
				type=new Type();
				type.setId(rs.getInt("id"));
				type.setName(rs.getString("name"));
				type.setParentId(rs.getInt("parentId"));
				type.setParentName(rs.getString("parentName"));
				list.add(type);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	/*
	 * 类别 更改
	 */
	public int update(Type type){
		int flag=0;
		StringBuffer sql = new StringBuffer();
		sql.append("update t_type set name=?,parentId=? where id=?");
		try {
			conn = DButil.getInstance().getCon();
			ps = conn.prepareStatement(sql.toString());
			ps.setString(1, type.getName());
			ps.setInt(2, type.getParentId());
			
			flag=ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return flag;
		} finally {
	
				try {
					if (ps != null)
					ps.close();
					if (conn != null)
						conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
					System.out.println("关闭连接出错");
				}
		}
		return flag;
	}
	/*
	 * 按 ID 删除
	 */
	public int deleteById(String id){
		int flag=0;
		StringBuffer sql = new StringBuffer();
		sql.append("delete from t_type where id=?");
		try {
			conn = DButil.getInstance().getCon();
			ps = conn.prepareStatement(sql.toString());
			ps.setString(1, id);
			flag=ps.executeUpdate();
						
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
	
				try {
					if (ps != null)
					ps.close();
					if (conn != null)
						conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					System.out.println("关闭连接出错");
				}
		}
			
		
		return flag;
	}
//  按 ID 查询
	public Type queryTypeById(String id) {
		
		Type view=null;
	
		StringBuffer sql = new StringBuffer();
		sql.append("select * from t_type where id=?");
		try {
			conn = DButil.getInstance().getCon();
			ps = conn.prepareStatement(sql.toString());
			ps.setInt(1, Integer.parseInt(id));
			rs=ps.executeQuery();
			view=changeRsToType(rs);
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
	
				try {
					if (ps != null)
					ps.close();
					if (conn != null)
						conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					System.out.println("关闭连接出错");
				}
		}
			
		return view;
	}
/*
 * changeRsToType
 */
	private Type changeRsToType(ResultSet rs) throws Exception {
		// TODO Auto-generated method stub
		Type type=null;
		if(rs.next()){
			type=new Type();
			type.setId(rs.getInt("id"));
			type.setName(rs.getString("name"));
			type.setParentId(rs.getInt("parentId"));
			type.setParentName(rs.getString("parentName"));
			
			}
		return type;
	}

	/*
	 * 按 名称 模糊查询
	 *  自身连接
	 */
	public List queryByNameWithBlur(String name) throws Exception {
		
		List<Type> list=new ArrayList<Type>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT t1.*,t2.name parentName FROM t_type t1 ,t_type t2 WHERE t1.parentId=t2.id");
		conn = DButil.getInstance().getCon();
		sql.append("  AND t1.name LIKE '%");
		sql.append(name);
		sql.append("%'");
		ps = conn.prepareStatement(sql.toString());
		rs=ps.executeQuery();
		list=changeResultSet(rs);
		if (ps != null)
		ps.close();
		if (conn != null)
		conn.close();
		return list;
	}
	public static void main(String[] args) throws Exception {
		System.out.println(new TypeDAO().queryTypeByName("书籍"));
	}
}
