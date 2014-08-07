package com.topspot.register.beans;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 
 * @author pdudekula
 *
 */
@Entity
@Table(name="building_database_final")
public class Building {
	
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	protected Long id;
	
	@Column(name="City")
	private String city;
	
	@Column(name="Area")
	private String area;
	
	@Column(name="Sub_Area")
	private String subArea;
	
	@Column(name="Building")
	private String building;
	
	@Column(name="Building_Type")
	private String buildingType;
	
	@Column(name="Building_Status")
	private String buildingStatus;
	
	@Column(name="Structural_Material")
	private String structaralMaterial;
	
	@Column(name="Architectural_Style")
	private String architecturalStyle;
	
	@Column(name="Foundation")
	private String foundation;
	
	@Column(name="UsageType")
	private String usageType;
	
	@Column(name="Height")
	private String height;
	
	@Column(name="Floors")
	private String floors;
	
	@Column(name="Completion")
	private String completion;
	
	@Column(name="Elevators")
	private String elevators;
	
	@Column(name="Parking")
	private String parking;
	
	@Column(name="Architect")
	private String architect;
	
	@Column(name="Developer")
	private String developer;
	
	@Column(name="Contractor")
	private String contractor;
	
	@Column(name="Latitude")
	private String latitude;
	
	@Column(name="Longitude")
	private String longitude;
	
	@Column(name="ImageLink")
	private String imageUrl;
	
	@Column(name="Comments")
	private String comments;
	
	@Column(name="AvgRent")
	private String avgRent;
	
	@Column(name="Bedrooms")
	private String Bedrooms;

	@Column(name="Count")
	private int Count;

	@Column(name="Price_AED")
	private String Price_AED;
	
	public Building(){}
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getArea() {
		return area;
	}
	public void setArea(String area) {
		this.area = area;
	}
	public String getSubArea() {
		return subArea;
	}
	public void setSubArea(String subArea) {
		this.subArea = subArea;
	}
	public String getBuilding() {
		return building;
	}
	public void setBuilding(String building) {
		this.building = building;
	}
	public String getBuildingType() {
		return buildingType;
	}
	public void setBuildingType(String buildingType) {
		this.buildingType = buildingType;
	}
	public String getBuildingStatus() {
		return buildingStatus;
	}
	public void setBuildingStatus(String buildingStatus) {
		this.buildingStatus = buildingStatus;
	}
	public String getStructaralMaterial() {
		return structaralMaterial;
	}
	public void setStructaralMaterial(String structaralMaterial) {
		this.structaralMaterial = structaralMaterial;
	}
	public String getArchitecturalStyle() {
		return architecturalStyle;
	}
	public void setArchitecturalStyle(String architecturalStyle) {
		this.architecturalStyle = architecturalStyle;
	}
	public String getFoundation() {
		return foundation;
	}
	public void setFoundation(String foundation) {
		this.foundation = foundation;
	}
	public String getUsageType() {
		return usageType;
	}
	public void setUsageType(String usageType) {
		this.usageType = usageType;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public String getFloors() {
		return floors;
	}
	public void setFloors(String floors) {
		this.floors = floors;
	}
	public String getCompletion() {
		return completion;
	}
	public void setCompletion(String completion) {
		this.completion = completion;
	}
	public String getElevators() {
		return elevators;
	}
	public void setElevators(String elevators) {
		this.elevators = elevators;
	}
	public String getParking() {
		return parking;
	}
	public void setParking(String parking) {
		this.parking = parking;
	}
	public String getArchitect() {
		return architect;
	}
	public void setArchitect(String architect) {
		this.architect = architect;
	}
	public String getDeveloper() {
		return developer;
	}
	public void setDeveloper(String developer) {
		this.developer = developer;
	}
	public String getContractor() {
		return contractor;
	}
	public void setContractor(String contractor) {
		this.contractor = contractor;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getComments() {
		return comments;
	}
	public void setComments(String comments) {
		this.comments = comments;
	}
	public String getAvgRent() {
		return avgRent;
	}
	public void setAvgRent(String avgRent) {
		this.avgRent = avgRent;
	}
	public void setBedrooms(String bedrooms) {
		this.Bedrooms = bedrooms;
	}
	public String getBedrooms() {
		return Bedrooms;
	}

	public void setCount(int count) {
		this.Count = count;
	}
	public int getCount() {
		return this.Count;
	}

	public void setPrice_AED(String price) {
		this.Price_AED = price;
	}
	public String getPrice_AED() {
		return this.Price_AED;
	}
}
