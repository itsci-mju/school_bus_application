package bean;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="requestcancel")
public class RequestCancel {
	@Id
	private String request_ID;
	
	@Column(name="request_date")
	private String request_date;
	
	@Column(name="approve_date")
	private String approve_date;
	
	@Column(name="reason")
	private String reason;
	
	@Column(name="status_request")
	private int status_request;
	
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "Contract_contract_ID", nullable=false)
	private Contract contract;

	public RequestCancel() {
		super();
		// TODO Auto-generated constructor stub
	}

	public RequestCancel(String request_ID, String request_date, String approve_date, String reason,
			int status_request, Contract contract) {
		super();
		this.request_ID = request_ID;
		this.request_date = request_date;
		this.approve_date = approve_date;
		this.reason = reason;
		this.status_request = status_request;
		this.contract = contract;
	}

	public String getRequest_ID() {
		return request_ID;
	}

	public void setRequest_ID(String request_ID) {
		this.request_ID = request_ID;
	}

	public String getRequest_date() {
		return request_date;
	}

	public void setRequest_date(String request_date) {
		this.request_date = request_date;
	}

	public String getApprove_date() {
		return approve_date;
	}

	public void setApprove_date(String approve_date) {
		this.approve_date = approve_date;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public int getStatus_request() {
		return status_request;
	}

	public void setStatus_request(int status_request) {
		this.status_request = status_request;
	}

	public Contract getContract() {
		return contract;
	}

	public void setContract(Contract contract) {
		this.contract = contract;
	}
	
	

}
