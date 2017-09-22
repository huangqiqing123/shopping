package cn.sdfi.model;

public class Vote {

	private int id;	// 项目 ID
	private int number;// 获得票数
	private String iterm;//投票项目
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getIterm() {
		return iterm;
	}
	public void setIterm(String iterm) {
		this.iterm = iterm;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
}
