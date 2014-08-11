package com.topspot;

import java.sql.*;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.topspot.common.Constants;
public class ProcessPropertyFinder 
{
	private static Connection conn = null;
	private static int count = 0;
	private static int connCounter = 0;
	private PreparedStatement pstmt = null;
	private static List<ParseBean> listPropertyFinderPB = new ArrayList<ParseBean>();
	static Constants objConstants = new Constants();
	private static String DBName = objConstants.getValue("DBName");
	public void process()
	{
		System.out.println(GetCurrentTimestamp() + "  Processing Property Finder data......");
		System.out.println(GetCurrentTimestamp() + "  Getting Property Finder URLs will take more minutes......");
		String[] emirates = { "dubai", "abu-dhabi", "ajman", "sharjah",
				"ras-al-khaimah", "umm-al-quwain", "fujairah" };
		String[] propertyTypes = { "Apartment", "Bulk-Sale-Units", "Bungalow",
				"Compound", "Duplex", "Full-floor", "Half-floor",
				"Hotel/Hotel-Apartment", "land", "Penthouse", "villa",
				"Townhouse", "Whole-Building", "labor-camp", "factory",
				"office-space", "plot", "retail", "shop", "show-room",
				"warehouse", "staff-accommodation" };
		String[] types = { "buy", "rent", "commercial" };
		String domain = "http://www.propertyfinder.ae/";
		
		for (int pIndex = 0; pIndex < propertyTypes.length; pIndex++) {
			for (int eIndex = 0; eIndex < emirates.length; eIndex++) {
				for (int tIndex = 0; tIndex < types.length; tIndex++) {
					parseURLForLinks(domain, propertyTypes[pIndex], emirates[eIndex], types[tIndex]);
				}
			}
		}
		System.out.println(GetCurrentTimestamp() + "  PropertyFinder URL Count: " + listPropertyFinderPB.size());
		for (ParseBean pb : listPropertyFinderPB) 
		{
			this.parseResponse(pb.getURL(), pb.getRent_Sales(), pb.getCategory());
		}
		System.out.println(GetCurrentTimestamp() + "  Processing Property Finder data Completed......");
	}
	
