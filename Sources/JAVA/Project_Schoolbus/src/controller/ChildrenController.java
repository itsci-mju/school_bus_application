package controller;

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
import bean.Login;
import bean.Parent;

@Controller
public class ChildrenController {
	private static String SALT = "123456";
	
	@RequestMapping(value = "/children/add", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj AddChildren(@RequestBody Map<String, String> map) {
		String message = "";
		Parent parent = null;
		Login login = null;
		Children children = null;
		try {
			Gson gson = new Gson();
			children = gson.fromJson(map.get("children"), Children.class);

			//password = PasswordUtil.getInstance().createPassword(password, SALT);
			
			System.out.println(children.getLogin().getUsername()+" "+ children.getFirstname() + " " + children.getLastname() 
					+" "+children.getBirthday()+" "+children.getPhone()+" "
					+children.getEmail()+" "+children.getLineID()+" "+children.getImage_profile());

	
			ChildrenManager cm = new ChildrenManager();
			message = cm.insertChildren(children,children.getLogin());
			System.out.println(message);
			if(message.equals("failed to save Children")) {
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
	
	@RequestMapping(value = "/children/listByParentId", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_getlistChildrensByIdFlutter(@RequestBody Map<String, String> map) {
		List<Children> childrens = null;
		try {
			String parentId = map.get("parentId");
			ChildrenManager cm = new ChildrenManager();
			childrens = cm.listAllChildrensById(parentId);
			System.out.println(childrens.toString());
			return new ResponseObj(200, childrens);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, childrens);
	}
	
	
	@RequestMapping(value = "/children/list", method = RequestMethod.POST)
	public @ResponseBody ResponseObj do_listChildrens(HttpServletRequest request) {
		List<Children> childrens = null;
		try {
			ChildrenManager cm = new ChildrenManager();
			childrens = cm.listAllChildrens();
			for(Children t : childrens) {
				System.out.println(t.getLogin().getUsername());
			}
			System.out.println(childrens.toString());
			return new ResponseObj(200, childrens);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, childrens);
	}
	
	@RequestMapping(value = "/children/profilebyid", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_getProfileChildrenById(@RequestBody Map<String, String> map) {
		String message = "";
		Parent parent = null;
		Login login = null;
		Children children = null;
		try {
			String IDCard = map.get("IDCard");
			System.out.println(IDCard);

			
			ChildrenManager cm = new ChildrenManager();
			children = cm.getChildrenProfileByID(IDCard);
			
			System.out.println(children.getFirstname()+" "+children.getLineID());
			
			
			return new ResponseObj(200, children);
		} catch (Exception e) {
			e.printStackTrace();
			message = "Please try again....";
			return new ResponseObj(500, children);
		}
	}
	
	@RequestMapping(value = "/children/edit", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_EditProfileChildren(@RequestBody Map<String, String> map) {
		String message = "";
		Parent parent = null;
		Login login = null;
		Children children = null;
		try {
			Gson gson = new Gson();
			children = gson.fromJson(map.get("children"), Children.class);
			
			System.out.println(children.getLogin().getUsername()+" "+ children.getFirstname() + " " + children.getLastname() 
					+" "+children.getBirthday()+" "+children.getPhone()+" "
					+children.getEmail()+" "+children.getLineID()+" "+children.getImage_profile());
	
			ChildrenManager cm = new ChildrenManager();
			message = cm.editChildren(children);
			System.out.println(message);
			if(message.equals("failed to edit children")) {
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
	
	@RequestMapping(value = "/children/delete", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj deleteChildrenByIdFlutter(@RequestBody Map<String, String> map) {
		String message = "";
		try {
			
			String IDCard = map.get("IDCard");
			
			System.out.println(IDCard);
			ChildrenManager cm = new ChildrenManager();
			message = cm.deleteChildren(IDCard);
			
			System.out.println(message);
			
			return new ResponseObj(200, "1");
		} catch (Exception e) {
			e.printStackTrace();
			message = "Please try again....";
			return new ResponseObj(500, "0");
		}
	}
	
	@RequestMapping(value = "/children/listApply", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_getlistChildrensApply(@RequestBody Map<String, String> map) {
		List<Children> childrens = null;
		try {
			String parentId = map.get("parentId");
			ChildrenManager cm = new ChildrenManager();
			childrens = cm.listAllChildrensApply(parentId);
			System.out.println(childrens.toString());
			return new ResponseObj(200, childrens);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, childrens);
	}

}
