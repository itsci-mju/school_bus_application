package controller;

import java.util.HashMap;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import bean.Bus;
import bean.Children;
import bean.Contract;
import bean.Driver;
import bean.Login;
import bean.Parent;
import bean.Route;
import bean.School;
import bean.User;

@Controller
public class RouteController {
	private static String SALT = "123456";
	

	@RequestMapping(value = "/route/add", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_Addroute(@RequestBody Map<String, String> map) {
		String message = "";
		List<Route> routes = null;
		try {
			Gson gson = new Gson();
			Route route = gson.fromJson(map.get("routes"), Route.class);
			System.out.println(route.getRoute_ID()+" "+route.getRoute_details()+" "+route.getRoute_mapURL()+" "+
					route.getBus().getNum_plate()+" "+route.getSchool().getSchool_name());
			RouteManager rm = new RouteManager();
			String length = rm.countRouteID();
			int numlength = Integer.parseInt(length);
			System.out.println(numlength);
			routes = rm.listAllRoutes();
			if(numlength == 0) {
				route.setRoute_ID("R0001");
	
			}else {
		        String[] arrOfStr = routes.get(numlength-1).getRoute_ID().split("R");
				int route_ID = Integer.parseInt(arrOfStr[1]);
					if(route_ID > 0 && route_ID<10) {	
						route.setRoute_ID("R000"+ (route_ID+1));
						System.out.println(route.getRoute_ID());
					}else if(route_ID > 9 && route_ID<100) {
						route.setRoute_ID("R00"+ (route_ID+1));
						System.out.println(route.getRoute_ID());
					}else if(route_ID > 99 && route_ID<1000) {
						route.setRoute_ID("R0"+ (route_ID+1));
						System.out.println(route.getRoute_ID());
					}else {
						route.setRoute_ID("R"+ (route_ID+1));
						System.out.println(route.getRoute_ID());
					}
			}
			message = rm.insertRoute(route);
			System.out.println(message);
			if(message.equals("failed to save contract")) {
				return new ResponseObj(200, "0");
			}else {
				return new ResponseObj(200, "1");
			}
	
		} catch (Exception e) {
			e.printStackTrace();
			message = "Please try again....";
			return new ResponseObj(500, "0");
		}
	}
	

	@RequestMapping(value = "/route/list", method = RequestMethod.POST)
	public @ResponseBody ResponseObj do_listrouteById(HttpServletRequest request) {
		List<Route> routes = null;
		try {
			RouteManager rm = new RouteManager();
			routes = rm.listAllRoutesGroupBy();
			System.out.println(routes.toString());
			
			return new ResponseObj(200, routes);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, routes);
	}
	
	@RequestMapping(value = "/route/listSearch", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_listSearch(@RequestBody Map<String, String> map) {
		List<Route> routes = null;
		try {
			String school_name = map.get("school_name");
			RouteManager rm = new RouteManager();
			routes = rm.getlistSchoolBusBySearch(school_name);
			System.out.println(routes.toString());
			
			return new ResponseObj(200, routes);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, routes);
	}
	
	@RequestMapping(value = "/schoolbus/SchoolBusDetails", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_getSchoolBusDetails(@RequestBody Map<String, String> map) {
		List<Route> SchoolBusDetails = null;
		try {
			String num_plate = map.get("num_plate");
			RouteManager rm = new RouteManager();
			SchoolBusDetails = rm.getSchoolBusDetails(num_plate);
			System.out.println(SchoolBusDetails.toString());
			return new ResponseObj(200, SchoolBusDetails);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, SchoolBusDetails);
	}
	
	@RequestMapping(value = "/schoolbus/routebySchool", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_getRoutebySchool(@RequestBody Map<String, String> map) {
		List<Route> route = null;
		try {
			String num_plate = map.get("num_plate");
			String school_ID = map.get("school_ID");
			RouteManager rm = new RouteManager();
			route = rm.getRouteBySchool(num_plate,school_ID);
			System.out.println("เน�เธ”เน�เน€เธชเน�เธ�เธ—เธฒเธ�เธกเธฒ : "+route.toString());
			return new ResponseObj(200, route);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, route);
	}
	
	@RequestMapping(value = "/schoolbus/routebySchoolName", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_getRoutebySchoolName(@RequestBody Map<String, String> map) {
		List<Route> route = null;
		try {
			String num_plate = map.get("num_plate");
			String school_name = map.get("school_name");
			RouteManager rm = new RouteManager();
			route = rm.getRouteBySchoolName(num_plate,school_name);
			System.out.println("เน�เธ”เน�เน€เธชเน�เธ�เธ—เธฒเธ�เธกเธฒ : "+route.toString());
			return new ResponseObj(200, route);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, route);
	}
	
}