	public List<ParseBean> getSiteUrlsFromDatabase() 
	{
		// Old one. Now we are getting Urls dynamically (Method: parseURLForLinks) instead of getting urls from Database
		List<ParseBean> listPB = new ArrayList<ParseBean>();
		try (Connection connection = UtilityClass.dbConnection();Statement stmt = connection.createStatement();) 
		{
			String query = "SELECT link, Category, Rent_Sales FROM " + DBName + ".domain_links WHERE Domain = 'propertyfinder.ae'  LIMIT 317, 9999";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) 
			{
				ParseBean objPB = new ParseBean();
				objPB.setURL(rs.getString("link"));
				objPB.setCategory(rs.getString("Category"));
				objPB.setRent_Sales(rs.getString("Rent_Sales"));
				listPB.add(objPB);
			}

		} catch (Exception e) 
		{
			e.printStackTrace();
		}
		return listPB;
	}
	
	public void parseURLForLinks(String domain, String propertyType, String emirate, String type) {
		Document doc = null;
		HttpClient client = new DefaultHttpClient();
		String tempURL = "";
		List<String> searchURLs = new ArrayList<String>();
		
		switch (type) {
		case "buy":
			tempURL = domain + "en/" + type + "/" + emirate + "/" + propertyType + "-for-sale.html";
			searchURLs.add(tempURL + "?t/16/v/1");
			break;
		case "rent":
			tempURL = domain + "en/" + type + "/" + emirate + "/" + propertyType + "-for-" + type + ".html";
			searchURLs.add(tempURL + "?t/16/v/4");
			searchURLs.add(tempURL + "?t/16/v/3");
			searchURLs.add(tempURL + "?t/16/v/7");
			searchURLs.add(tempURL + "?t/16/v/6");
			break;
		case "commercial":
			tempURL = domain + "en/" + type + "/" + emirate + "/" + propertyType + "-for-sale.html";
			searchURLs.add(tempURL + "?t/0-16/v/3-1");
			tempURL = domain + "en/" + type + "/" + emirate + "/" + propertyType + "-for-rent.html";
			searchURLs.add(tempURL + "?t/0-16/v/4-4");
			searchURLs.add(tempURL + "?t/0-16/v/4-3");
			searchURLs.add(tempURL + "?t/0-16/v/4-8");
			break;

		default:
			break;
		}
		
		for (String searchURL : searchURLs) {
			// System.out.println(searchURL);
			HttpGet request = new HttpGet(searchURL);
			try {
				HttpResponse response = client.execute(request);
				doc = Jsoup.parse(response.getEntity().getContent(), null, domain);
				if (doc != null) {
					int noPages = 0;
					Elements objElementNoPages = doc.getElementsByClass("search-results-number");
					ListIterator<Element> obListNoPages = objElementNoPages.listIterator();
					while (obListNoPages.hasNext()) {
						
						Element objElementNoPage = obListNoPages.next();
						String strSize = objElementNoPage.text();
						if (strSize.indexOf("of") > 0) {
							String[] NoRecords = strSize.split("of");
							noPages = Integer.parseInt(NoRecords[1].trim().replace(".", ""));
							noPages = (int) Math.ceil(noPages/15);
						}
					}
					// System.out.println("PropertyFinder No Of Pages: " + noPages);
					for(int ind = 0; ind < noPages ; ind++)
					{
						String link = "", rent_sale = "";
						if (searchURL.indexOf("sale.html") > 0) {
							rent_sale = "sale";
						} else if (searchURL.indexOf("rent.html") > 0) {
							rent_sale = "rent";
						}
						if (ind == 0) {
							link = searchURL;
						} else {
							link = searchURL.replace(".html", "-page" + (ind + 1) + ".html");
						}
						
						ParseBean objPB = new ParseBean();
						objPB.setURL(link);
						objPB.setCategory(propertyType);
						objPB.setRent_Sales(rent_sale);
						listPropertyFinderPB.add(objPB);
					}
				}
				
			} catch (ClientProtocolException e1) {
				e1.printStackTrace();
			} catch (IllegalStateException e) {
				e.printStackTrace();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	public void parseResponse(String siteUrl, String sitePurpose, String siteComRes) 
	{
		System.out.println(GetCurrentTimestamp() + "  " + siteUrl);
		Document doc = null;
		HttpClient client = new DefaultHttpClient();
		HttpGet request = new HttpGet(siteUrl);
		
		try 
		{
			HttpResponse response = client.execute(request);
			doc = Jsoup.parse(response.getEntity().getContent(), null, "http://www.propertyfinder.ae");
			
			Element objElement = doc.getElementById("content");
			Elements objElementsListing = objElement.getElementsByClass("general-listing");
			ListIterator<Element> obList = objElementsListing.listIterator();
			while (obList.hasNext()) 
			{

				Element objElement1 = obList.next();
				BayutDetails objPropertyFinderDetails = new BayutDetails();
				Elements objElementsBuilding = objElement1.getElementsByClass("category");
				ListIterator<Element> obListBuilding = objElementsBuilding.listIterator();
				while (obListBuilding.hasNext()) {
					
					// **********************  Building Name/Area/Sub-Area/City - Start **********************
					String Area = "", SubArea = "", buildingName = "";
					Element objElement2 = obListBuilding.next();
					String str = objElement2.text();
					String[] strAreaDetails = str.split(",");
					if (strAreaDetails.length >= 4) {
						Area = strAreaDetails[1];
						SubArea = strAreaDetails[2];
						buildingName = strAreaDetails[3];
						
						objPropertyFinderDetails.setCity(strAreaDetails[0]);
						// System.out.println("City  ---> " + strAreaDetails[0]);
					} else if (strAreaDetails.length == 3) {
						Area = strAreaDetails[0];
						SubArea = strAreaDetails[1];
						buildingName = strAreaDetails[2];
					}
					objPropertyFinderDetails.setArea(Area);
					objPropertyFinderDetails.setSubArea(SubArea);
					objPropertyFinderDetails.setBuildingName(buildingName);
					// System.out.println("Area --->" + Area);
					// System.out.println("SubArea --->" + SubArea);
					// System.out.println("buildingName --->" + buildingName);
				}
				// **********************  Building Name/Area/Sub-Area/City - End **********************

				// **********************  Bedroom Type - Start **********************
				Elements objElementsBedrooms = objElement1.getElementsByClass("bedroom");
				ListIterator<Element> obListBedrooms = objElementsBedrooms.listIterator();
				while (obListBedrooms.hasNext()) {
					Element objElement3 = obListBedrooms.next();
					Elements objElements3 = objElement3.children();
					ListIterator<Element> obList3 = objElements3.listIterator();
					while (obList3.hasNext()) {
						Element objElement4 = obList3.next();
						String str = objElement4.text();
						if (str == null || str.equalsIgnoreCase("null") || str.equalsIgnoreCase("NULL")) {
							str = "0";
						}
						objPropertyFinderDetails.setBedRoomType(str);
						// System.out.println("Bedroom Type ---> " + str);
					}
				}
				// **********************  Bedroom Type - End **********************

				// **********************  Building Type and SQFT - Start **********************
				Elements objElementsBuildSQFT = objElement1.getElementsByClass("type");
				ListIterator<Element> obListBuildSQFT = objElementsBuildSQFT.listIterator();
				while (obListBuildSQFT.hasNext()) {
					Element objElement5 = obListBuildSQFT.next();
					Elements objElements5 = objElement5.children();
					ListIterator<Element> obList5 = objElements5.listIterator();
					int Inde = 1;
					while (obList5.hasNext()) {
						Element objElement6 = obList5.next();
						String str = objElement6.text();
						if (Inde == 1) {
							str = str.replaceAll("\\D+", "");
							objPropertyFinderDetails.setSQFT(str);
							// System.out.println("Bedroom Type ---> " + str);
						} else if (Inde == 2) {
							objPropertyFinderDetails.setBuildingType(str);
							// System.out.println("Bedroom Type ---> " + str);
						}
						Inde = Inde + 1;
					}
				}
				// **********************  Building Type and SQFT - End **********************

				// **********************  AED - Start **********************
				Elements objElementsAED = objElement1.getElementsByClass("amount");
				ListIterator<Element> obListAED = objElementsAED.listIterator();
				while (obListAED.hasNext()) {
					Element objElement7 = obListAED.next();
					Elements objElements7 = objElement7.children();
					ListIterator<Element> obList7 = objElements7.listIterator();
					int Inde = 1;
					while (obList7.hasNext()) {
						Element objElement8 = obList7.next();
						String str = objElement8.text();
						if (Inde == 2) {
							str = str.replaceAll("\\D+", "");
							objPropertyFinderDetails.setAED(str);
							// System.out.println("AED ---> " + str);
						}
						Inde = Inde + 1;
					}
				}
				// **********************  AED - End **********************

				// **********************  Reference - Start **********************
				Elements objElementsRef = objElement1.getElementsByClass("btnMore");
				ListIterator<Element> obListRef = objElementsRef.listIterator();
				while (obListRef.hasNext()) {
					Element objElementRef = obListRef.next();
					org.jsoup.nodes.Attributes objAttrs = objElementRef.attributes();
					Iterator<org.jsoup.nodes.Attribute> objattrItr = objAttrs.iterator();
					while (objattrItr.hasNext()) {
						org.jsoup.nodes.Attribute objAttr = objattrItr.next();
						if (objAttr.getKey().equals("href")) {
							objPropertyFinderDetails.setReference(objAttr.getValue());
							// System.out.println("Reference ---> " + objAttr.getValue());
						}
					}

				}
				// **********************  Reference - End **********************
				
				// **********************  Price/SQFT - Start **********************
//				if (objPropertyFinderDetails.getAED().length() > 0 && objPropertyFinderDetails.getSQFT().length() > 0) {
//					objPropertyFinderDetails.setPriPerSqft(Double.parseDouble(objPropertyFinderDetails.getAED()) / Double.parseDouble(objPropertyFinderDetails.getSQFT()));
//				}
				// System.out.println("Price/SQFT ---> " + objJustRentalDetails.getAED() / objJustRentalDetails.getSQFT());
				// **********************  Price/SQFT - End **********************
				
				// **********************  Insert PropertyFinder Object into DB - Start **********************
				try 
				{
					if (conn == null || conn.isClosed())
					{
						conn = UtilityClass.dbConnection();
						System.out.println("PropertyFinder Connection Counter: -----> " + connCounter);
						connCounter ++;
					}
					// System.out.println("conn123----->" + conn.toString());
					pstmt = conn.prepareStatement("INSERT INTO propertyfinder_data (Sno,domain_name, Bedrooms, " + 
		                     "Price_AED, sqft, Build_Area, Building, Reference, com_res, rent_sales,data_captured_time_stamp,Sub_Area, Build_Type, City)" +
		                     " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)"); 

					long endTime = System.currentTimeMillis();
					count = count + 1;
					pstmt.setInt(1, count);
					pstmt.setString(2, "propertyfinder");
					pstmt.setString(3, objPropertyFinderDetails.getBedRoomType());
					pstmt.setString(4, objPropertyFinderDetails.getAED());
					pstmt.setString(5, objPropertyFinderDetails.getSQFT());
					pstmt.setString(6, objPropertyFinderDetails.getArea());
					pstmt.setString(7, objPropertyFinderDetails.getBuildingName());
					pstmt.setString(8, objPropertyFinderDetails.getReference());
					pstmt.setString(9, siteComRes);
					pstmt.setString(10, sitePurpose);
					pstmt.setLong(11, (long) endTime);
					pstmt.setString(12, objPropertyFinderDetails.getSubArea());
					pstmt.setString(13, objPropertyFinderDetails.getBuildingType());
					pstmt.setString(14, objPropertyFinderDetails.getCity());
					
					// System.out.println("End of Property count : " + count);
					conn.setAutoCommit(true);
					pstmt.executeUpdate();
				} catch (SQLException e) 
				{
					System.out.println("Ex----->" + e);
					e.printStackTrace();
				}
				// **********************  Insert PropertyFinder Object into DB - End **********************
			}

		} catch (NumberFormatException e) {
			e.printStackTrace();
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public String GetCurrentTimestamp() {
		java.util.Date date= new java.util.Date();
		Timestamp ts = new Timestamp(date.getTime());
		return ts.toString();
	}
	
}
