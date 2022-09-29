package bean;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="children")
public class Children {
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
	
	@Column(name="lineID")
	private String lineID;
	
	@Column(name="image_profile")
	private String image_profile;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "Parent_IDCard", nullable=false)
	private Parent parent;
	
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "Login_username", nullable=false)
	private Login login;

	public Children() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Children(String iDCard, String firstname, String lastname, String birthday, String phone, String email,
			String lineID, String image_profile) {
		super();
		IDCard = iDCard;
		this.firstname = firstname;
		this.lastname = lastname;
		this.birthday = birthday;
		this.phone = phone;
		this.email = email;
		this.lineID = lineID;
		this.image_profile = image_profile;
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

	public String getImage_profile() {
		return image_profile;
	}

	public void setImage_profile(String image_profile) {
		this.image_profile = image_profile;
	}

	public Parent getParent() {
		return parent;
	}

	public void setParent(Parent parent) {
		this.parent = parent;
	}

	public Login getLogin() {
		return login;
	}

	public void setLogin(Login login) {
		this.login = login;
	}
	
	
}
