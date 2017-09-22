package cn.sdfi.model;

import java.util.List;

/*
 * 订单
 */
public class Order {

	private String id;
	private int user_id;
	private String userName;
	private String createTime; // 订单生成时间
	private String demandTime; // 用餐时间
	private String money;
	private String seatId;// 餐位编号
	private String location;// 餐位位置
	private List<Detail> list;
	public List<Detail> getList() {
		return list;
	}
	public void setList(List<Detail> list) {
		this.list = list;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getDemandTime() {
		return demandTime;
	}
	public void setDemandTime(String demandTime) {
		this.demandTime = demandTime;
	}

	public String getMoney() {
		return money;
	}
	public void setMoney(String money) {
		this.money = money;
	}
	
	public int getUser_id() {
		return user_id;
	}
	public void setUser_id(int user_id) {
		this.user_id = user_id;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getSeatId() {
		return seatId;
	}
	public void setSeatId(String seatId) {
		this.seatId = seatId;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
}
