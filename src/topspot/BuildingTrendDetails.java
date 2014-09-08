package topspot;

import java.util.Date;

public class BuildingTrendDetails {
	private String Building;
	private double fromPriPerSqft;
	private double toPriPerSqft;
	private Date fromTrandate;
	private Date toTrandate;
	private String City;
	private String Area;
	private String Building_Type;
	private String Floors;
	private int Height;
	private String Completion;
	private String Developer;
	private String usageType;
	private String buildingStatus;
	
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
	public String getBuilding_Type() {
		return Building_Type;
	}
	public void setBuilding_Type(String building_Type) {
		Building_Type = building_Type;
	}
	public String getFloors() {
		return Floors;
	}
	public void setFloors(String floors) {
		Floors = floors;
	}
	public int getHeight() {
		return Height;
	}
	public void setHeight(int height) {
		Height = height;
	}
	public String getCompletion() {
		return Completion;
	}
	public void setCompletion(String completion) {
		Completion = completion;
	}
	public String getDeveloper() {
		return Developer;
	}
	public void setDeveloper(String developer) {
		Developer = developer;
	}
	public String getBuilding() {
		return Building;
	}
	public void setBuilding(String building) {
		Building = building;
	}
	public double getFromPriPerSqft() {
		return fromPriPerSqft;
	}
	public void setFromPriPerSqft(double fromPriPerSqft) {
		this.fromPriPerSqft = fromPriPerSqft;
	}
	public double getToPriPerSqft() {
		return toPriPerSqft;
	}
	public void setToPriPerSqft(double toPriPerSqft) {
		this.toPriPerSqft = toPriPerSqft;
	}
	public Date getFromTrandate() {
		return fromTrandate;
	}
	public void setFromTrandate(Date fromTrandate) {
		this.fromTrandate = fromTrandate;
	}
	public Date getToTrandate() {
		return toTrandate;
	}
	public void setToTrandate(Date toTrandate) {
		this.toTrandate = toTrandate;
	}
	public String getUsage() {
		return usageType;
	}
	public void setUsage(String usageType) {
		this.usageType = usageType;
	}
	
	public String getBuildingStatus() {
		return buildingStatus;
	}
	public void setBuildingStatus(String buildingStatus) {
		this.buildingStatus = buildingStatus;
	}
	
}
