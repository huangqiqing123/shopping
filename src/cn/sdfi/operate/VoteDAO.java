package cn.sdfi.operate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import cn.sdfi.model.Vote;
import cn.sdfi.tools.DButil;

public class VoteDAO {

	private PreparedStatement ps = null;

	private ResultSet rs = null;

	private Connection conn = null;

	private List<Vote> list = null;

	StringBuffer sql = new StringBuffer();

	/*
	 * 投票
	 */
	public int doVote(int id) throws Exception{
		conn=DButil.getInstance().getCon();
		PreparedStatement ps=conn.prepareStatement("update t_vote set number=number+1 where id=?");
		ps.setInt(1,id);
		return ps.executeUpdate();
		}
	/*
	 * 查询所有记录
	 */
	public List<Vote> queryAll() throws Exception {

		conn = DButil.getInstance().getCon();
		sql.append("SELECT * FROM 	t_vote");
		ps = conn.prepareStatement(sql.toString());
		rs = ps.executeQuery();
		list = changeRsToList(rs);
		if (ps != null)
			ps.close();
		if (conn != null)
			conn.close();
		return list;
		
	}
/*
 * 由结果集到 List 的转换
 */
	private List<Vote> changeRsToList(ResultSet rs) throws Exception {
		// TODO Auto-generated method stub
		list=new ArrayList<Vote>();
		Vote view=null;
		while (rs.next()) {
			view=new Vote();
			view.setId(rs.getInt("id"));
			view.setIterm(rs.getString("iterm"));
			view.setNumber(rs.getInt("number"));
			list.add(view);
		}
		return list;
	}

	/*
	 *  获取总的票数
	 */
	public int getAllVotesNumber() throws Exception {
		int total = 0;
		conn = DButil.getInstance().getCon();
		ps = conn.prepareStatement("select sum(number) as totnum from t_vote");
		ResultSet rs = ps.executeQuery();
		if (rs.next()) {
			total = rs.getInt("totnum");
		}

		if (ps != null)
			ps.close();
		if (conn != null)
			conn.close();

		return total;
	}
}