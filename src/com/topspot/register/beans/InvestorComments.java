package com.topspot.register.beans;

public class InvestorComments {

	private int id;
	private int investorId;
	private int propertyId;
	private String City;
	private String Area;
	private String Sub_Area;
	private String Building;
	private String Developer;
	private String Comments;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getInvestorId() {
		return investorId;
	}

	public void setInvestorId(int investorId) {
		this.investorId = investorId;
	}

	public int getPropertyId() {
		return propertyId;
	}

	public void setPropertyId(int propertyId) {
		this.propertyId = propertyId;
	}

	public String getCity() {
		return City;
	}

	public void setCity(String city) {
		City = city;
	}

	public String getArea() {
		return Area;
	}

	public void setArea(String area) {
		Area = area;
	}

	public String getSub_Area() {
		return Sub_Area;
	}

	public void setSub_Area(String sub_Area) {
		Sub_Area = sub_Area;
	}

	public String getBuilding() {
		return Building;
	}

	public void setBuilding(String building) {
		Building = building;
	}

	public String getDeveloper() {
		return Developer;
	}

	public void setDeveloper(String developer) {
		Developer = developer;
	}

	public String getComments() {
		return Comments;
	}

	public void setComments(String comments) {
		Comments = comments;
	}
}
