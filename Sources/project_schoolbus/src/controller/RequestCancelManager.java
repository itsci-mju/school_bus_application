package controller;

import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import bean.Contract;
import bean.RequestCancel;
import conn.HibernateConnection;

public class RequestCancelManager {
	
	public String insertRequest(RequestCancel request) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();

			Session session = sessionFactory.openSession();
			Transaction t = session.beginTransaction();
			session.saveOrUpdate(request);
			t.commit();
			session.close();
			return "successfully saved";
		} catch (Exception e) {
			return "failed to save request";
		}
	}
	
	public String countID() {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
		
			session.beginTransaction();
			String sql = "SELECT count(request_ID) FROM requestcancel;";
			SQLQuery query = session.createSQLQuery(sql);
			String result = query.getSingleResult().toString();
		
			
			return result;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<RequestCancel> listAllRequestCancels() {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			List<RequestCancel> requests = session.createQuery("From RequestCancel").list();
			session.close();
			
			return requests;
			
		} catch (Exception e) {
			return null;
		}
	}

}
