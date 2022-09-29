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
import bean.Bus;
import bean.Driver;
import bean.Login;
import bean.Parent;
import bean.User;

@Controller
public class BusController {
	private static String SALT = "123456";
	
	
	@RequestMapping(value = "/bus/list", method = RequestMethod.POST)
	public @ResponseBody ResponseObj do_listBus(HttpServletRequest request) {
		List<Bus> bus = null;
		try {
			BusManager bm = new BusManager();
			bus = bm.listAllBus();

			System.out.println(bus.toString());
			return new ResponseObj(200, bus);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, bus);
	}
	
	@RequestMapping(value = "/bus/updatelocation", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_updatelocation(@RequestBody Map<String, String> map)  {
		String message = "";
		Bus bus = null;
		try {
			Gson gson = new Gson();
			bus = gson.fromJson(map.get("bus"), Bus.class);
			
			
			BusManager bm = new BusManager();
			message = bm.editBus(bus);
			System.out.println(message);
			if(message.equals("failed to edit bus")) {
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
