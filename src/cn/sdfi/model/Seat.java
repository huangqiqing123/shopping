package cn.sdfi.model;

public class Seat {
/*
 * 餐位信息
 */
	private int seatId;
	private String memo;
	private String location;
	private String available;
	private String money;
	private String nums;
	private String picture;
	public String getAvailable() {
		return available;
	}
	public void setAvailable(String available) {
		this.available = available;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public String getMoney() {
		return money;
	}
	public void setMoney(String money) {
		this.money = money;
	}
	public String getNums() {
		return nums;
	}
	public void setNums(String nums) {
		this.nums = nums;
	}
	public int getSeatId() {
		return seatId;
	}
	public void setSeatId(int seatId) {
		this.seatId = seatId;
	}
	public void setPicture(String picture) {
		// TODO Auto-generated method stub
		this.picture=picture;
	}
	public String getPicture() {
		return picture;
	}
}
