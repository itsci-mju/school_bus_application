package controller;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import bean.Children;
import bean.Login;
import bean.Parent;
import bean.User;
import conn.HibernateConnection;

public class ChildrenManager {
	
	public String insertChildren(Children children,Login login) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();

			Session session = sessionFactory.openSession();
			Transaction t = session.beginTransaction();
			session.saveOrUpdate(login);
			session.saveOrUpdate(children);
			t.commit();
			session.close();
			return "successfully saved";
		} catch (Exception e) {
			return "failed to save Children";
		}
	}
	
	public String editChildren(Children children) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();

			Session session = sessionFactory.openSession();
			Transaction t = session.beginTransaction();
			session.update(children);
			t.commit();
			session.close();
			return "successfully saved";
		} catch (Exception e) {
			return "failed to edit children";
		}
	}
	
	public String deleteChildren(String IDcard) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();

			Session session = sessionFactory.openSession();
			Transaction t = session.beginTransaction();
			Query q = session.createQuery("delete Children where IDCard ='"+IDcard+"'");
			q.executeUpdate();
			t.commit();
			session.close();
			return "successfully delete";
		} catch (Exception e) {
			return "failed to delete children";
		}
	}
	
	public List<Children> listAllChildrens(String ParentIDCard) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			List<Children> childrens = session.createQuery("From Children where Parent_IDCard="+ParentIDCard).list();
			session.close();
			
			return childrens;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Children> listAllChildrens() {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			List<Children> childrens = session.createQuery("From Children").list();
			session.close();
			
			return childrens;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Children> listAllChildrensById(String parentID) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			List<Children> childrens = session.createQuery("From Children where Parent_IDCard ="+parentID).list();
			session.close();
			
			return childrens;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public Children getChildrenProfileByID(String ID) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			Children children = (Children) session.createQuery("From Children where IDCard = '" + ID+"'").getSingleResult();
			session.close();
			
			return children;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public Children getChildrenProfileByUsername(String username) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			Children children = (Children) session.createQuery("From Children where Login_username = '" + username+"'").getSingleResult();
			session.close();
			
			return children;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Children> listAllChildrensApply(String parentID) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			List<Children> childrens = session.createQuery("Select cd from Children cd \r\n"
					+ "join Parent p on p.IDCard = cd.parent.IDCard\r\n"
					+ "where cd.parent.IDCard = '"+parentID+"' and cd.IDCard\r\n"
					+ "NOT IN(SELECT c.children.IDCard from Contract c where c.status in(1,2))\r\n"
					+ "").list();
			session.close();
			
			return childrens;
			
		} catch (Exception e) {
			return null;
		}
	}

}
