package cn.sdfi.operate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.apache.log4j.Logger;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;
import org.hibernate.criterion.Expression;
import org.hibernate.criterion.Order;
import cn.sdfi.model.User;
import cn.sdfi.tools.DButil;
import cn.sdfi.tools.HibernateUtil;

public class UserOperate {

	private Logger log = Logger.getLogger(UserOperate.class);

	private int pageSize = 5;

	public void add(User u) {
		Session session = HibernateUtil.currentSession();
		if (session == null) {
			log.error("Error when get HibernateSession");
			return;
		}
		// 只有放在事务中才能反映到数据库中
		Transaction tx = session.beginTransaction();
		session.save(u);
		tx.commit();
		// 记得关闭
		HibernateUtil.closeSession();
	}

	// 该对象至少需要包含关键字值
	public void delete(User u) {// 参数是一对象
		Session session = HibernateUtil.currentSession();
		if (session == null) {
			log.error("Error when get HibernateSession");
			return;
		}
		Transaction tx = session.beginTransaction();
		session.delete(u);
		tx.commit();

		HibernateUtil.closeSession();
	}
	/*
	 * 检查该用户名是否已被注册
	 */
	public boolean isUsed(String name) {
		Session session = HibernateUtil.currentSession();
		if (session == null) {
			log.error("Error when get HibernateSession");
			return true;
		}
		// 按 name 查询
		Criteria criteria = session.createCriteria(User.class);
		criteria.add(Expression.eq("name", name));
		List list = criteria.list();
		HibernateUtil.closeSession();
		if(list.size()>0) {
			return true;
		}
		else{
			return false;
		}
		
	}
	// 按 id 删除
	public void delete(int id) {
		Session session = HibernateUtil.currentSession();
		if (session == null) {
			log.error("Error when get HibernateSession");
			
		}
		// 1）类名要写完整包路径？不一定，写不写都可以的，但大小写是敏感的
		// 2）这个一个HQL查询（Hibernate Query Language）
		// 3）在select语句时，可以不要select子句
			Transaction tx = session.beginTransaction();// 显示的调用jdbc事务处理
			Query q = session
					.createQuery("delete from cn.sdfi.model.User where id="
							+ id);
			q.executeUpdate();
			tx.commit();
			HibernateUtil.closeSession();
		}

	// 更新操作 要求u中必需包含关键字值
	public void update(User u) {
		Session session = HibernateUtil.currentSession();
		if (session == null) {
			log.error("Error when get HibernateSession");
			return;
		}
		Transaction tx = session.beginTransaction();
		session.update(u);
		tx.commit();
		HibernateUtil.closeSession();
	}

	// 两种查询方法1）HQL；2）Criteria(标准） Query
	public List queryAll() {
		Session session = HibernateUtil.currentSession();
		if (session == null) {
			log.error("Error when get HibernateSession");
			return null;
		}
		List list = new ArrayList();// ArrayList实现了接口List

		// the first way
		// Query q = session.createQuery("from
		// com.data.model.User");//com.data.model.User均可
		// list = q.list();

		// the second way
		Criteria c = session.createCriteria(User.class);
		c.addOrder(Order.asc("id"));// 按ID升序排序
		list = c.list();

		Iterator i = list.iterator();// 迭代 测试
		while (i.hasNext()) {
			User s = (User) i.next();
			log.debug(s.getName() + " " + s.getSex());
			System.out.println(s.getName() + " " + s.getSex());
		}

		return list;
	}

	// 分页查询
	public List queryPage(int pageNo) {
		Session session = HibernateUtil.currentSession();
		if (session == null) {
			log.error("Error when get HibernateSession");
			return null;
		}
		List list = new ArrayList();

		int begin = pageSize * (pageNo - 1);// 该页的第一条记录
		// int end = pageSize * pageNo;//该页最后一条记录

		// 如下方式仅限于mysql jdbc ，在此不能实现
		// Query q = session.createQuery("from hibernate.model.Stu limit " +
		// begin + "," + end);
		// l = q.list();

		Criteria c = session.createCriteria(User.class);
		c.setMaxResults(pageSize);// 一次查询 最大记录数
		c.setFirstResult(begin);// 设定第一条记录的初始位置
		c.addOrder(Order.asc("id"));// 指定排序字段
		list = c.list();

		return list;
	}

