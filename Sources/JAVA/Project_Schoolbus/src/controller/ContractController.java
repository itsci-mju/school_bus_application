package controller;

import java.text.SimpleDateFormat;
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
import bean.Login;
import bean.Parent;
import bean.RequestCancel;
import bean.Route;

@Controller
public class ContractController {
	
	@RequestMapping(value = "/contract/add", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_AddContract(@RequestBody Map<String, String> map) {
		String message = "";
		Children children = null;
		List<Contract> contracts = null;
		try {
			Gson gson = new Gson();
			Contract contract = gson.fromJson(map.get("contract"), Contract.class);
			System.out.println(contract.getContract_ID()+" "+contract.getContract_date()+" "+contract.getStart_date()+" "+
					contract.getEnd_date()+" "+contract.getPick_up_latitude()+" "+contract.getPick_up_longitude()+" "+
					contract.getPick_up_time()+" "+contract.getApprove_date()+" "+contract.getStatus()+" "+
					contract.getChildren().getIDCard()+" "+contract.getRoute().getRoute_ID());
			ContractManager cm = new ContractManager();
			String length = cm.countID();
			int numlength = Integer.parseInt(length);
			System.out.println(numlength);
			contracts = cm.listAllContracts();
			if(numlength == 0) {
				contract.setContract_ID("C01");
			}else {
		        String[] arrOfStr = contracts.get(numlength-1).getContract_ID().split("C");
				int Contract_ID = Integer.parseInt(arrOfStr[1]);
					if(Contract_ID > 0 && Contract_ID<9) {	
						contract.setContract_ID("C0"+ (Contract_ID+1));
						System.out.println(contract.getContract_ID());
					}else {
						contract.setContract_ID("C"+  (Contract_ID+1));
						System.out.println(contract.getContract_ID());
					}
			}
			contract.setApprove_date(null);
			message = cm.insertContract(contract);
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
	
	@RequestMapping(value = "/contract/listApproved", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_listApproved(@RequestBody Map<String, String> map) {
		List<Contract> contracts = null;
		try {
			String IDCard  = map.get("IDCard");
			ContractManager rm = new ContractManager();
			contracts = rm.listAllApprovedContracts(IDCard);
			System.out.println(contracts.toString());
			return new ResponseObj(200, contracts);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, contracts);
	}
	
	@RequestMapping(value = "/contract/listUnApproved", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_listUnApproved(@RequestBody Map<String, String> map) {
		List<Contract> contracts = null;
		try {
			String IDCard  = map.get("IDCard");
			ContractManager rm = new ContractManager();
			contracts = rm.listAllUnApprovedContracts(IDCard);
			System.out.println(contracts.toString());
			return new ResponseObj(200, contracts);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, contracts);
	}
	
	@RequestMapping(value = "/contract/listOther", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_listOther(@RequestBody Map<String, String> map) {
		List<Contract> contracts = null;
		try {
			String IDCard  = map.get("IDCard");
			ContractManager rm = new ContractManager();
			contracts = rm.listAllOtherContracts(IDCard);
			System.out.println(contracts.toString());
			return new ResponseObj(200, contracts);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, contracts);
	}
	
	@RequestMapping(value = "/contract/listApprovedCancel", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_listApprovedCancel(@RequestBody Map<String, String> map) {
		List<Contract> contracts = null;
		try {
			String IDCard  = map.get("IDCard");
			ContractManager rm = new ContractManager();
			contracts = rm.listAllApprovedCancel(IDCard);
			System.out.println(contracts.toString());
			return new ResponseObj(200, contracts);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, contracts);
	}
	
	@RequestMapping(value = "/contract/list", method = RequestMethod.POST)
	public @ResponseBody ResponseObj do_listContracts(HttpServletRequest request) {
		List<Contract> contracts = null;
		try {
			ContractManager rm = new ContractManager();
			contracts = rm.listAllContracts();
			System.out.println(contracts.toString());
			return new ResponseObj(200, contracts);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, contracts);
	}
	
	@RequestMapping(value = "/contract/getDetails", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_getContractDetails(@RequestBody Map<String, String> map) {
		Contract contract = null;
		try {
			String contract_ID  = map.get("contract_ID");
			ContractManager rm = new ContractManager();
			contract = rm.getContractsDetailsByID(contract_ID);
			System.out.println(contract.toString());
			return new ResponseObj(200, contract);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, contract);
	}
	
	@RequestMapping(value = "/contract/getDetailsbychildrenid", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_getContractDetailsbychildrenid(@RequestBody Map<String, String> map) {
		List<Contract> contracts = null;
		try {
			String childrenid  = map.get("childrenid");
			ContractManager rm = new ContractManager();
			contracts = rm.getContractsDetailsByidchildren(childrenid);
			System.out.println(contracts.toString());
			return new ResponseObj(200, contracts);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, contracts);
	}
	
	
	@RequestMapping(value = "/contract/delete", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj deleteContract(@RequestBody Map<String, String> map) {
		String message = "";
		try {
			
			String contract_ID = map.get("contract_ID");
			
			System.out.println(contract_ID);
			ContractManager cm = new ContractManager();
			message = cm.deleteContract(contract_ID);
			System.out.println(message);
			if(message.equals("successfully delete")) {
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
	
	/********************************************* Driver **************************************************/
	
	@RequestMapping(value = "/contractDriver/listUnApproved", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_listUnApprovedDriver(@RequestBody Map<String, String> map) {
		List<Contract> contracts = null;
		try {
			String num_plate  = map.get("num_plate");
			ContractManager rm = new ContractManager();
			contracts = rm.Driver_listAllUnApproveds(num_plate);
			System.out.println(contracts.toString());
			return new ResponseObj(200, contracts);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, contracts);
	}
	
	@RequestMapping(value = "/requestCancel/listbyId", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_listrequestCancelDriver(@RequestBody Map<String, String> map) {
		List<RequestCancel> requests = null;
		try {
			String num_plate  = map.get("num_plate");
			ContractManager rm = new ContractManager();
			requests = rm.Driver_listAllRequestCancel(num_plate);
			System.out.println(requests.toString());
			return new ResponseObj(200, requests);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, requests);
	}
	
	@RequestMapping(value = "/requestCancel/getDetails", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_getrequestCancelDetails(@RequestBody Map<String, String> map) {
		RequestCancel request = null;
		try {
			String request_ID  = map.get("request_ID");
			ContractManager rm = new ContractManager();
			request = rm.Driver_getRequestCancel(request_ID);
			System.out.println(request.toString());
			return new ResponseObj(200, request);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, request);
	}
	
	@RequestMapping(value = "/requestCancel/approved", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_ApprovedrequestCancel(@RequestBody Map<String, String> map) {
		String message = "";
		try {
			String contract_ID  = map.get("contract_ID");
			ContractManager rm = new ContractManager();
			message = rm.UpdateStatusCancel(contract_ID);
			System.out.println(message.toString());
			if(message.equals("successfully updated")) {
				return new ResponseObj(200, "1");
			}else {
				return new ResponseObj(200, "0");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, "0");
	}
	
	@RequestMapping(value = "/application/approved", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_ApprovedApplication(@RequestBody Map<String, String> map) {
		String message = "";
		try {
			String contract_ID  = map.get("contract_ID");
			String approve_date  = map.get("approve_date");
	
			ContractManager rm = new ContractManager();
			message = rm.UpdateStatusApplication(contract_ID,approve_date);
			System.out.println(message.toString());
			if(message.equals("successfully updated")) {
				return new ResponseObj(200, "1");
			}else {
				return new ResponseObj(200, "0");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, "0");
	}
	
	@RequestMapping(value = "/driver/listChildren", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_DriverlistChildren(@RequestBody Map<String, String> map) {
		List<Contract> contracts = null;
		try {
			String num_plate  = map.get("num_plate");
			ContractManager rm = new ContractManager();
			contracts = rm.Driver_listAllChildren(num_plate);
			System.out.println(contracts.toString());
			return new ResponseObj(200, contracts);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, contracts);
	}
	
	@RequestMapping(value = "/driver/listChildren1", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_DriverlistChildren1(@RequestBody Map<String, String> map) {
		List<Contract> contracts = null;
		try {
			String num_plate  = map.get("num_plate");
			ContractManager rm = new ContractManager();
			contracts = rm.Driver_listAllChildren1(num_plate);
			System.out.println(contracts.toString());
			return new ResponseObj(200, contracts);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, contracts);
	}
	
		@RequestMapping(value = "/driver/listChildren2", method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public @ResponseBody ResponseObj do_DriverlistChildren2(@RequestBody Map<String, String> map) {
		List<Contract> contracts = null;
		try {
			String num_plate  = map.get("num_plate");
			ContractManager rm = new ContractManager();
			contracts = rm.Driver_listAllChildren2(num_plate);
			System.out.println(contracts.toString());
			return new ResponseObj(200, contracts);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return new ResponseObj(500, contracts);
	}
	
	

}
