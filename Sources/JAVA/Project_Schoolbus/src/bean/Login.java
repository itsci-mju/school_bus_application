package bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="login")
public class Login {
	@Id
	@Column(length = 16)
	private String username;
	
	@Column(name="password", nullable=false,length = 16)
	private String password;

	@Column(name="type", nullable=false,length = 45)
	private String type;

	public Login() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Login(String username, String password, String type) {
		super();
		this.username = username;
		this.password = password;
		this.type = type;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}
	
	
}
