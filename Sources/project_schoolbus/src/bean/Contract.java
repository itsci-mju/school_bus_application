package bean;

import java.sql.Time;
import java.text.SimpleDateFormat;
import java.time.LocalTime;
import java.util.Calendar;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


@Entity
@Table(name="contract")
public class Contract {
	
	@Id
	private String contract_ID;
	
	@Column(name="contract_date")
	private String contract_date;
		
	@Column(name="start_date")
	private String start_date;
	
	@Column(name="end_date")
	private String end_date;
		
	@Column(name="pick_up_latitude")
	private String pick_up_latitude;
	
	@Column(name="pick_up_longitude")
	private String pick_up_longitude;
		
	@Column(name="pick_up_time")
	private String pick_up_time;
	
	@Column(name="approve_date")
	private String approve_date;
		
	@Column(name="status")
	private int status;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "Children_IDCard", nullable=false)
	private Children children;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "Route_route_ID", nullable=false)
	private Route route;

	public Contract() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Contract(String contract_ID, String contract_date, String start_date, String end_date,
			String pick_up_latitude, String pick_up_longitude, String pick_up_time, String approve_date, int status,
			Children children, Route route) {
		super();
		this.contract_ID = contract_ID;
		this.contract_date = contract_date;
		this.start_date = start_date;
		this.end_date = end_date;
		this.pick_up_latitude = pick_up_latitude;
		this.pick_up_longitude = pick_up_longitude;
		this.pick_up_time = pick_up_time;
		this.approve_date = approve_date;
		this.status = status;
		this.children = children;
		this.route = route;
	}

	public String getContract_ID() {
		return contract_ID;
	}

	public void setContract_ID(String contract_ID) {
		this.contract_ID = contract_ID;
	}

	public String getContract_date() {
		return contract_date;
	}

	public void setContract_date(String contract_date) {
		this.contract_date = contract_date;
	}

	public String getStart_date() {
		return start_date;
	}

	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}

	public String getEnd_date() {
		return end_date;
	}

	public void setEnd_date(String end_date) {
		this.end_date = end_date;
	}

	public String getPick_up_latitude() {
		return pick_up_latitude;
	}

	public void setPick_up_latitude(String pick_up_latitude) {
		this.pick_up_latitude = pick_up_latitude;
	}

	public String getPick_up_longitude() {
		return pick_up_longitude;
	}

	public void setPick_up_longitude(String pick_up_longitude) {
		this.pick_up_longitude = pick_up_longitude;
	}

	public String getPick_up_time() {
		return pick_up_time;
	}

	public void setPick_up_time(String pick_up_time) {
		this.pick_up_time = pick_up_time;
	}

	public String getApprove_date() {
		return approve_date;
	}

	public void setApprove_date(String approve_date) {
		this.approve_date = approve_date;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public Children getChildren() {
		return children;
	}

	public void setChildren(Children children) {
		this.children = children;
	}

	public Route getRoute() {
		return route;
	}

	public void setRoute(Route route) {
		this.route = route;
	}

	
	
	
}
