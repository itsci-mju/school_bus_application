package bean;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="activity")
public class Activity {

	@Id
	private String activity_ID ;
	
	@Column(name="get_up_latitude")
	private String get_up_latitude ;
	
	@Column(name="get_up_longitude")
	private String get_up_longitude ;
	
	@Column(name="get_up_time")
	private String get_up_time ; 
	
	@Column(name="get_off_latitude")
	private String get_off_latitude ;
	
	@Column(name="get_off_longitude")
	private String get_off_longitude;
	
	@Column(name="get_off_time")
	private String get_off_time  ;
	
	@Column(name="reason")
	private String reason ;

	@Column(name="time_of_date")
	private int time_of_date ;
	
	@Column(name="status_children")
	private String status_children ;
	
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "Contract_contract_ID", nullable=false)
	private Contract Contract_contract_ID ;

	
	
	public Activity(String activity_ID, String get_up_latitude, String get_up_longitude, String get_up_time,
			String get_off_latitude, String get_off_longitude, String get_off_time, String reason, int time_of_date,
			String status_children, Contract contract_contract_ID) {
		super();
		this.activity_ID = activity_ID;
		this.get_up_latitude = get_up_latitude;
		this.get_up_longitude = get_up_longitude;
		this.get_up_time = get_up_time;
		this.get_off_latitude = get_off_latitude;
		this.get_off_longitude = get_off_longitude;
		this.get_off_time = get_off_time;
		this.reason = reason;
		this.time_of_date = time_of_date;
		this.status_children = status_children;
		Contract_contract_ID = contract_contract_ID;
	}

	public Activity() {
		super();
		// TODO Auto-generated constructor stub
	}

	

	public String getActivity_ID() {
		return activity_ID;
	}

	public void setActivity_ID(String activity_ID) {
		this.activity_ID = activity_ID;
	}

	public String getGet_up_latitude() {
		return get_up_latitude;
	}

	public void setGet_up_latitude(String get_up_latitude) {
		this.get_up_latitude = get_up_latitude;
	}

	public String getGet_up_longitude() {
		return get_up_longitude;
	}

	public void setGet_up_longitude(String get_up_longitude) {
		this.get_up_longitude = get_up_longitude;
	}

	public String getGet_up_time() {
		return get_up_time;
	}

	public void setGet_up_time(String get_up_time) {
		this.get_up_time = get_up_time;
	}

	public String getGet_off_latitude() {
		return get_off_latitude;
	}

	public void setGet_off_latitude(String get_off_latitude) {
		this.get_off_latitude = get_off_latitude;
	}

	public String getGet_off_longitude() {
		return get_off_longitude;
	}

	public void setGet_off_longitude(String get_off_longitude) {
		this.get_off_longitude = get_off_longitude;
	}

	public String getGet_off_time() {
		return get_off_time;
	}

	public void setGet_off_time(String get_off_time) {
		this.get_off_time = get_off_time;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public int getTime_of_date() {
		return time_of_date;
	}

	public void setTime_of_date(int time_of_date) {
		this.time_of_date = time_of_date;
	}

	public String getStatus_children() {
		return status_children;
	}

	public void setStatus_children(String status_children) {
		this.status_children = status_children;
	}

	public Contract getContract_contract_ID() {
		return Contract_contract_ID;
	}

	public void setContract_contract_ID(Contract contract_contract_ID) {
		Contract_contract_ID = contract_contract_ID;
	}

	@Override
	public String toString() {
		return "Activity [activity_ID=" + activity_ID + ", get_up_latitude=" + get_up_latitude + ", get_up_longitude="
				+ get_up_longitude + ", get_up_time=" + get_up_time + ", get_off_latitude=" + get_off_latitude
				+ ", get_off_longitude=" + get_off_longitude + ", get_off_time=" + get_off_time + ", reason=" + reason
				+ ", time_of_date=" + time_of_date + ", status_children=" + status_children + ", Contract_contract_ID="
				+ Contract_contract_ID + "]";
	}
	
	
	
}
