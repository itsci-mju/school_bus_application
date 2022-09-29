package controller;

import java.util.ArrayList;
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
import bean.User;

@Controller
public class DriverController {
	private static String SALT = "123456";
	
	@RequestMapping(value = "/driver/add", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_registerDriver(@RequestBody Map<String, String> map) {
		String message = "";
		Driver driver = null;
		Login login = null;
		try {
			Gson gson = new Gson();
			Bus bus = gson.fromJson(map.get("bus"), Bus.class);
			System.out.println(bus.getNum_plate().toString());
			System.out.println(bus.getDriver().getFirstname().toString());
			System.out.println(bus.getDriver().getLogin().getUsername().toString());

			//password = PasswordUtil.getInstance().createPassword(password, SALT);
			
			DriverManager dm = new DriverManager();
			message = dm.insertDriver(bus.getDriver(),bus.getDriver().getLogin(),bus);
			return new ResponseObj(200, "1");
		} catch (Exception e) {
			e.printStackTrace();
			message = "Please try again....";
			return new ResponseObj(500, "0");
		}
	}
	
	@RequestMapping(value = "/driver/getProfileDriver", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_getProfileDriver(@RequestBody Map<String, String> map) {
		String message = "";
		Driver driver = null;
		try {
		
			String IDCard = map.get("IDCard");
			System.out.println("IDCard เธ—เธตเน�เธ•เน�เธญเธ�เธ�เธฒเธฃเธซเธฒเธ�เน�เธญเธกเธนเธฅ : "+IDCard.toString());

			//password = PasswordUtil.getInstance().createPassword(password, SALT);
			
			DriverManager dm = new DriverManager();
			driver = dm.getProfileDriverByID(IDCard);
			System.out.println(driver.toString());
			return new ResponseObj(200, driver);
		} catch (Exception e) {
			e.printStackTrace();
			message = "Please try again....";
			return new ResponseObj(500, driver);
		}
	}
	
	@RequestMapping(value = "/driver/editProfile", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_editProfile(@RequestBody Map<String, String> map) {
		String message = "";
		Driver driver = null;
		Login login = null;
		try {
			
			Gson gson = new Gson();
			Bus bus = gson.fromJson(map.get("bus"), Bus.class);
			System.out.println(bus.getNum_plate().toString());
			System.out.println(bus.getDriver().getFirstname().toString());
			System.out.println(bus.getDriver().getLogin().getUsername().toString());
			System.out.println(bus.getDriver().getBirthday());

			//password = PasswordUtil.getInstance().createPassword(password, SALT);
			
			DriverManager dm = new DriverManager();
			message = dm.editProfile(bus.getDriver(),bus);
			return new ResponseObj(200, "1");
		} catch (Exception e) {
			e.printStackTrace();
			message = "Please try again....";
			return new ResponseObj(500, "0");
		}
	}
	
	
	@RequestMapping(value = "/driver/calDetails", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_calDetils(@RequestBody Map<String, String> map) {
		String calChildrenInCar = "";
		String calRequestApply = "";
		String calRequestCancel = "";
		String error = "";
		List<String> result = new ArrayList<>();
		try {
			String num_plate = map.get("num_plate");
			DriverManager dm = new DriverManager();
			calChildrenInCar = dm.calChildrenInCar(num_plate);
			calRequestApply = dm.calRequestApply(num_plate);
			calRequestCancel = dm.calRequestCancel(num_plate);
			result.add(calChildrenInCar);
			result.add(calRequestApply);
			result.add(calRequestCancel);
			return new ResponseObj(200, result);
		} catch (Exception e) {
			e.printStackTrace();
			error = "Please try again....";
			return new ResponseObj(500, result);
		}
	}
	
	@RequestMapping(value = "/driver/calChildrensInCar", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_calChildrenInCar(@RequestBody Map<String, String> map) {
		String calChildrenInCar = "";
		String result = "";
		try {
			String num_plate = map.get("num_plate");
			DriverManager dm = new DriverManager();
			calChildrenInCar = dm.calChildrenInCar(num_plate);
			result = calChildrenInCar;
			System.out.println("เธกเธตเน€เธ”เน�เธ�เธญเธขเธนเน�เธ�เธ�เธฃเธ– : "+result+" เธ�เธ�");

			return new ResponseObj(200, result);
		} catch (Exception e) {
			e.printStackTrace();
			result = "Please try again....";
			return new ResponseObj(500, result);
		}
	}
	
	@RequestMapping(value = "/bus/detailsByDriverId", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_getBusdetailsByDriverId(@RequestBody Map<String, String> map) {
		Bus bus  = null;
		try {
			String driverId = map.get("driverId");

			BusManager bm = new BusManager();
			bus = bm.getBusDetailsByDriverId(driverId);
			System.out.println(bus.toString());
			
			return new ResponseObj(200, bus);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, bus);
	}
	
	@RequestMapping(value = "/driver/UpdateService", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_UpdateService(@RequestBody Map<String, String> map) {
		String message = "";
		Bus bus = null;
		try {
			Gson gson = new Gson();
			bus = gson.fromJson(map.get("bus"), Bus.class);
			System.out.println(bus.getNum_plate().toString());
			System.out.println(bus.getStatus_bus());
			System.out.println(bus.getReason());

			//password = PasswordUtil.getInstance().createPassword(password, SALT);
			
			DriverManager dm = new DriverManager();
			message = dm.UpdateService(bus);
			return new ResponseObj(200, "1");
		} catch (Exception e) {
			e.printStackTrace();
			message = "Please try again....";
			return new ResponseObj(500, "0");
		}
	}
	
	
	
	@RequestMapping(value = "/driver/list", method = RequestMethod.POST)
	public @ResponseBody ResponseObj do_listUsers(HttpServletRequest request) {
		List<Driver> drivers = null;
		try {
			DriverManager dm = new DriverManager();
			drivers = dm.listAllDrivers();

			System.out.println(drivers.toString());
			return new ResponseObj(200, drivers);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, drivers);
	}
	
	@RequestMapping(value = "/driver/listApply", method = RequestMethod.POST)
	public @ResponseBody ResponseObj do_listApply(HttpServletRequest request) {
		List<Contract> contracts = null;
		try {
			DriverManager dm = new DriverManager();
			contracts = dm.listRequestApply("เธ�เธ—1514");

			System.out.println(contracts.toString());
			return new ResponseObj(200, contracts);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, contracts);
	}
	
	


	

}
