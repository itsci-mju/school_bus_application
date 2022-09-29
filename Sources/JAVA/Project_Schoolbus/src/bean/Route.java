package bean;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="route")
public class Route{
	@Id
	private String route_ID;
	
	@Column(name="route_details")
	private String route_details;
		
	@Column(name="route_mapURL")
	private String route_mapURL;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "Bus_num_plate", nullable=false)
	private Bus bus;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "School_school_ID", nullable=false)
	private School school;
	
	public Route() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Route(String route_ID, String route_details, String route_mapURL, Bus bus, School school) {
		super();
		this.route_ID = route_ID;
		this.route_details = route_details;
		this.route_mapURL = route_mapURL;
		this.bus = bus;
		this.school = school;
	}

	public String getRoute_ID() {
		return route_ID;
	}

	public void setRoute_ID(String route_ID) {
		this.route_ID = route_ID;
	}

	public String getRoute_details() {
		return route_details;
	}

	public void setRoute_details(String route_details) {
		this.route_details = route_details;
	}

	public String getRoute_mapURL() {
		return route_mapURL;
	}

	public void setRoute_mapURL(String route_mapURL) {
		this.route_mapURL = route_mapURL;
	}

	public Bus getBus() {
		return bus;
	}

	public void setBus(Bus bus) {
		this.bus = bus;
	}

	public School getSchool() {
		return school;
	}

	public void setSchool(School school) {
		this.school = school;
	}
	
}
