package controller;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import conn.HibernateConnection;
import bean.Login;
import bean.Parent;
import bean.User;

public class ParentManager {
	private static String SALT = "123456";

	public String insertParent(Parent parent,Login login) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();

			Session session = sessionFactory.openSession();
			Transaction t = session.beginTransaction();
			session.saveOrUpdate(login);
			session.saveOrUpdate(parent);
			t.commit();
			session.close();
			return "successfully saved";
		} catch (Exception e) {
			return "failed to save parent";
		}
	}
	
	public String editParent(Parent parent) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();

			Session session = sessionFactory.openSession();
			Transaction t = session.beginTransaction();
			session.update(parent);
			t.commit();
			session.close();
			return "successfully saved";
		} catch (Exception e) {
			return "failed to save parent";
		}
	}

	public String deleteUser(User user) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();

			Session session = sessionFactory.openSession();
			Transaction t = session.beginTransaction();
			session.delete(user);
			t.commit();
			session.close();
			return "successfully delete";
		} catch (Exception e) {
			return "failed to delete student";
		}
	}

	public List<Parent> listAllParents() {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			List<Parent> parents = session.createQuery("From Parent").list();
			session.close();
			
			return parents;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public Parent getParentProfileByUsername(String username) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			Parent parent = (Parent) session.createQuery("From Parent where Login_username = '" + username+"'").getSingleResult();
			session.close();
			
			return parent;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public Parent getParentProfileByID(String ID) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			Parent parent = (Parent) session.createQuery("From Parent where IDCard = '" + ID+"'").getSingleResult();
			session.close();
			
			return parent;
			
		} catch (Exception e) {
			return null;
		}
	}
	
}
