package cn.sdfi.operate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import cn.sdfi.model.Seat;
import cn.sdfi.tools.DButil;

public class SeatDAO {
	
	private Connection conn = null;
	private PreparedStatement ps=null;
	private ResultSet rs=null;
	
	/*
	 * 执行保存
	 */
	public int save(Seat view){
		int flag=0;
		
		StringBuffer sql = new StringBuffer();
		sql.append("insert into t_seat(location,nums,money,available,memo,pic)values(?,?,?,?,?,?)");
		try {
			conn = DButil.getInstance().getCon();
			ps = conn.prepareStatement(sql.toString());
			ps.setString(1, view.getLocation());
			ps.setString(2, view.getNums());
			ps.setString(3, view.getMoney());
			ps.setString(4, view.getAvailable());
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
	public List<Seat> queryAll(){
		
		List<Seat> list=new ArrayList<Seat>();
		StringBuffer sql = new StringBuffer();
		sql.append("select * from t_seat");
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
	 * 更改餐位状态
	 */
	public int changState(String id, String newState) throws Exception {
		int flag = 0;
		StringBuffer sql = new StringBuffer();
		sql.append("UPDATE t_seat SET available='");
		sql.append(newState);
		sql.append("' WHERE seatId=");
		sql.append(id);
		
		conn = DButil.getInstance().getCon();
		ps = conn.prepareStatement(sql.toString());
		flag = ps.executeUpdate();
		if (ps != null)
			ps.close();
		if (conn != null)
			conn.close();

		return flag;

	}
	/*
	 * 把 ResultSet 纪录封装到 list 中
	 */
	private List<Seat> changeResultSet(ResultSet rs) {
		// TODO Auto-generated method stub
		List<Seat> list=new ArrayList<Seat>();
		Seat view=null;
		if (rs==null) {
			System.out.println("*************结果集为空*************");
			return list;
		}
		try {
			while(rs.next()){
				
				view=new Seat();
				view.setSeatId(rs.getInt("seatId"));
				view.setAvailable(rs.getString("available"));
				view.setLocation(rs.getString("location"));
				view.setMemo(rs.getString("memo"));
				view.setMoney(rs.getString("money"));;
				view.setNums(rs.getString("nums"));
				view.setPicture(rs.getString("pic"));
				
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
	public int update(Seat view) throws Exception{
		int flag=0;
		Connection conn = null;
		PreparedStatement ps=null;
		StringBuffer sql = new StringBuffer();
		sql.append("update t_seat set location=?,nums=?,money=?,available=?,memo=?,pic=? where seatId=?");
	
		conn = DButil.getInstance().getCon();
		ps = conn.prepareStatement(sql.toString());
		ps.setString(1, view.getLocation());
		ps.setString(2, view.getNums());
		ps.setString(3, view.getMoney());
		ps.setString(4, view.getAvailable());
		ps.setString(5,view.getMemo());
		ps.setString(6,view.getPicture());
		ps.setInt(7,view.getSeatId());
		flag=ps.executeUpdate();
		
		if (ps != null)
			ps.close();
		if (conn != null)
			conn.close();
			
		return flag;
	}
	/*
	 * 按 ID 删除
	 */
	public int deleteById(String id){
		int flag=0;
		
		StringBuffer sql = new StringBuffer();
		sql.append("delete from t_seat where seatId=?");
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
	public Seat queryById(String id) {
		
		Seat view=null;
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM t_seat  WHERE seatId=");
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
	 * 按 餐位位置、容纳人数 查询
	 */
	public List queryByLocationAndNums(String location,String nums) {
		
		List list=null;
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM t_seat  WHERE location LIKE '%");
		sql.append(location);
		sql.append("%'");
		if(!"0".equals(nums))
		{
			sql.append(" AND nums='");
			sql.append(nums);
			sql.append("'");
		}
		try {
			conn = DButil.getInstance().getCon();
			ps = conn.prepareStatement(sql.toString());
			rs=ps.executeQuery();
			list=this.changeResultSet(rs);
			
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
 * 结果集到实体对象的转换
 */
	private Seat changeRsToView(ResultSet rs) throws Exception {
		// TODO Auto-generated method stub
		Seat view=new Seat();
		if(rs.next()){
			view.setSeatId(rs.getInt("seatId"));
			view.setAvailable(rs.getString("available"));
			view.setLocation(rs.getString("location"));
			view.setMemo(rs.getString("memo"));
			view.setMoney(rs.getString("money"));;
			view.setNums(rs.getString("nums"));
			view.setPicture(rs.getString("pic"));
		}
		return view;
	}
	public static void main(String[] args) {
		
	}
}
