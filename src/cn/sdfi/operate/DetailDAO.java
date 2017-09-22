package cn.sdfi.operate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import cn.sdfi.model.Detail;
import cn.sdfi.tools.DButil;

public class DetailDAO {
	
	private Connection conn = null;
	private PreparedStatement ps = null;
	private ResultSet rs = null;
	/*
	 * 执行保存
	 */
	public void save(Detail view,Connection conn) throws Exception{
		
		StringBuffer sql = new StringBuffer();
		sql.append("insert into t_detail(food_id,account,amount,price,fk)values(");
		sql.append(view.getFood_id());
		sql.append(",'");
		sql.append(view.getAccount());
		sql.append("',");
		sql.append(view.getAmount());
		sql.append(",'");
		sql.append(view.getPrice());
		sql.append("','");
		sql.append(view.getFk());
		sql.append("')");
		conn = DButil.getInstance().getCon();
		ps = conn.prepareStatement(sql.toString());
		ps.executeUpdate();
		if(ps!=null)
		{
			ps.close();
		}
		
	}
	/*
	 * 按 订单 ID 查询
	 */
	public List<Detail> queryByOrderId(String orderId){
		
		List<Detail> list=new ArrayList<Detail>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT t_detail.*,t_food.name foodName FROM  t_detail,t_food");
		sql.append(" WHERE t_detail.food_id=t_food.id AND t_detail.fk='");
		sql.append(orderId);
		sql.append("'");
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
	 * 把 ResultSet 纪录封装到 list 中
	 */
	private List<Detail> changeResultSet(ResultSet rs) {
		// TODO Auto-generated method stub
		List<Detail> list=new ArrayList<Detail>();
		Detail view=null;
		if (rs==null) {
			System.out.println("*************结果集为空*************");
			return list;
		}
		try {
			while(rs.next()){
				
				view=new Detail();
				view.setId(rs.getInt("id"));
				view.setAccount(rs.getString("account"));
				view.setAmount(rs.getInt("amount"));
				view.setFk(rs.getString("fk"));
				view.setFood_id(rs.getInt("food_id"));
				view.setFoodName(rs.getString("foodName"));
				view.setPrice(rs.getString("price"));
				list.add(view);	
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
	
	/*
	 * 按订单 ID 删除
	 */
	public void deleteById(String id,Connection conn) throws Exception{
		
		
		StringBuffer sql = new StringBuffer();
		sql.append("delete from t_detail where fk=?");

			conn = DButil.getInstance().getCon();
			ps = conn.prepareStatement(sql.toString());
			ps.setString(1, id);
			ps.executeUpdate();
						
			if (ps != null)
			ps.close();
		
	}
}
