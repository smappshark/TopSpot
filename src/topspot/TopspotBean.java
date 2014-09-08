package topspot;

import java.util.ArrayList;
import java.util.List;


public class TopspotBean {
	String buildingName;
	String roomType;
	int buildValue;
	int buildingListLength;
	int noOfBedroomsAvaialable;
	public List<String> buildingList = new ArrayList<String>();
	public List<String> areaList = new ArrayList<String>();
	public List<Integer> areaCountList = new ArrayList<Integer>();
	public List<String> buildinRoomTypeList = new ArrayList<String>();
	

	public String getBuildingName() {
		return buildingName;
	}

	public void setBuildingName(String buildingName) {
		this.buildingName = buildingName;
	}
	
	public int getBuildingListLength() {
		return buildingListLength;
	}

	public void setBuildingListLength(int buildingListLength) {
		this.buildingListLength = buildingListLength;
	}
	
	public String getBuildingRoomType() {
		return roomType;
	}

	public void setBuildingRoomType(String roomType) {
		this.roomType = roomType;
	}


	public int getBuildValue() {
		return buildValue;
	}

	public void setBuildValue(int buildValue) {
		this.buildValue = buildValue;
	}
	
	public int getNoOfAvaialableRooms() {
		return noOfBedroomsAvaialable;
	}

	public void setNoOfAvaialableRooms(int noOfBedroomsAvaialable) {
		this.noOfBedroomsAvaialable = noOfBedroomsAvaialable;
	}
	
	public List<String> getBuildingList() {
		return buildingList;
	}

	public void setBuildingList(List<String> buildingList) {
		this.buildingList = buildingList;
	}
	public List<String> getBuildingRoomTypeList() {
		return buildinRoomTypeList;
	}

	public void setBuildingRoomTypeList(List<String> buildinRoomTypeList) {
		this.buildinRoomTypeList = buildinRoomTypeList;
	}
	
	
	public List<String> getAreaList() {
		return areaList;
	}

	public void setAreaList(List<String> areaList) {
		this.areaList = areaList;
	}
	
	public List<Integer> getAreaCountList() {
		return areaCountList;
	}

	public void setAreaCountList(List<Integer> areaCountList) {
		this.areaCountList = areaCountList;
	}
}
