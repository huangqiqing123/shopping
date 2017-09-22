package cn.sdfi.tools;

import org.apache.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {

	private static Logger log = Logger.getLogger(HibernateUtil.class);
	private static final SessionFactory sessionFactory;
	static {
		try{
			//在辅助类中从Configuration得到sessionFactory
			sessionFactory = new Configuration().configure().buildSessionFactory();
		}catch(Throwable e){
			log.error(e);
	        //System.out.println("01"+e);
			throw new ExceptionInInitializerError(e);
		}
	}
	
	/**
	  使用ThreadLocal可以有效隔离执行所使用的数据，所以避开了Session的多线程之间的数据共享问题。
	  使用ThreadLocal thread_var=new ThreadLocal()语句生成的变量是一个只在当前线程有效的
	 变量，也就是说不同线程所拥有的thread_var变量是不一样的。在这个变量内可以用set(object)方
	 法放置保存一个对象，只要这个线程没有结束，都可以通过thread_var变量的get方法取出原先放入的
	 对象。
	 */
	//保持一个单例的模式所使用的ThreadLocal类
	private static final ThreadLocal<Session> thread_var = new ThreadLocal<Session>();
	
	public static Session currentSession(){//该方法相当于创建到数据库的连接
		
		//从ThreadLocal类中取得一个session实例
		Session s = (Session)thread_var.get();
		//若该session实例为空，则创建一个新的session实例
		if (s==null){
			//根据sessionFactory创建session实例
			s = sessionFactory.openSession();
			thread_var.set(s);//将创建的session实例放入当前线程中
		}
		return s;
	}
	
	public static void closeSession(){//该方法相当于关闭到数据库的连接
		Session s = (Session)thread_var.get();
		if (s!=null){
			s.close();
		}
		thread_var.set(null);
	}
	
	public static void main(String[] args){
		System.out.println(HibernateUtil.currentSession().hashCode());
		HibernateUtil.closeSession();
	}
}
