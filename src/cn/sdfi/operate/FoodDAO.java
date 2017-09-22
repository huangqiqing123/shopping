package cn.sdfi.operate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import cn.sdfi.model.Food;
import cn.sdfi.tools.DButil;

public class FoodDAO {
	
	/*
	 * 执行保存
	 */
	public int save(Food view){
		int flag=0;
		Connection conn = null;
		PreparedStatement ps=null;
		StringBuffer sql = new StringBuffer();
		sql.append("insert into t_food(name,price,typeId,addTime,memo,picture)values(?,?,?,?,?,?)");
		try {
			conn = DButil.getInstance().getCon();
			ps = conn.prepareStatement(sql.toString());
			ps.setString(1, view.getName());
			ps.setString(2, view.getPrice());
			ps.setInt(3, view.getTypeId());
			ps.setString(4, view.getAddTime());
			ps.setString(5,view.getMemo());
			ps.setString(6,view.getPicture());
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
					// TODO Auto-generated catch block
					e.printStackTrace();
					System.out.println("关闭连接出错");
				}
		}
			
		return flag;
	}
	/*
	 * 查询所有
	 */
	public List<Food> queryAll(){
		Connection conn = null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<Food> list=new ArrayList<Food>();
		StringBuffer sql = new StringBuffer();
		sql.append("select t1.*,t2.name typeName from t_food t1,t_type t2 where t1.typeId=t2.id order by typeId");
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
	 * 按商品名称（模糊、精确）、类别查询
	 */
	public List<Food> queryByNameAndType(String name,int typeId,boolean isBlur){
		Connection conn = null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<Food> list=new ArrayList<Food>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT t1.*,t2.name typeName FROM t_food t1,t_type t2 WHERE t1.typeId=t2.id");
		try {
			conn = DButil.getInstance().getCon();
			if(isBlur)
			{
				sql.append("  AND t1.name LIKE '%");
				sql.append(name);
				sql.append("%'");
				
			}
			else
			{
				sql.append("  AND t1.name = '");
				sql.append(name);
				sql.append("'");
			}
			if(typeId>=0)
			{
				sql.append("  AND t1.typeId= ");
				sql.append(typeId);
			}
			sql.append(" ORDER BY typeId");// 按类别编号排序
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
	 * 把 ResultSet 纪录封装到 list 中
	 */
	private List<Food> changeResultSet(ResultSet rs) {
		// TODO Auto-generated method stub
		List<Food> list=new ArrayList<Food>();
		Food view=null;
		if (rs==null) {
			System.out.println("*************结果集为空*************");
			return list;
		}
		try {
			while(rs.next()){
				
				view=new Food();
				view.setId(rs.getInt("id"));
				view.setName(rs.getString("name"));
				view.setAddTime(rs.getString("addTime"));
				view.setMemo(rs.getString("memo"));
				view.setPicture(rs.getString("picture"));
				view.setPrice(rs.getString("price"));
				view.setType(rs.getString("typeName"));
				view.setTypeId(rs.getInt("typeId"));
				list.add(view);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	/*
	 * 更新
	 */
	public int update(Food view){
		int flag=0;
		Connection conn = null;
		PreparedStatement ps=null;
		StringBuffer sql = new StringBuffer();
		sql.append("update t_food set name=?,price=?,typeId=?,picture=?,memo=? where id=?");
		try {
			conn = DButil.getInstance().getCon();
			ps = conn.prepareStatement(sql.toString());
			ps.setString(1, view.getName());
			ps.setString(2, view.getPrice());
			ps.setInt(3, view.getTypeId());
			ps.setString(4, view.getPicture());
			ps.setString(5,view.getMemo());
			ps.setInt(6,view.getId());
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
					// TODO Auto-generated catch block
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
		Connection conn = null;
		PreparedStatement ps=null;
		StringBuffer sql = new StringBuffer();
		sql.append("delete from t_food where id=?");
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
	public Food queryById(String id) {
		Connection conn = null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		Food view=null;
	
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT t1.*,t2.name typeName FROM t_food t1,t_type t2 WHERE t1.typeId=t2.id AND t1.id=");
		sql.append(id);
		try {
			conn = DButil.getInstance().getCon();
			ps = conn.prepareStatement(sql.toString());
			rs=ps.executeQuery();
			view=changeRsToView(rs);
			
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
 * 结果集到实体对象的转换
 */
	private Food changeRsToView(ResultSet rs) throws Exception {
		// TODO Auto-generated method stub
		Food view=new Food();
		if(rs.next()){
			view.setId(rs.getInt("id"));
			view.setName(rs.getString("name"));
			view.setAddTime(rs.getString("addTime"));
			view.setMemo(rs.getString("memo"));
			view.setPicture(rs.getString("picture"));
			view.setPrice(rs.getString("price"));
			view.setType(rs.getString("typeName"));
			view.setTypeId(rs.getInt("typeId"));
		}
		return view;
	}
}
