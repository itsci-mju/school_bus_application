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

import bean.Activity;
import bean.Children;
import bean.Login;
import bean.Parent;
import bean.Route;

@Controller
public class ActivityController {
	private static String SALT = "123456";
	
	@RequestMapping(value = "/activity/add", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_Addactivity(@RequestBody Map<String, String> map) {
		String message = "";
		List<Activity> activitys = null;
		try {
			Gson gson = new Gson();
			Activity activity = gson.fromJson(map.get("activity"), Activity.class);

			ActivityManager rm = new ActivityManager();
			String length = rm.countID();
			int numlength = Integer.parseInt(length);
			System.out.println(numlength);
			activitys = rm.listAllAC();
			if(numlength == 0) {
				activity.setActivity_ID("AT0001");

			}else {
		        String[] arrOfStr = activitys.get(numlength-1).getActivity_ID().split("AT");
				int route_ID = Integer.parseInt(arrOfStr[1]);
					if(route_ID > 0 && route_ID<10) {	
						activity.setActivity_ID("AT000"+ (route_ID+1));
						System.out.println(activity.getActivity_ID());
					}else if(route_ID > 9 && route_ID<100) {
						activity.setActivity_ID("AT00"+ (route_ID+1));
						System.out.println(activity.getActivity_ID());
					}else if(route_ID > 99 && route_ID<999) {
						activity.setActivity_ID("AT0"+ (route_ID+1));
						System.out.println(activity.getActivity_ID());
					}else {
						activity.setActivity_ID("AT"+ (route_ID+1));
						System.out.println(activity.getActivity_ID());
					}
			}
			message = rm.insertactivity(activity);
			System.out.println(message);
			if(message.equals("failed to save activity")) {
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

	
	@RequestMapping(value = "/activity/list1", method = RequestMethod.POST)
	public @ResponseBody ResponseObj do_listActivity(HttpServletRequest request) {
		List<Activity> activitys = null;
		try {
			
			ActivityManager rm = new ActivityManager();
			activitys = rm.listACis1();
			System.out.println(activitys.toString());
			
			return new ResponseObj(200, activitys);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, activitys);
	}
	
	/*@RequestMapping(value = "/activity/listbyid", method = RequestMethod.POST , consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_listActivityById(@RequestBody Map<String, String> map,HttpServletRequest request) {
		List<Activity> activitys = null;
		try {
			String contract_ID = map.get("contract_ID");
			
			ActivityManager rm = new ActivityManager();
			activitys = rm.listacbyid(contract_ID);
			System.out.println(activitys.toString());
			
			return new ResponseObj(200, activitys);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, activitys);
	}*/
	
	@RequestMapping(value = "/activity/listbyid", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_getlistChildrensApply(@RequestBody Map<String, String> map) {
		List<Activity> childrens = null;
		try {
			String contract_ID = map.get("contract_ID");
			ActivityManager rm = new ActivityManager();
			childrens = rm.listacbyid(contract_ID);
			System.out.println(childrens.toString());
			return new ResponseObj(200, childrens);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, childrens);
	}

	
	@RequestMapping(value = "/activity/list2", method = RequestMethod.POST)
	public @ResponseBody ResponseObj do_listActivit2(HttpServletRequest request) {
		List<Activity> activitys = null;
		try {
			
			ActivityManager rm = new ActivityManager();
			activitys = rm.listACis2();
			System.out.println(activitys.toString());
			
			return new ResponseObj(200, activitys);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, activitys);
	}
	
	@RequestMapping(value = "/activity/listday", method = RequestMethod.POST)
	public @ResponseBody ResponseObj do_listActivityday(HttpServletRequest request) {
		List<Activity> activitys = null;
		try {
			
			ActivityManager rm = new ActivityManager();
			activitys = rm.listACisorday1();
			System.out.println(activitys.toString());
			
			return new ResponseObj(200, activitys);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, activitys);
	}
	
	@RequestMapping(value = "/activity/update", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_updateactivity(@RequestBody Map<String, String> map) {
		String message = "";
		Activity activity = null;
		try {
			Gson gson = new Gson();
			activity = gson.fromJson(map.get("activity"), Activity.class);
			
			
			ActivityManager rm = new ActivityManager();
			message = rm.editActivity(activity);
			System.out.println(message);
			if(message.equals("failed to edit activity")) {
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
}
