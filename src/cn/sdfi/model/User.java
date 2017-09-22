package cn.sdfi.model;

public class User {

	private int id;
	private String name;
	private String password;
	private String sex;
	private String address;
	private String phone;
	private int privledge;
	private String email;
	private String memo;
	private String registerTime;
	private String loginTime;
	private String picture;
	public String getRegisterTime() {
		return registerTime;
	}

	public void setRegisterTime(String registerTime) {
		this.registerTime = registerTime;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public int getPrivledge() {
		return privledge;
	}

	public void setPrivledge(int privledge) {
		this.privledge = privledge;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}
 
	public User() {
		// TODO Auto-generated constructor stub
	}

	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getLoginTime() {
		return loginTime;
	}

	public void setLoginTime(String loginTime) {
		this.loginTime = loginTime;
	}
	public String toString() {
		// TODO Auto-generated method stub
		StringBuffer msg=new StringBuffer();
		msg.append("\n");
		msg.append("编号:");
		msg.append(id);
		msg.append("\n");
		msg.append("姓名：");
		msg.append(name);
		msg.append("\n");
		msg.append("权限：");
		msg.append(privledge);
		msg.append("\n");
		msg.append("性别：");
		msg.append(sex);
		return msg.toString();
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

}
