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

public class ProcessJustProperty 
{
	private static Connection conn = null;
	private static int count = 0;
	private static int connCounter = 0;
	private PreparedStatement pstmt = null;
	private static List<ParseBean> listJustPropertyPB = new ArrayList<ParseBean>();
	
	public void process()
	{
		System.out.println(GetCurrentTimestamp() + "  Processing Just Property data......");
		System.out.println(GetCurrentTimestamp() + "  Getting Just Property URLs will take few minutes......");
		String[] emirates = {"dubai", "abu-dhabi", "ajman", "sharjah", "ras-al-khaimah", "umm-al-quwain", "fujairah"};
		String[] propertyTypes = {"land", "commercial", "apartments", "villas"};
		String domain = "http://www.justproperty.com/", rent_sale = "sale";;
		for (int pIndex = 0; pIndex < propertyTypes.length; pIndex++) {
			for (int eIndex = 0; eIndex < emirates.length; eIndex++) {
				parseURLForLinks(domain, propertyTypes[pIndex], emirates[eIndex], rent_sale);
			}
		}
		System.out.println(GetCurrentTimestamp() + "  JustProperty URL Count: " + listJustPropertyPB.size());
		for (ParseBean pb : listJustPropertyPB) 
		{
			this.parseResponse(pb.getURL(), pb.getRent_Sales(), pb.getCategory());
		}
		System.out.println(GetCurrentTimestamp() + "  Processing Just Property data Completed......");
	}
	
