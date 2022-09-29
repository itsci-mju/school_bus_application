package bean;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="driver")
public class Driver {
	@Id
	private String IDCard;
	
	@Column(name="firstname")
	private String firstname;
	
	@Column(name="lastname")
	private String lastname;
	
	@Column(name="birthday")
	private String birthday;
	
	@Column(name="phone")
	private String phone;
	
	@Column(name="email")
	private String email;
	
	@Column(name="groupline")
	private String groupline;
	
	@Column(name="address")
	private String address;
	
	@Column(name="image_profile")
	private String image_profile;
	
	@Column(name="driver_license")
	private String driver_license;
	
	@Column(name="student_bus_license")
	private String student_bus_license;
	
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "Login_username", nullable=false)
	private Login login;

	public Driver() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Driver(String iDCard, String firstname, String lastname, String birthday, String phone, String email,
			String groupline, String address, String image_profile, String driver_license, String student_bus_license,
			Login login) {
		super();
		
		IDCard = iDCard;
		this.firstname = firstname;
		this.lastname = lastname;
		this.birthday = birthday;
		this.phone = phone;
		this.email = email;
		this.groupline = groupline;
		this.address = address;
		this.image_profile = image_profile;
		this.driver_license = driver_license;
		this.student_bus_license = student_bus_license;
		this.login = login;
	}

	public String getDriver_license() {
		return driver_license;
	}

	public void setDriver_license(String driver_license) {
		this.driver_license = driver_license;
	}

	public String getStudent_bus_license() {
		return student_bus_license;
	}

	public void setStudent_bus_license(String student_bus_license) {
		this.student_bus_license = student_bus_license;
	}

	public String getIDCard() {
		return IDCard;
	}

	public void setIDCard(String iDCard) {
		IDCard = iDCard;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public String getBirthday() {
		return birthday;
	}

	public void setBirthday(String birthday) {
		this.birthday = birthday;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getGroupline() {
		return groupline;
	}

	public void setGroupline(String groupline) {
		this.groupline = groupline;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getImage_profile() {
		return image_profile;
	}

	public void setImage_profile(String image_profile) {
		this.image_profile = image_profile;
	}

	public Login getLogin() {
		return login;
	}

	public void setLogin(Login login) {
		this.login = login;
	}

	
}
