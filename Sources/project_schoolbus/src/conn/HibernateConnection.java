package conn;

import java.util.Properties;


import org.hibernate.SessionFactory;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.cfg.Configuration;

import bean.Bus;
import bean.Children;
import bean.Contract;
import bean.Driver;
import bean.Login;
import bean.Parent;
import bean.RequestCancel;
import bean.Route;
import bean.School;
import bean.Activity;

public class HibernateConnection {
	public static SessionFactory sessionFactory;
	static String url = "jdbc:mysql://localhost:3306/project_schoolbus?characterEncoding=UTF-8&&serverTimezone=UTC"; 
	static String uname = "root";
	static String pwd = "1234";
	
	public static SessionFactory doHibernateConnection(){
		Properties database = new Properties();
		//database.setProperty("hibernate.hbm2ddl.auto", "create"); 
		database.setProperty("hibernate.connection.driver_class","com.mysql.jdbc.Driver");
		database.setProperty("hibernate.connection.username",uname);
		database.setProperty("hibernate.connection.password",pwd);
		database.setProperty("hibernate.connection.url",url);
		database.setProperty("hibernate.dialect","org.hibernate.dialect.MySQL5InnoDBDialect");
		Configuration cfg = new Configuration()
							.setProperties(database)
							.addPackage("bean")
							.addAnnotatedClass(Parent.class)
							.addAnnotatedClass(Login.class)
							.addAnnotatedClass(Children.class)
							.addAnnotatedClass(Driver.class)
							.addAnnotatedClass(Bus.class)
							.addAnnotatedClass(Route.class)
							.addAnnotatedClass(School.class)
							.addAnnotatedClass(Contract.class)
							.addAnnotatedClass(Activity.class)
							.addAnnotatedClass(RequestCancel.class);
		StandardServiceRegistryBuilder ssrb = new StandardServiceRegistryBuilder().applySettings(cfg.getProperties());
		sessionFactory = cfg.buildSessionFactory(ssrb.build());
		return sessionFactory;
	}
}
