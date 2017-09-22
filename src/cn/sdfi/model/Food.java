package cn.sdfi.model;

public class Food {

	private int id;
	private String name;
	private String price;
	private String memo;
	private String picture;
	private String addTime;
	private String type;//所属类别名称
	private int  typeId;
	
	public int getTypeId() {
		return typeId;
	}
	public void setTypeId(int typeId) {
		this.typeId = typeId;
	}
	public String getAddTime() {
		return addTime;
	}
	public void setAddTime(String addTime) {
		this.addTime = addTime;
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
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public Food() {
		// TODO Auto-generated constructor stub
	}
	public String toString(){
		return this.name+"\t"+this.price+"\t"+this.memo;
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getPicture() {
		return picture;
	}
	public void setPicture(String picture) {
		this.picture = picture;
	}

}
