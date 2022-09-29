package controller;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import conn.HibernateConnection;
import bean.Bus;
import bean.Children;
import bean.Contract;
import bean.Driver;
import bean.Login;
import bean.Parent;
import bean.School;
import bean.User;

public class DriverManager {
	private static String SALT = "123456";
	
	public String insertDriver(Driver driver,Login login,Bus bus) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();

			Session session = sessionFactory.openSession();
			Transaction t = session.beginTransaction();
			session.saveOrUpdate(login);
			session.saveOrUpdate(driver);
			session.saveOrUpdate(bus);
			t.commit();
			session.close();
			return "successfully saved";
		} catch (Exception e) {
			return "failed to save driver";
		}
	}
	
	public Driver getProfileDriverByID(String IDCard) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			Driver driver = (Driver) session.createQuery("From Driver where IDCard = '" + IDCard+"'").getSingleResult();
			session.close();
			
			return driver;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public String editProfile(Driver driver,Bus bus) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();

			Session session = sessionFactory.openSession();
			Transaction t = session.beginTransaction();
			session.update(driver);
			session.update(bus);
			t.commit();
			session.close();
			return "successfully saved";
		} catch (Exception e) {
			return "failed to save Profile";
		}
	}
	
	public String UpdateService(Bus bus) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();

			Session session = sessionFactory.openSession();
			Transaction t = session.beginTransaction();
			session.update(bus);
			t.commit();
			session.close();
			return "successfully UpdateService";
		} catch (Exception e) {
			return "failed to save UpdateService";
		}
	}

	public List<Driver> listAllDrivers() {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			List<Driver> drivers = session.createQuery("From Driver").list();
			session.close();
			
			return drivers;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public Driver getDriverProfileByUsername(String username) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			Driver driver = (Driver) session.createQuery("From Driver where Login_username = '" + username+"'").getSingleResult();
			session.close();
			
			return driver;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public String getSeats_amountById(String num_plate) {
		String result = "";
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			String sql = "select seats_amount from bus\n"
					+ "where num_plate = '"+num_plate+"';";
			SQLQuery query = session.createSQLQuery(sql);
			result = query.getSingleResult().toString();
		
			
			session.close();
			
			return result;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public String calChildrenInCar(String num_plate) {
		String result = "";
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			String sql = "select count(c.Children_IDCard) as sumChildren from contract c join Route r on c.Route_route_ID = r.route_ID\n"
					+ "where r.Bus_num_plate = '"+num_plate+"' and c.status = 2;";
			SQLQuery query = session.createSQLQuery(sql);
			result = query.getSingleResult().toString();
		
			
			session.close();
			
			return result;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public String calRequestApply(String num_plate) {
		String result = "";
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			String sql = "select count(c.Children_IDCard) as sumChildren from contract c join Route r on c.Route_route_ID = r.route_ID\n"
					+ "where r.Bus_num_plate = '"+num_plate+"' and c.status = 1;";
			SQLQuery query = session.createSQLQuery(sql);
			result = query.getSingleResult().toString();
		
			
			session.close();
			
			return result;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public String calRequestCancel(String num_plate) {
		String result = "";
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			String sql = "select count(*) as sumRequest from contract c join requestcancel rc on(c.contract_ID = rc.Contract_contract_ID)\n"
					+ "join route r on c.Route_route_ID = r.route_ID\n"
					+ "where r.bus_num_plate = '"+num_plate+"' and rc.status_request = 1;";
			SQLQuery query = session.createSQLQuery(sql);
			result = query.getSingleResult().toString();
		
			
			session.close();
			
			return result;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Contract> listRequestApply(String num_plate) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			List<Contract> contracts = session.createQuery("From Contract c where c.route.Bus_num_plate = '" + num_plate+"' and c.status = 1").list();
			session.close();

			return contracts;
			
		} catch (Exception e) {
			return null;
		}
	}

}
