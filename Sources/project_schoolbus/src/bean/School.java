package bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="school")
public class School {
	@Id
	private String school_ID;
	
	@Column(name="school_name")
	private String school_name;
	
	@Column(name="school_latitude")
	private String school_latitude;
	
	@Column(name="school_longitude")
	private String school_longitude;

	public School() {
		super();
		// TODO Auto-generated constructor stub
	}

	public School(String school_ID, String school_name, String school_latitude, String school_longitude) {
		super();
		this.school_ID = school_ID;
		this.school_name = school_name;
		this.school_latitude = school_latitude;
		this.school_longitude = school_longitude;
	}

	public String getSchool_ID() {
		return school_ID;
	}

	public void setSchool_ID(String school_ID) {
		this.school_ID = school_ID;
	}

	public String getSchool_name() {
		return school_name;
	}

	public void setSchool_name(String school_name) {
		this.school_name = school_name;
	}

	public String getSchool_latitude() {
		return school_latitude;
	}

	public void setSchool_latitude(String school_latitude) {
		this.school_latitude = school_latitude;
	}

	public String getSchool_longitude() {
		return school_longitude;
	}

	public void setSchool_longitude(String school_longitude) {
		this.school_longitude = school_longitude;
	}

	
	
}
