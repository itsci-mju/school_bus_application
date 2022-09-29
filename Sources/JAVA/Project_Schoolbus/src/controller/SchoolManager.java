package controller;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import conn.HibernateConnection;
import bean.Bus;
import bean.Driver;
import bean.Login;
import bean.Parent;
import bean.Route;
import bean.School;
import bean.User;

public class SchoolManager {
	private static String SALT = "123456";

	
	public List<School> listAllSchool(String num_plate) {
		List<School> schools = new ArrayList<>();
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			String sql = "select school.school_ID,school.school_name FROM bus \n"
					+ "INNER JOIN school_bus on bus.num_plate = school_bus.Bus_num_plate \n"
					+ "inner join school on school_bus.School_school_ID = school.school_ID\n"
					+ "where bus.num_plate = '"+num_plate+"'";
			SQLQuery query = session.createSQLQuery(sql);
			List<Object[]> result2 = query.list();
			for (Object[] result : result2) {
				School s = new School(result[0].toString(),result[1].toString(),result[2].toString(),result[3].toString());
				schools.add(s);
			}
			
			session.close();
			
			return schools;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<School> listAllSchool() {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			List<School> schools = session.createQuery("From School").list();
			session.close();
			
			return schools;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public School getSchool(String school_ID) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();

			School school = (School) session.createQuery("From School where school_ID = '"+school_ID+"'").getSingleResult();
			session.close();
			
			return school;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	
	

}