	public List<ParseBean> getSiteUrlsFromDatabase() 
	{
		// Old one. Now we are getting Urls dynamically (Method: parseURLForLinks) instead of getting urls from Database
		List<ParseBean> listPB = new ArrayList<ParseBean>();
		try (Connection connection = UtilityClass.dbConnection();Statement stmt = connection.createStatement();) 
		{
			String query = "SELECT link, Category, Rent_Sales FROM domain_links WHERE Domain = 'justproperty.com'";
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
	
	public void parseURLForLinks(String domain, String propertyType, String emirate, String rent_sale) {
		Document doc = null;
		HttpClient client = new DefaultHttpClient();
		String searchURL = domain + emirate + "/" + propertyType + "-for-sale.html";
		// http://www.justproperty.com/dubai/apartments-for-sale.html
		// System.out.println(searchURL);
		HttpGet request = new HttpGet(searchURL);
		try {
			HttpResponse response = client.execute(request);
			doc = Jsoup.parse(response.getEntity().getContent(), null, domain);
			if (doc != null) {
				int noPages = 0;
				Elements objElementNoPages = doc.getElementsByClass("pagination_result_of");
				ListIterator<Element> obListNoPages = objElementNoPages.listIterator();
				while (obListNoPages.hasNext()) {
					String strSize;
					String[] Nopages;
					Element objElementNoPage = obListNoPages.next();
					strSize = objElementNoPage.text();
					Nopages = strSize.split("of");
					noPages = Integer.parseInt(Nopages[1].trim());
				}
				for(int ind=0; ind < noPages ; ind++)
				{
					  String link = searchURL + "?pagin_flag=1&limit=20&limitstart=" +(ind * 20);
					  ParseBean objPB = new ParseBean();
					  objPB.setURL(link);
					  objPB.setCategory(propertyType);
					  objPB.setRent_Sales("sale");
					  listJustPropertyPB.add(objPB);
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
	
	public void parseResponse(String siteUrl, String sitePurpose, String siteComRes) 
	{
		System.out.println(GetCurrentTimestamp() + "  " + siteUrl);
		Document doc = null;
		HttpClient client = new DefaultHttpClient();
		HttpGet request = new HttpGet(siteUrl);
		
		try 
		{
			HttpResponse response = client.execute(request);
			doc = Jsoup.parse(response.getEntity().getContent(), null, "http://www.justproperty.com");

			Elements objElements = doc.getElementsByClass("search_listings_box");
			ListIterator<Element> obList = objElements.listIterator();
			while (obList.hasNext()) 
			{
				Element objElement = obList.next();
				BayutDetails objJustPropertyDetails = new BayutDetails();
				Elements objElementsBuilding = objElement.getElementsByClass("h4_service");
				ListIterator<Element> obListBuilding = objElementsBuilding.listIterator();
				while (obListBuilding.hasNext()) 
				{
					
					// **********************  Building Name/Area/Sub-Area - Start **********************
					String Area = "", SubArea = "", buildingName = "";
					Element objAppartmentInfo = obListBuilding.next();
					String strAppartmentInfo = objAppartmentInfo.text();
					// System.out.println("Building Address ---> " + strAppartmentInfo);
					String[] appartmentInfo = strAppartmentInfo.split("\\|");
					// System.out.println("Address Size --->" + appartmentInfo.length);
					if (siteComRes != null && siteComRes.equalsIgnoreCase("Commercial"))
					{
						if (appartmentInfo.length == 3) 
						{
							Area = appartmentInfo[2];
							SubArea = appartmentInfo[1];
							buildingName = appartmentInfo[1];
						} else if (appartmentInfo.length == 2)
						{
							Area = appartmentInfo[1];
							SubArea = appartmentInfo[1];
							buildingName = appartmentInfo[1];
						}
					} else if (siteComRes != null && !siteComRes.equalsIgnoreCase("Commercial")) 
					{
						if (appartmentInfo.length >= 4) 
						{
							Area = appartmentInfo[3];
							SubArea = appartmentInfo[2];
							buildingName = appartmentInfo[2];
						} else if (appartmentInfo.length == 3)
						{
							Area = appartmentInfo[2];
							SubArea = appartmentInfo[2];
							buildingName = appartmentInfo[2];
						}
					}
					objJustPropertyDetails.setArea(Area);
					objJustPropertyDetails.setSubArea(SubArea);
					objJustPropertyDetails.setBuildingName(buildingName);
					// System.out.println("Area --->" + Area);
					// System.out.println("SubArea --->" + SubArea);
					// System.out.println("buildingName --->" + buildingName);
					
					// **********************  Building Name/Area/Sub-Area - End **********************
				}
					
					// **********************  Bedroom Type and SQFT - Start **********************
					Elements objElementsBedrooms = objElement.getElementsByClass("listing_info");
					ListIterator<Element> obListBedrooms = objElementsBedrooms.listIterator();
					while (obListBedrooms.hasNext()) 
					{
						Element objBedRoomTypeAndSize = obListBedrooms.next();
						Elements objBedRoomTypeAndSizeChildren = objBedRoomTypeAndSize.children();
						ListIterator<Element> obList2 = objBedRoomTypeAndSizeChildren.listIterator();
						int index = 0;
						while (obList2.hasNext()) 
						{
							Element objElementSpan = obList2.next();
							String strSQFT = "", str = objElementSpan.text();
							if (siteComRes != null && siteComRes.equalsIgnoreCase("Commercial")) 
							{
								if (index > 1)
								{
									if (index == 2) 
									{
										strSQFT = str.replaceAll("\\D+", "");
										// System.out.println("SQFT --->" + strSQFT);
										objJustPropertyDetails.setSQFT(strSQFT);
									}
								}

							} else if (siteComRes != null && !siteComRes.equalsIgnoreCase("Commercial"))
							{
								if (index >= 0) 
								{
									if (index == 1)
									{
										String strBedrroms = str.replaceAll("\\D+", "");
										objJustPropertyDetails.setBedRoomType(strBedrroms);
										// System.out.println("Bedroom Type ---> " + strBedrroms);
									}
									if (index == 2) 
									{
										strSQFT = str.replaceAll("\\D+", "");
										// System.out.println("SQFT --->" + strSQFT);
										objJustPropertyDetails.setSQFT(strSQFT);
									}
								}
							}
							index = index + 1;
						}
					}
					// **********************  Bedroom Type and SQFT - End **********************
					
					
					// **********************  AED - Start **********************
					Elements objElementsAED = objElement.getElementsByClass("price_column");
					ListIterator<Element> obListAED = objElementsAED.listIterator();
					while (obListAED.hasNext())
					{
						Element objElementSpan = obListAED.next();
						String str = objElementSpan.text();
						String strAED = str.replaceAll("\\D+", "");
						objJustPropertyDetails.setAED(strAED);
						// System.out.println("AED ---> " + strAED);
					}
					// **********************  AED - End **********************
					
					
					// **********************  Reference - Start **********************
					Elements objElementsRef = objElement.getElementsByClass("photo");
					ListIterator<Element> obListRef = objElementsRef.listIterator();
					while (obListRef.hasNext()) 
					{
						Element objElement1 = obListRef.next();
						org.jsoup.nodes.Attributes objAttrs = objElement1.attributes();
						Iterator<org.jsoup.nodes.Attribute> objattrItr = objAttrs.iterator();
						while (objattrItr.hasNext()) 
						{
							org.jsoup.nodes.Attribute objAttr = objattrItr.next();
							if (objAttr.getKey().equals("href"))
							{
								objJustPropertyDetails.setReference("http://www.justproperty.com" + objAttr.getValue());
								// System.out.println("Reference ---> http://www.justproperty.com" + objAttr.getValue());
							}
						}

					}
					// **********************  Reference - End **********************
					
					
					// **********************  Price/SQFT - Start **********************
//					if (objJustPropertyDetails.getAED().length() > 0 && objJustPropertyDetails.getSQFT().length() > 0) {
//						objJustPropertyDetails.setPriPerSqft(Double.parseDouble(objJustPropertyDetails.getAED()) / Double.parseDouble(objJustPropertyDetails.getSQFT()));
//						// System.out.println("Price/SQFT ---> " + objJustPropertyDetails.getAED() / objJustPropertyDetails.getSQFT());
//					}
					// **********************  Price/SQFT - End **********************
					
					
					// **********************  Building Type - Start **********************
					objJustPropertyDetails.setBuildingType(siteComRes);
					// System.out.println("Building Type  ---> " + siteComRes);
					// **********************  Building Type - End **********************
					
					
					// **********************  Insert JustPropertyDetails Object into DB - Start **********************
					try 
					{
						if (conn == null || conn.isClosed())
						{
							conn = UtilityClass.dbConnection();
							System.out.println("JustProperty Connection Counter: -----> " + connCounter);
							connCounter ++;
						}
						// System.out.println("conn123----->" + conn.toString());
						pstmt = conn.prepareStatement("INSERT INTO justproperty_data (Sno,domain_name, Bedrooms, "
								+ "Price_AED, sqft, Build_Area, Building, Reference, com_res, rent_sales,data_captured_time_stamp,Sub_Area, Build_Type, City)"
								+ " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");

						long endTime = System.currentTimeMillis();
						count = count + 1;
						pstmt.setInt(1, count);
						pstmt.setString(2, "justproperty");
						pstmt.setString(3, objJustPropertyDetails.getBedRoomType());
						pstmt.setString(4, objJustPropertyDetails.getAED());
						pstmt.setString(5, objJustPropertyDetails.getSQFT());
						pstmt.setString(6, objJustPropertyDetails.getArea());
						pstmt.setString(7, objJustPropertyDetails.getBuildingName());
						pstmt.setString(8, objJustPropertyDetails.getReference());
						if (siteComRes != null && siteComRes.equalsIgnoreCase("Commercial")) 
						{
							pstmt.setString(9, siteComRes);
						} else 
						{
							pstmt.setString(9, "Residential");
						}
						pstmt.setString(10, sitePurpose);
						pstmt.setLong(11, (long) endTime);
						pstmt.setString(12, objJustPropertyDetails.getSubArea());
						pstmt.setString(13, objJustPropertyDetails.getBuildingType());
						pstmt.setString(14, objJustPropertyDetails.getCity());
						
						// System.out.println("End of Property count : " + count);
						conn.setAutoCommit(true);
						pstmt.executeUpdate();
					} catch (SQLException e) 
					{
						System.out.println("Ex----->" + e);
						e.printStackTrace();
					}
					// **********************  Insert JustPropertyDetails Object into DB - End **********************

				}
		} catch (NumberFormatException e) 
		{
			e.printStackTrace();
		} catch (ClientProtocolException e) 
		{
			e.printStackTrace();
		} catch (IllegalStateException e) 
		{
			e.printStackTrace();
		} catch (IOException e) 
		{
			e.printStackTrace();
		}
	}
	
	public String GetCurrentTimestamp() {
		java.util.Date date= new java.util.Date();
		Timestamp ts = new Timestamp(date.getTime());
		return ts.toString();
	}
	
}
