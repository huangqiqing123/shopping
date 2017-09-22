package cn.sdfi.operate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import cn.sdfi.model.Message;
import cn.sdfi.tools.DButil;

public class MessageDAO {

	private Connection conn = null;

	private PreparedStatement ps = null;

	private int flag = 0;

	private ResultSet rs = null;

	/*
	 * 执行保存
	 */
	public int save(Message view) {

		StringBuffer sql = new StringBuffer();
		sql
				.append("insert into t_message(title,content,leaveTime,userId)values(?,?,?,?)");
		try {
			conn = DButil.getInstance().getCon();
			ps = conn.prepareStatement(sql.toString());
			ps.setString(1, view.getTitle());
			ps.setString(2, view.getContent());
			ps.setString(3, view.getLeaveTime());
			ps.setInt(4, view.getUserId());

			flag = ps.executeUpdate();
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
	public List<Message> queryAll() {

		List<Message> list = new ArrayList<Message>();
		StringBuffer sql = new StringBuffer();
		sql
				.append("SELECT t_message.*,t_user.name userName FROM  t_message,t_user");
		sql.append(" WHERE t_message.userId=t_user.id ");
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
	private List<Message> changeResultSet(ResultSet rs) {
		// TODO Auto-generated method stub
		List<Message> list = new ArrayList<Message>();
		Message view = null;
		if (rs == null) {
			System.out.println("*************结果集为空*************");
			return list;
		}
		try {
			while (rs.next()) {
				view = new Message();
				view.setContent(rs.getString("content"));
				view.setLeaveTime(rs.getString("leaveTime"));
				view.setTitle(rs.getString("title"));
				view.setId(rs.getInt("id"));
				view.setUserId(rs.getInt("userId"));
				view.setUserName(rs.getString("userName"));
				view.setReply(rs.getString("reply"));
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
	public int deleteById(String id) throws Exception {

		StringBuffer sql = new StringBuffer();
		sql.append("delete from t_message where id=");
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

	// 按 ID 查询
	public Message queryById(String id) {

		Message view = null;
		StringBuffer sql = new StringBuffer();
		sql
				.append("SELECT t_message.*,t_user.name userName FROM  t_message,t_user");
		sql.append(" WHERE t_message.userId=t_user.id ");
		sql.append(" AND t_message.id=");
		sql.append(id);
		try {
			conn = DButil.getInstance().getCon();
			ps = conn.prepareStatement(sql.toString());
			rs = ps.executeQuery();
			view = changeRsToView(rs);

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
	private Message changeRsToView(ResultSet rs) throws Exception {
		// TODO Auto-generated method stub
		Message view = null;
		if (rs.next()) {
			view = new Message();
			view.setContent(rs.getString("content"));
			view.setLeaveTime(rs.getString("leaveTime"));
			view.setTitle(rs.getString("title"));
			view.setId(rs.getInt("id"));
			view.setUserId(rs.getInt("userId"));
			view.setUserName(rs.getString("userName"));
			view.setReply(rs.getString("reply"));
		}
		return view;
	}
/*
 * 回复留言
 */
	public int reply(String id, String reply) throws Exception {
		StringBuffer sql = new StringBuffer();
		sql.append("update t_message set reply=? where id=?");
		conn = DButil.getInstance().getCon();
		ps = conn.prepareStatement(sql.toString());
		ps.setString(1,reply);
		ps.setString(2,id);
		flag = ps.executeUpdate();

		if (ps != null)
			ps.close();
		if (conn != null)
			conn.close();

		return flag;
	}
}
