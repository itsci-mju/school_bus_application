package bean;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="bus")
public class Bus {
	@Id
	private String num_plate;
	
	@Column(name="province")
	private String province;
	
	@Column(name="brand")
	private String brand;
	
	@Column(name="purchase_date")
	private String purchase_date;
	
	@Column(name="seats_amount")
	private int seats_amount;
	
	@Column(name="bus_latitude")
	private String bus_latitude;
	
	@Column(name="bus_longitude")
	private String bus_longitude;
	
	@Column(name="status_bus")
	private int status_bus;
	
	@Column(name="reason", nullable=false)
	private String reason;
	
	@Column(name="image_Bus")
	private String image_Bus;
	
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "Driver_IDCard", nullable=false)
	private Driver driver;

	public Bus() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	public Bus(String num_plate, String province, String brand, String purchase_date, int seats_amount,
			String bus_latitude, String bus_longitude, int status_bus, String reason, String image_Bus, Driver driver) {
		super();
		this.num_plate = num_plate;
		this.province = province;
		this.brand = brand;
		this.purchase_date = purchase_date;
		this.seats_amount = seats_amount;
		this.bus_latitude = bus_latitude;
		this.bus_longitude = bus_longitude;
		this.status_bus = status_bus;
		this.reason = reason;
		this.image_Bus = image_Bus;
		this.driver = driver;
	}
	
	public int getStatus_bus() {
		return status_bus;
	}

	public int getSeats_amount() {
		return seats_amount;
	}

	public void setSeats_amount(int seats_amount) {
		this.seats_amount = seats_amount;
	}

	public void setStatus_bus(int status_bus) {
		this.status_bus = status_bus;
	}

	public String getBus_latitude() {
		return bus_latitude;
	}

	public void setBus_latitude(String bus_latitude) {
		this.bus_latitude = bus_latitude;
	}

	public String getBus_longitude() {
		return bus_longitude;
	}

	public void setBus_longitude(String bus_longitude) {
		this.bus_longitude = bus_longitude;
	}

	public String getReason() {
		return reason;
	}

	public void setReason(String reason) {
		this.reason = reason;
	}

	public String getNum_plate() {
		return num_plate;
	}

	public void setNum_plate(String num_plate) {
		this.num_plate = num_plate;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public String getPurchase_date() {
		return purchase_date;
	}

	public void setPurchase_date(String purchase_date) {
		this.purchase_date = purchase_date;
	}

	public String getImage_Bus() {
		return image_Bus;
	}

	public void setImage_Bus(String image_Bus) {
		this.image_Bus = image_Bus;
	}

	public Driver getDriver() {
		return driver;
	}

	public void setDriver(Driver driver) {
		this.driver = driver;
	}
	
	
}
