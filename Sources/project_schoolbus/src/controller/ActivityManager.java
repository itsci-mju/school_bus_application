
package controller;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.TimeZone;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.NativeQuery;

import bean.Activity;
import bean.Bus;
import bean.Children;
import bean.Driver;
import bean.Login;
import bean.Route;
import bean.School;
import conn.HibernateConnection;

public class ActivityManager {
	private static String SALT = "123456";
	
	public String insertactivity(Activity activity) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();

			Session session = sessionFactory.openSession();
			Transaction t = session.beginTransaction();
			session.saveOrUpdate(activity);
			t.commit();
			session.close();
			
			return "successfully saved";
		} catch (Exception e) {
			return "failed to save activity";
		}
	}
	
	public String countID() {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
		
			session.beginTransaction();
			String sql = "SELECT count(activity_ID) FROM activity;";
			SQLQuery query = session.createSQLQuery(sql);
			String result = query.getSingleResult().toString();
		
			
			return result;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Activity> listAllAC() {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			List<Activity> activity = session.createQuery("From Activity ").list();
			session.close();
			
			return activity;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Activity> listacbyid(String id) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			List<Activity> activity = session.createQuery("From Activity where Contract_contract_ID = '"+id+"'").list();
			session.close();
			
			return activity;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	
	public List<Activity> listACis1() {
		
		ContractManager cm = new ContractManager();
		List<Activity> activitys = new ArrayList<>();
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
			String sql = "SELECT * From Activity where time_of_date = 1 AND CAST(get_up_time AS DATE) = CAST(CURDATE() AS DATE)";
			SQLQuery query = session.createSQLQuery(sql);
			List<Object[]> result2 = query.list();
			for (Object[] result : result2) {
				Activity s = new Activity(result[0].toString(),result[1].toString(),result[2].toString(),result[3].toString(),result[4].toString(),result[5].toString()
						,result[6].toString(),result[7].toString(),Integer.parseInt(result[8].toString()),result[9].toString(),cm.getContractsDetailsByID(result[10].toString()));
				activitys.add(s);
			}
			
			session.close();
			
			return activitys;
			
		} catch (Exception e) {
			return null;
		}
		
	}
	public List<Activity> listACis2() {
		
		ContractManager cm = new ContractManager();
		List<Activity> activitys = new ArrayList<>();
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			TimeZone.setDefault(TimeZone.getTimeZone("UTC"));
			String sql = "SELECT * From Activity where time_of_date = 2 AND CAST(get_up_time AS DATE) = CAST(CURDATE() AS DATE)";
			SQLQuery query = session.createSQLQuery(sql);
			List<Object[]> result2 = query.list();
			for (Object[] result : result2) {
				Activity s = new Activity(result[0].toString(),result[1].toString(),result[2].toString(),result[3].toString(),result[4].toString(),result[5].toString()
						,result[6].toString(),result[7].toString(),Integer.parseInt(result[8].toString()),result[9].toString(),cm.getContractsDetailsByID(result[10].toString()));
				activitys.add(s);
			}
			
			session.close();
			
			return activitys;
			
		} catch (Exception e) {
			return null;
		}
		
	}
	
	public List<Activity> listACisorday1() {
		
		ContractManager cm = new ContractManager();
		List<Activity> activitys = new ArrayList<>();
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			String sql = "SELECT * From Activity where (time_of_date between 1 and 3) AND CAST(get_up_time AS DATE) = CAST(CURDATE() AS DATE) AND CAST(get_off_time AS DATE) = CAST(CURDATE() AS DATE)";
			SQLQuery query = session.createSQLQuery(sql);
			List<Object[]> result2 = query.list();
			for (Object[] result : result2) {
				Activity s = new Activity(result[0].toString(),result[1].toString(),result[2].toString(),result[3].toString(),result[4].toString(),result[5].toString()
						,result[6].toString(),result[7].toString(),Integer.parseInt(result[8].toString()),result[9].toString(),cm.getContractsDetailsByID(result[10].toString()));
				activitys.add(s);
			}
			
			session.close();
			
			return activitys;
			
		} catch (Exception e) {
			return null;
		}
		
	}
	
	public String editActivity(Activity activity) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();

			Session session = sessionFactory.openSession();
			Transaction t = session.beginTransaction();
			session.update(activity);
			t.commit();
			session.close();
			return "successfully saved";
		} catch (Exception e) {
			return "failed to edit activity";
		}
	}
	
	

	
}
