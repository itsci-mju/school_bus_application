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

import bean.Children;
import bean.Login;
import bean.Parent;
import bean.User;

@Controller
public class ParentController {
	private static String SALT = "123456";
	
	@RequestMapping(value = "/parent/add", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_register(@RequestBody Map<String, String> map) {
		String message = "";
		Parent parent = null;
		Login login = null;
		try {
			Gson gson = new Gson();
			parent = gson.fromJson(map.get("parent"), Parent.class);

			//password = PasswordUtil.getInstance().createPassword(password, SALT);
			
			System.out.println(parent.getLogin().getUsername()+" "+ parent.getFirstname() + " " + parent.getLastname() 
					+" "+parent.getBirthday()+" "+parent.getPhone()+" "
					+parent.getEmail()+" "+parent.getLineID()+" "+parent.getImage_profile());
			
			ParentManager pm = new ParentManager();
			message = pm.insertParent(parent,parent.getLogin());
			if(message.equals("failed to save parent")) {
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
	
	@RequestMapping(value = "/parent/list", method = RequestMethod.POST)
	public @ResponseBody ResponseObj do_listUsers(HttpServletRequest request) {
		List<Parent> parents = null;
		try {
			ParentManager pm = new ParentManager();
			parents = pm.listAllParents();
			System.out.println(parents.toString());
			return new ResponseObj(200, parents);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, parents);
	}
	
	
	@RequestMapping(value = "/parent/edit", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_editParent(@RequestBody Map<String, String> map) {
		String message = "";
		Parent parent = null;
		Login login = null;
		try {
			Gson gson = new Gson();
			parent = gson.fromJson(map.get("parent"), Parent.class);

			//password = PasswordUtil.getInstance().createPassword(password, SALT);
			
			System.out.println(parent.getLogin().getUsername()+" "+parent.getLogin().getPassword()+" "+parent.getLogin().getType()
					+" "+ parent.getFirstname() + " " + parent.getLastname() 
					+" "+parent.getBirthday()+" "+parent.getPhone()+" "
					+parent.getEmail()+" "+parent.getLineID()+" "+parent.getImage_profile());
			ParentManager pm = new ParentManager();
			message = pm.editParent(parent);
			System.out.println(message);
			if(message.equals("failed to save parent")) {
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
