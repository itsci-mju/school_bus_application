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

import bean.Children;
import bean.Contract;
import bean.Login;
import bean.Parent;
import bean.RequestCancel;

@Controller
public class RequestCancelController {
	
	@RequestMapping(value = "/request/add", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj AddRequest(@RequestBody Map<String, String> map) {
		String message = "";
		RequestCancel request = null;
		List<RequestCancel> requests = null;
		try {
			Gson gson = new Gson();
			request = gson.fromJson(map.get("requestCancel"), RequestCancel.class);

			System.out.println(request.getRequest_ID()+" "+ request.getRequest_date() + " " + request.getReason() 
					+" "+request.getApprove_date()+" "+request.getStatus_request()+" "
					+request.getContract().getContract_ID());

	
			RequestCancelManager rm = new RequestCancelManager();
			String length = rm.countID();
			int numlength = Integer.parseInt(length);
			System.out.println(numlength);
			requests = rm.listAllRequestCancels();
			if(numlength == 0 || requests == null) {
				request.setRequest_ID("R1");
			}else {
		        String[] arrOfStr = requests.get(numlength-1).getRequest_ID().split("R");
				int request_ID = Integer.parseInt(arrOfStr[1]);
				request.setRequest_ID("R"+  (request_ID+1));
				System.out.println(request.getRequest_ID());
					
			}
			request.setApprove_date(null);
			message = rm.insertRequest(request);
			System.out.println(message);
			if(message.equals("successfully saved")) {
				return new ResponseObj(200, "1");
			}else {
				return new ResponseObj(200, "0");
			}
		} catch (Exception e) {
			e.printStackTrace();
			message = "Please try again....";
			return new ResponseObj(500, "0");
		}
	}
	
	@RequestMapping(value = "/request/list", method = RequestMethod.POST)
	public @ResponseBody ResponseObj do_listContracts(HttpServletRequest request) {
		List<RequestCancel> requests = null;
		try {
			RequestCancelManager rm = new RequestCancelManager();
			requests = rm.listAllRequestCancels();
			System.out.println(requests.toString());
			return new ResponseObj(200, requests);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, requests);
	}

}
