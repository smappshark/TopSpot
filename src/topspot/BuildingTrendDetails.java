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
	private int Floors;
	private int Height;
	private int Completion;
	private String Developer;
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
	public int getFloors() {
		return Floors;
	}
	public void setFloors(int floors) {
		Floors = floors;
	}
	public int getHeight() {
		return Height;
	}
	public void setHeight(int height) {
		Height = height;
	}
	public int getCompletion() {
		return Completion;
	}
	public void setCompletion(int completion) {
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
	
}
