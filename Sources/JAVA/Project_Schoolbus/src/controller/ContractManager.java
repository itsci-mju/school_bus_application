package controller;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.query.Query;

import bean.Activity;
import bean.Children;
import bean.Contract;
import bean.Login;
import bean.RequestCancel;
import conn.HibernateConnection;

public class ContractManager {
	public String insertContract(Contract contract) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();

			Session session = sessionFactory.openSession();
			Transaction t = session.beginTransaction();
			session.saveOrUpdate(contract);
			t.commit();
			session.close();
			return "successfully saved";
		} catch (Exception e) {
			return "failed to save contract";
		}
	}
	
	public List<Contract> listAllContracts() {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			List<Contract> contracts = session.createQuery("From Contract").list();
			session.close();
			
			return contracts;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public String countID() {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
		
			session.beginTransaction();
			String sql = "SELECT count(contract_ID) FROM contract;";
			SQLQuery query = session.createSQLQuery(sql);
			String result = query.getSingleResult().toString();
		
			
			return result;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Contract> listAllApprovedContracts(String IDCard) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			List<Contract> contracts = session.createQuery("Select c From Contract c where c.children.parent.IDCard ='"+IDCard+"' and c.status = 2 ").list();
			session.close();
			
			return contracts;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Contract> listAllUnApprovedContracts(String IDCard) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			List<Contract> contracts = session.createQuery("Select c From Contract c where c.children.parent.IDCard ='"+IDCard+"' and c.status = 1 ").list();
			session.close();
			
			return contracts;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Contract> listAllOtherContracts(String IDCard) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			List<Contract> contracts = session.createQuery("Select c From Contract c where c.children.parent.IDCard ='"+IDCard+"' and c.status = 3 ").list();
			session.close();
			
			return contracts;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Contract> listAllApprovedCancel(String IDCard) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			List<Contract> contracts = session.createQuery("Select c From Contract c where c.children.parent.IDCard ='"+IDCard+"' and c.status = 3 ").list();
			session.close();
			
			return contracts;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public Contract getContractsDetailsByID(String contract_ID) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			Contract contract = (Contract) session.createQuery("From Contract where contract_ID ='"+contract_ID+"'").getSingleResult();
			session.close();
			
			return contract;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Contract> getContractsDetailsByidchildren(String children_ID) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			
			session.beginTransaction();
			List<Contract> contract = (List<Contract>) session.createQuery("From Contract where status ='2' and Children_IDCard = '"+children_ID+"'").list();
			session.close();
			
			return contract;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public String deleteContract(String contract_ID) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();

			Session session = sessionFactory.openSession();
			Transaction t = session.beginTransaction();
			Query q = session.createQuery("delete Contract where contract_ID ='"+contract_ID+"'");
			q.executeUpdate();
			t.commit();
			session.close();
			return "successfully delete";
		} catch (Exception e) {
			return "failed to delete Contract";
		}
	}
	
	
	/**************************** Driver ********************************/
	
	
	public List<Contract> Driver_listAllUnApproveds(String num_plate) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			List<Contract> contracts = session.createQuery("SELECT c FROM Contract c "
					+ "where c.route.bus.num_plate = '"+num_plate+"' and c.status = 1").list();
			session.close();
			
			return contracts;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<RequestCancel> Driver_listAllRequestCancel(String num_plate) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			List<RequestCancel> requests = session.createQuery("SELECT rc FROM Contract c INNER JOIN c.route r on c.route.route_ID = r.route_ID\r\n"
					+ "INNER JOIN RequestCancel rc on c.contract_ID = rc.contract.contract_ID\r\n"
					+ "where r.bus.num_plate = '"+num_plate+"' and rc.status_request = 1 and c.status = 2").list();
			session.close();
			
			return requests;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public RequestCancel Driver_getRequestCancel(String request_ID) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			RequestCancel requests = (RequestCancel) session.createQuery("From RequestCancel where request_ID ='"+request_ID+"'").getSingleResult();
			session.close();
			
			return requests;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public String UpdateStatusCancel(String contract_ID) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();

			session.beginTransaction();
			String sql = "UPDATE contract c, requestcancel rc SET \r\n"
					+ "c.status = 3,\r\n"
					+ "rc.status_request = 2\r\n"
					+ "WHERE c.contract_ID = '"+contract_ID+"'  and rc.Contract_contract_ID = '"+contract_ID+"'";
			SQLQuery sqlQuery = session.createSQLQuery(sql);
			sqlQuery.executeUpdate();
			session.close();
			
			return "successfully updated";
			
		} catch (Exception e) {
			return "failed to updated";
		}
	}
	
	public String UpdateStatusApplication(String contract_ID,String date) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();

			session.beginTransaction();
			String sql = "UPDATE contract SET\r\n"
					+ "status = 2,\r\n"
					+ "approve_date = '"+date+"'\r\n"
					+ "WHERE contract_ID = '"+contract_ID+"'";
			SQLQuery sqlQuery = session.createSQLQuery(sql);
			sqlQuery.executeUpdate();
			session.close();
			
			return "successfully updated";
			
		} catch (Exception e) {
			return "failed to updated";
		}
	}
	
	public List<Contract> Driver_listAllChildren(String num_plate) {
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			List<Contract> contracts = session.createQuery("SELECT c FROM Contract c "
					+ "where c.route.bus.num_plate = '"+num_plate+"' and c.status = 2").list();
			session.close();
			
			return contracts;
			
		} catch (Exception e) {
			return null;
		}
	}


	
	public List<Contract> Driver_listAllChildren1(String num_plate) {
		List<Contract> contracts = new ArrayList<>();
		RouteManager rm = new RouteManager();
		ChildrenManager cmg = new ChildrenManager();
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			String sql = "SELECT distinct c.contract_ID,c.contract_date,c.start_date ,c.end_date ,c.pick_up_latitude ,c.pick_up_longitude ,c.pick_up_time ,c.approve_date ,c.status ,c.Children_IDCard ,c.Route_route_ID"
					+ " FROM Contract c join activity a on c.contract_ID = a.Contract_contract_ID  join route r on c.Route_route_ID = r.route_ID join bus b on r.Bus_num_plate = b.num_plate"
					+ " where b.num_plate = '"+num_plate+"' and c.status = 2 and c.contract_ID not in (SELECT Contract_contract_ID from activity where (time_of_date = 1 ) AND CAST(get_up_time AS DATE) = CAST(CURDATE() AS DATE) AND CAST(get_off_time AS DATE) = CAST(CURDATE() AS DATE) )";
			SQLQuery query = session.createSQLQuery(sql);
			List<Object[]> result2 = query.list();
			for (Object[] result : result2) {
				Contract s = new Contract(result[0].toString(),result[1].toString(),result[2].toString(),result[3].toString(),result[4].toString(),result[5].toString()
						,result[6].toString(),result[7].toString(),Integer.parseInt(result[8].toString()),cmg.getChildrenProfileByID(result[9].toString()),rm.getRoutebyID(result[10].toString()));
				contracts.add(s);
			}
			
			session.close();
			return contracts;
			
			
		} catch (Exception e) {
			return null;
		}
	}
	
	public List<Contract> Driver_listAllChildren2(String num_plate) {
		List<Contract> contracts = new ArrayList<>();
		RouteManager rm = new RouteManager();
		ChildrenManager cmg = new ChildrenManager();
		try {
			SessionFactory sessionFactory = HibernateConnection.doHibernateConnection();
			Session session = sessionFactory.openSession();
			session.beginTransaction();
			String sql = "SELECT distinct c.contract_ID,c.contract_date,c.start_date ,c.end_date ,c.pick_up_latitude ,c.pick_up_longitude ,c.pick_up_time ,c.approve_date ,c.status ,c.Children_IDCard ,c.Route_route_ID"
					+ " FROM Contract c join activity a on c.contract_ID = a.Contract_contract_ID  join route r on c.Route_route_ID = r.route_ID join bus b on r.Bus_num_plate = b.num_plate"
					+ " where b.num_plate = '"+num_plate+"' and c.status = 2 and c.contract_ID not in (SELECT Contract_contract_ID from activity where (time_of_date = 2 ) AND CAST(get_up_time AS DATE) = CAST(CURDATE() AS DATE) AND CAST(get_off_time AS DATE) = CAST(CURDATE() AS DATE) )";
			SQLQuery query = session.createSQLQuery(sql);
			List<Object[]> result2 = query.list();
			for (Object[] result : result2) {
				Contract s = new Contract(result[0].toString(),result[1].toString(),result[2].toString(),result[3].toString(),result[4].toString(),result[5].toString()
						,result[6].toString(),result[7].toString(),Integer.parseInt(result[8].toString()),cmg.getChildrenProfileByID(result[9].toString()),rm.getRoutebyID(result[10].toString()));
				contracts.add(s);
			}
			
			session.close();
			return contracts;
			
			
		} catch (Exception e) {
			return null;
		}
	}

}
