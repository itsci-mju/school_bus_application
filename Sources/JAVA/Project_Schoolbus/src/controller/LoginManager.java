package controller;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import conn.HibernateConnection;
import bean.Login;
import bean.Parent;
import bean.User;

public class LoginManager {
	private static String SALT = "123456";

	public String insertLogin(Login login) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();

			Session session = sessionFactory.openSession();
			Transaction t = session.beginTransaction();
			session.saveOrUpdate(login);
			t.commit();
			session.close();
			return "successfully saved";
		} catch (Exception e) {
			return "failed to save login";
		}
	}
	
	public String doHibernateLogin(Login login) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			List<Login> Checklogin = session.createQuery("From Login where username='" + login.getUsername() +"'").list();
			session.close();
			
			if (Checklogin.size() == 1) {
				if (login.getPassword().equals(Checklogin.get(0).getPassword())) {
					return "login success";
				} else {
					return "username or password does't match";
				}
			} else {
				return "username or password does't match";
			}
		} catch (Exception e) {
			return "Please try again...";
		}
	}
	
	public Login getLoginDetails(String username) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			Login login = (Login) session.createQuery("From Login where username ='"+username+"'").getSingleResult();
			session.close();
			
			return login;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	
	
	

}
