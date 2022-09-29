package bean;

import java.util.Calendar;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="parent")
public class Parent {
	@Id
	@Column(length = 13)
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
	
	@Column(name="lineID")
	private String lineID;
	
	@Column(name="address")
	private String address;
	
	@Column(name="image_profile")
	private String image_profile;
		
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "Login_username", nullable=false)
	private Login login;
	
	public Parent() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Parent(String iDCard, String firstname, String lastname, String birthday, String phone, String email,
			String lineID, String address, String image_profile, Login login) {
		super();
		IDCard = iDCard;
		this.firstname = firstname;
		this.lastname = lastname;
		this.birthday = birthday;
		this.phone = phone;
		this.email = email;
		this.lineID = lineID;
		this.address = address;
		this.image_profile = image_profile;
		this.login = login;
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

	public String getLineID() {
		return lineID;
	}

	public void setLineID(String lineID) {
		this.lineID = lineID;
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
