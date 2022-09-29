package controller;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import conn.HibernateConnection;
import bean.Activity;
import bean.Bus;
import bean.Driver;
import bean.Login;
import bean.Parent;
import bean.User;

public class BusManager {
	private static String SALT = "123456";

	public List<Bus> listAllBus() {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			List<Bus> bus = session.createQuery("From Bus").list();
			session.close();
			
			return bus;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Bus> getBusById(String num_plate) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			List<Bus> bus = session.createQuery("From Bus where num_plate="+num_plate).list();
			session.close();
			
			return bus;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public Bus getBusDetailsByDriverId(String driverId) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			Bus bus = (Bus) session.createQuery("From Bus where Driver_IDCard="+driverId).getSingleResult();
			session.close();
			
			return bus;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public String editBus(Bus bus) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();

			Session session = sessionFactory.openSession();
			Transaction t = session.beginTransaction();
			session.update(bus);
			t.commit();
			session.close();
			return "successfully saved";
		} catch (Exception e) {
			return "failed to edit bus";
		}
	}

}
