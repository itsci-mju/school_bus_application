package controller;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import bean.Bus;
import bean.Contract;
import bean.Driver;
import bean.Login;
import bean.Route;
import conn.HibernateConnection;

public class RouteManager {
	
	public String insertRoute(Route route) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();

			Session session = sessionFactory.openSession();
			Transaction t = session.beginTransaction();
			session.saveOrUpdate(route);
			t.commit();
			session.close();
			return "successfully saved";
		} catch (Exception e) {
			return "failed to save driver";
		}
	}
	
	public String countRouteID() {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
		
			session.beginTransaction();
			String sql = "SELECT count(route_ID) FROM route;";
			SQLQuery query = session.createSQLQuery(sql);
			String result = query.getSingleResult().toString();
		
			return result;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Route> listAllRoutes() {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			List<Route> routes = session.createQuery("From Route").list();
			session.close();
			
			return routes;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Route> listAllRoutesGroupBy() {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			
			List<Route> routes = session.createQuery("From Route r Group by Bus_num_plate,School_school_ID").list();
			session.close();
			
			return routes;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Route> getlistSchoolBusBySearch(String schoolname) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			List<Route> routes = session.createQuery("select r from Route r where r.school.school_name ='"+schoolname+"' "
					+ "Group by r.bus.num_plate,r.school.school_ID ").list();
			session.close();
			
			return routes;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Route> getSchoolBusDetails(String num_plate) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			
			List<Route> routes = session.createQuery("From Route where Bus_num_plate ='"+num_plate+"' Group by School_school_ID").list();
			session.close();
			
			return routes;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Route> getRouteBySchool(String num_plate,String school_ID) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			
			List<Route> routes = session.createQuery("From Route where Bus_num_plate ='"+num_plate+"' and School_school_ID = '"+school_ID +"'").list();
			session.close();
			
			return routes;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public Route getRoutebyID(String RouteID) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			Route route = (Route) session.createQuery("From Route where route_ID ='"+RouteID+"'").getSingleResult();
			session.close();
			
			return route;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Route> getRouteBySchoolName(String num_plate,String school_name) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			
			List<Route> routes = session.createQuery("From Route r where r.bus.num_plate ='"+num_plate+"' and r.school.school_name = '"+school_name +"'").list();
			session.close();
			
			return routes;
			
		} catch (Exception e) {
			return null;
		}
	}

}
