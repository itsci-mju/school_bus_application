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

import bean.Children;
import bean.Driver;
import bean.Login;
import bean.Parent;
import bean.User;

@Controller
public class LoginController {
	
	
	@RequestMapping(value = "/login/verify", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_login(@RequestBody Map<String, String> map) {
		String message = "";
		Login login = null;
		try {
			String username = map.get("username");
			String password = map.get("password");
			String type = map.get("type");
			
			login = new Login(username,password,type);
			
			LoginManager lm = new LoginManager();
			message = lm.doHibernateLogin(login);
			
			login = lm.getLoginDetails(username);
			
			System.out.println(login.getUsername()+" "+login.getPassword()+" "+login.getType());
			
			
			System.out.println(message);
			
			
			if ("login success".equals(message)) {
				return new ResponseObj(200, login.getType());
			}else {
				return new ResponseObj(200, "0");
			}
			
		} catch (Exception e) {
			System.out.println("แจ้งเตือน : ไม่มีผู้ใช้นี้ในระบบ");
			message = "Please try again....";
			return new ResponseObj(500, "0");
		}
	}
	
	@RequestMapping(value = "/user/profile", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_getProfileByUsername(@RequestBody Map<String, String> map) {
		Parent parent = null;
		Children children = null;
		Driver driver  = null;
		try {
			String username = map.get("username");
			String type = map.get("type");
			
			/*Object parent2 = map.get("parent");
			Map<String, String> map2 = (Map<String, String>) parent2;
			String IDCard = map2.get("IDCard");*/
			
			if(type.equals("1")) {
				
				ParentManager pm = new ParentManager();
				parent = pm.getParentProfileByUsername(username);
				System.out.println(parent.getIDCard());
				return new ResponseObj(200, parent);
				
			}else if((type.equals("2"))){
				
				ChildrenManager cm = new ChildrenManager();
				children = cm.getChildrenProfileByUsername(username);
				System.out.println(children.getIDCard());
				return new ResponseObj(200, children);
				
			}else if((type.equals("3"))){
				
				DriverManager dm = new DriverManager();
				driver = dm.getDriverProfileByUsername(username);
				System.out.println(driver.getIDCard());
				return new ResponseObj(200, driver);
				
			}


		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, "เกิดข้อมูลพลาด");
	}
	

}
