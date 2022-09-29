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

import bean.School;

@Controller
public class SchoolController {
	private static String SALT = "123456";
	
	@RequestMapping(value = "/school/list", method = RequestMethod.POST)
	public @ResponseBody ResponseObj do_listUsers(HttpServletRequest request) {
		List<School> schools = null;
		try {
			SchoolManager sm = new SchoolManager();
			schools = sm.listAllSchool();
			System.out.println(schools.toString());
			return new ResponseObj(200, schools);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, schools);
	}
	
	
	@RequestMapping(value = "/school/getSchool", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_getSchool(@RequestBody Map<String, String> map) {
		School school = null;
		try {
			String school_ID  = map.get("school_ID");
			SchoolManager sm = new SchoolManager();
			school = sm.getSchool(school_ID);
			System.out.println(school.toString());
			return new ResponseObj(200, school);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, school);
	}
	

}
