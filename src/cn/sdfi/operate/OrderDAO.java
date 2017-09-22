package cn.sdfi.operate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import cn.sdfi.model.Detail;
import cn.sdfi.model.Order;
import cn.sdfi.tools.DButil;

public class OrderDAO {

	private DetailDAO ddao = new DetailDAO();

	private Connection conn = null;

	private PreparedStatement ps = null;

	private ResultSet rs = null;

	/*
	 * 执行保存,主从表的特殊处理
	 */
	public int save(Order view) {
		int flag = 0;
		StringBuffer sql = new StringBuffer();
		sql
				.append("insert into t_order(id,user_id,createTime,demandTime,money,seatId)values('");
		sql.append(view.getId());
		sql.append("',");
		sql.append(view.getUser_id());
		sql.append(",'");
		sql.append(view.getCreateTime());
		sql.append("','");
		sql.append(view.getDemandTime());
		sql.append("','");
		sql.append(view.getMoney());
		sql.append("',");
		sql.append(view.getSeatId());
		sql.append(")");
		try {
			// 保持同一个数据库连接，失败则同时回滚
			conn = DButil.getInstance().getCon();
			conn.setAutoCommit(false);
			ps = conn.prepareStatement(sql.toString());
			flag = ps.executeUpdate();
			List list = view.getList();
			for (int i = 0; i < list.size(); i++) {
				ddao.save((Detail) list.get(i), conn);
			}
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();// 事务回滚
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			return 0;
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
	 * 按订单编号查询
	 */
	public Order queryByOrderId(String id) {

		Order view = null;
		StringBuffer sql = new StringBuffer();
		sql
				.append("SELECT t_order.*,t_user.name userName,t_seat.location FROM t_order,t_user,t_seat ");
		sql.append(" WHERE t_order.user_id=t_user.id");
		sql.append(" AND t_seat.seatId=t_order.seatId ");
		sql.append(" AND t_order.id='");
		sql.append(id);
		sql.append("'");
		try {
			conn = DButil.getInstance().getCon();
			ps = conn.prepareStatement(sql.toString());
			rs = ps.executeQuery();
			view = this.changeRsToView(rs);
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
	 * 查询所有
	 */
	public List<Order> queryAll() {
		List<Order> list = new ArrayList<Order>();
		StringBuffer sql = new StringBuffer();
		sql
				.append("SELECT t_order.*,t_user.name userName,t_seat.location FROM t_order,t_user,t_seat ");
		sql.append(" WHERE t_order.user_id=t_user.id");
		sql.append(" AND t_seat.seatId=t_order.seatId ");
		try {
			conn = DButil.getInstance().getCon();
			ps = conn.prepareStatement(sql.toString());
			rs = ps.executeQuery();
			list = changeResultSet(rs);
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

	// 按用户 ID 查询,三表相关联
	public List<Order> queryByUserId(int id) {
		List<Order> list = new ArrayList<Order>();
		StringBuffer sql = new StringBuffer();
		sql
				.append("SELECT t_order.*,t_user.name userName,t_seat.location FROM t_order,t_user,t_seat ");
		sql.append(" WHERE t_order.user_id=t_user.id");
		sql.append(" AND t_seat.seatId=t_order.seatId ");
		sql.append(" AND t_user.id=");
		sql.append(id);
		try {
			conn = DButil.getInstance().getCon();
			ps = conn.prepareStatement(sql.toString());
			rs = ps.executeQuery();
			list = changeResultSet(rs);
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
	private List<Order> changeResultSet(ResultSet rs) {
		// TODO Auto-generated method stub
		List<Order> list = new ArrayList<Order>();
		Order view = null;
		if (rs == null) {
			System.out.println("*************结果集为空*************");
			return list;
		}
		try {
			while (rs.next()) {

				view = new Order();
				view.setId(rs.getString("id"));
				view.setCreateTime(rs.getString("createTime"));
				view.setDemandTime(rs.getString("demandTime"));
				view.setMoney(rs.getString("money"));
				view.setSeatId(rs.getString("seatId"));
				view.setUser_id(rs.getInt("user_id"));
				view.setUserName(rs.getString("userName"));
				view.setLocation(rs.getString("location"));
				// view.setList(ddao.queryByOrderId(view.getId()));
				list.add(view);

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	/*
	 * 按 ID 删除
	 */
	public void deleteById(String id) {

		StringBuffer sql = new StringBuffer();
		sql.append("delete from t_order where id=?");
		try {
			conn = DButil.getInstance().getCon();
			conn.setAutoCommit(false);
			ps = conn.prepareStatement(sql.toString());
			ps.setString(1, id);
			ps.executeUpdate();
			ddao.deleteById(id, conn);
			conn.commit();

		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
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
			}
		}
	}

	/*
	 * 结果集到实体对象的转换
	 */
	private Order changeRsToView(ResultSet rs) throws Exception {
		// TODO Auto-generated method stub
		Order view = new Order();
		if (rs.next()) {

			view.setId(rs.getString("id"));
			view.setCreateTime(rs.getString("createTime"));
			view.setDemandTime(rs.getString("demandTime"));
			view.setMoney(rs.getString("money"));
			view.setSeatId(rs.getString("seatId"));
			view.setLocation(rs.getString("location"));
			view.setUser_id(rs.getInt("user_id"));
			view.setUserName(rs.getString("userName"));
			view.setList(ddao.queryByOrderId(view.getId()));
		}
		return view;
	}

	/*
	 * 查询 按用户名 或 日期 或 Id
	 */
	public List<Order> query(String username, String demandTime,String orderId) throws Exception {
		List<Order> list = new ArrayList<Order>();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT t_order.*,t_user.name userName,t_seat.location FROM t_order,t_user,t_seat ");
		sql.append(" WHERE t_order.user_id=t_user.id");
		sql.append(" AND t_seat.seatId=t_order.seatId ");
		if (!"".equals(username)) {
			sql.append(" AND t_user.name LIKE '%");
			sql.append(username);
			sql.append("%'");
		}
		if (!"".equals(demandTime)) {
			sql.append(" AND t_order.demandTime='");
			sql.append(demandTime);
			sql.append("'");
		}
		if (!"".equals(orderId)) {
			sql.append(" AND t_order.id='");
			sql.append(orderId);
			sql.append("'");
		}
		conn = DButil.getInstance().getCon();
		ps = conn.prepareStatement(sql.toString());
		rs = ps.executeQuery();
		list = changeResultSet(rs);

		if (ps != null)
			ps.close();
		if (conn != null)
			conn.close();

		return list;
	}
}