	// 登录查询 姓名＋密码＋权限
	public List checkLogin(User user) {
		Session session = HibernateUtil.currentSession();
		Criteria criteria = session.createCriteria(User.class);
		criteria.add(Expression.eq("name", user.getName())).add(
				Expression.eq("privledge", user.getPrivledge())).add(
				Expression.eq("password", user.getPassword()));
		// criteria.add(Expression.like("name","lin%"));
		List list = criteria.list();
		return list;
	}

	// 带有查询条件:按姓名与权限查询，顺带解释一下复合查询
	public List query(User u) {
		Session session = HibernateUtil.currentSession();
		if (session == null) {
			log.error("Error when get HibernateSession");
			return null;
		}

		// Query query = session.createQuery("from User where name='" +
		// u.getName() +"'");
		// List list = query.list();// 通过 name 查询（第一种方式）
		// 按 name privledge 查询
		Criteria criteria = session.createCriteria(User.class);
		criteria.add(Expression.eq("name", u.getName())).add(
				Expression.eq("privledge", u.getPrivledge()));
		// criteria.add(Expression.like("name","lin%"));
		List list = criteria.list();

		// List list = session.createCriteria(User.class)
		// .add(Expression.eq("name",u.getName())).list();

		// //可以构造复杂条件
		// List list = session.createCriteria(User.class)
		// .add(Expression.eq("name",u.getName()))
		// .add(Expression.or(Expression.eq("name",u.getName()),Expression.ne("sex","1")))
		// .list();

		HibernateUtil.closeSession();
		return list;
	}

	// 带有查询条件:按姓名与权限查询，顺带解释一下复合查询
	public User query(String name, int privledge) {
		Session session = HibernateUtil.currentSession();
		if (session == null) {
			log.error("Error when get HibernateSession");
			return null;
		}
		// 按 name privledge 查询
		Criteria criteria = session.createCriteria(User.class);
		criteria.add(Expression.eq("name", name)).add(
				Expression.eq("privledge", privledge));
		List list = criteria.list();
		Iterator iter = list.iterator();// 迭代
		User user = null;
		while (iter.hasNext()) {
			user = (User) iter.next();
		}
		HibernateUtil.closeSession();
		return user;
	}

	// 按姓名与权限模糊查询
	public List queryWithBlur(User u) {
		Session session = HibernateUtil.currentSession();
		if (session == null) {
			log.error("Error when get HibernateSession");
			return null;
		}
		Criteria criteria = session.createCriteria(User.class);
		criteria.add(Expression.like("name", "%" + u.getName() + "%")).add(
				Expression.eq("privledge", u.getPrivledge()));
		List list = criteria.list();
		HibernateUtil.closeSession();
		return list;
	}

	// 主键加载get和load
	// get和load的区别：加载一个不存在的对象时，load会抛出异常，而get会返回null
	// 用load加载的数据，在会话关闭后，不再能够访问
	public User query(int id) {
		Session session = HibernateUtil.currentSession();
		if (session == null) {
			log.error("Error when get HibernateSession");
			return null;
		}
		User user = null;
		// user = (User)session.load(User.class,new Integer(id));
		// // 外部调用时报错,原因：用load加载的对象只有在session范围内才有效
		user = (User) session.get(User.class, new Integer(id));

		HibernateUtil.closeSession();
		return user;
	}

	// 计算总页数
	public int getPageCount() {
		int ret = 0;
		Session session = HibernateUtil.currentSession();
		if (session == null) {
			System.out.println("null");
			return 0;
		}

		Query query = session.createQuery("select count(*) from user");
		List list = query.list();
		ret = ((Integer) list.get(0)).intValue();

		ret = (int) Math.ceil(ret / (double) pageSize);

		HibernateUtil.closeSession();
		return ret;
	}

	// ...其他查询方法
	/*
	 * JDBC方式 更新
	 */
	public int updateBySql(User view){
		int flag=0;
		Connection conn = null;
		PreparedStatement ps=null;
		StringBuffer sql = new StringBuffer();
		sql.append("update t_user set picture=?,password=?,sex=?,address=?,phone=?,privledge=?,email=?,memo=? where id=?");
		try {
			conn = DButil.getInstance().getCon();
			ps = conn.prepareStatement(sql.toString());
			ps.setString(1, view.getPicture());
			
			ps.setString(2, view.getPassword());
			ps.setString(3, view.getSex());
			ps.setString(4, view.getAddress());
			ps.setString(5,view.getPhone());
			ps.setInt(6,view.getPrivledge());
			ps.setString(7,view.getEmail());
			ps.setString(8,view.getMemo());
			ps.setInt(9,view.getId());
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
}
