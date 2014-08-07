package com.topspot;

import java.io.IOException;
import java.sql.*;
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

public class ProcessBayut {
	private static Connection conn = null;
	private static int count = 0;
	private PreparedStatement pstmt = null;
	private static int connCounter = 0;
	private static List<ParseBean> listBayutPB = new ArrayList<ParseBean>();

	public void process() {
		System.out.println(GetCurrentTimestamp() + "  Processing Bayut data......");
		System.out.println(GetCurrentTimestamp() + "  Getting Bayut URLs will take few minutes......");
		// String[] emirates = {"dubai", "abu-dhabi", "ajman", "sharjah", "ras-al-khaimah", "umm-al-quwain", "fujairah"};
		String[] emirates = { "5002", "6020", "5385", "5351", "5509", "5544", "6542" };
		/*
		 * Cat_Ids(emirates) for Bayut.com
		 * 
		 * dubai: 			5002 
		 * abu-dhabi: 		6020 
		 * ajman: 			5385 
		 * sharjah: 		5351 
		 * ras-al-khaimah: 	5509 
		 * umm-al-quwain: 	5544 
		 * fujairah: 		6542
		 * 
		 */
		String[] propertyTypes = { "residential", "commercial" };
		String[] types = { "buy", "rent" };
		String domain = "http://www.bayut.com/";

		for (int pIndex = 0; pIndex < propertyTypes.length; pIndex++) {
			for (int eIndex = 0; eIndex < emirates.length; eIndex++) {
				for (int tIndex = 0; tIndex < types.length; tIndex++) {
					this.parseURLForLinks(domain, propertyTypes[pIndex], emirates[eIndex], types[tIndex]);
				}
			}
		}
		System.out.println(GetCurrentTimestamp() + "  Bayut URL Count: " + listBayutPB.size());
		for (ParseBean pb : listBayutPB) {
			this.parseResponse(pb.getURL(), pb.getRent_Sales(), pb.getCategory());
		}
		System.out.println(GetCurrentTimestamp() + "  Processing Bayut data Completed......");
	}

	public List<ParseBean> getSiteUrlsFromDatabase() {
		// Old one. Now we are getting Urls dynamically (Method: parseURLForLinks) instead of getting urls from Database
		List<ParseBean> listPB = new ArrayList<ParseBean>();
		try (Connection connection = UtilityClass.dbConnection();
				Statement stmt = connection.createStatement();) {
			// String query = "SELECT * FROM domain_links WHERE Domain='Bayut.com' AND Category='Residential' AND Rent_Sales LIKE 'Sale%'";
			String query = "SELECT * FROM domain_links WHERE Domain = 'Bayut.com'";
			ResultSet rs = stmt.executeQuery(query);
			while (rs.next()) {
				ParseBean objPB = new ParseBean();
				objPB.setURL(rs.getString("link"));
				objPB.setCategory(rs.getString("Category"));
				objPB.setRent_Sales(rs.getString("Rent_Sales"));
				listPB.add(objPB);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return listPB;
	}

	public void parseURLForLinks(String domain, String propertyType, String emirate, String rent_sale) {
		Document doc = null;
		HttpClient client = new DefaultHttpClient();
		String purpose, propType, strpurpose;
		if (propertyType == "residential") {
			propType = "3,16,4,12,14,17,";
		} else {
			propType = "5,6,7,8,13,15,9,10,11,";
		}
		if (rent_sale == "buy") {
			purpose = "1";
			strpurpose = "sale";
		} else {
			purpose = "2";
			strpurpose = "rent";
		}
		String searchURL = domain + "search/results.html?rd_purpose=" + purpose + "&page_view=1&page=1&cat_id=" + emirate + ",&property_type=" + propType + "#rd_purpose=" + purpose + "&page_view=1&page=1&cat_id=" + emirate + ",&property_type=" + propType;
		// System.out.println(searchURL);
		HttpGet request = new HttpGet(searchURL);
		try {
			HttpResponse response = client.execute(request);
			doc = Jsoup.parse(response.getEntity().getContent(), null, domain);
			if (doc != null) {
				int noPages = 0;
				Elements objElementNoPages = doc.getElementsByClass("pg_page_of_pages_txt");
				ListIterator<Element> obListNoPages = objElementNoPages.listIterator();
				while (obListNoPages.hasNext()) {
					Element objElementNoPage = obListNoPages.next();
					Elements objElements2 = objElementNoPage.children();
					ListIterator<Element> obList2 = objElements2.listIterator();
					while (obList2.hasNext()) {
						Element objElement3 = obList2.next();
						org.jsoup.nodes.Attributes objAttrs = objElement3.attributes();
						Iterator<org.jsoup.nodes.Attribute> objattrItr = objAttrs.iterator();
						while (objattrItr.hasNext()) {
							org.jsoup.nodes.Attribute objAttr = objattrItr.next();
							if (objAttr.getKey().equals("value")) {
								noPages = Integer.parseInt(objAttr.getValue());
							}
						}
					}
				}
				if (noPages == 0) {
					  String link = "http://www.bayut.com/search/results.html?rd_purpose=" + purpose + "&page_view=1&page=" + 1 + "&cat_id=" + emirate + ",&property_type=" + propType + "#rd_purpose=" + purpose + "&page_view=1&page=" + 1 + "&cat_id=" + emirate + ",&property_type=" + propType;
					  ParseBean objPB = new ParseBean();
					  objPB.setURL(link);
					  objPB.setCategory(propertyType);
					  objPB.setRent_Sales(strpurpose);
					  listBayutPB.add(objPB);
				} else {
					for(int ind = 1; ind <= noPages ; ind++)
					{
						  String link = "http://www.bayut.com/search/results.html?rd_purpose=" + purpose + "&page_view=1&page=" + ind + "&cat_id=" + emirate + ",&property_type=" + propType + "#rd_purpose=" + purpose + "&page_view=1&page=" + ind + "&cat_id=" + emirate + ",&property_type=" + propType;
						  ParseBean objPB = new ParseBean();
						  objPB.setURL(link);
						  objPB.setCategory(propertyType);
						  objPB.setRent_Sales(strpurpose);
						  listBayutPB.add(objPB);
					}
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
	
	public void parseResponse(String siteUrl, String sitePurpose, String siteComRes) {
		siteUrl = siteUrl.replace("#", "");
		String substrURL = siteUrl.substring(siteUrl.lastIndexOf("?") + 1, siteUrl.length());
		siteUrl += "#" + substrURL;
		System.out.println(GetCurrentTimestamp() + "  " + siteUrl);
		
		int index = 0;
		Document doc = null;
		HttpClient client = new DefaultHttpClient();
		HttpGet request = new HttpGet(siteUrl);

		try {
			HttpResponse response = client.execute(request);
			doc = Jsoup.parse(response.getEntity().getContent(), null,"bayut.com");
			if (doc != null) {
				Elements objElements = doc.getElementsByClass("listing");
				ListIterator<Element> obList = objElements.listIterator();
				while (obList.hasNext()) {
					BayutDetails objBayutDetails = new BayutDetails();
					Element objElement = obList.next();
					// Start Area and Building name
					Elements objElements1 = objElement.getElementsByClass("_left");
					ListIterator<Element> obList1 = objElements1.listIterator();
					while (obList1.hasNext()) {
						Element objElement1 = obList1.next();
						Elements objElements2 = objElement1.children();
						ListIterator<Element> obList2 = objElements2.listIterator();
						while (obList2.hasNext()) {
							Element objElement3 = obList2.next();
							org.jsoup.nodes.Attributes objAttrs = objElement3.attributes();
							Iterator<org.jsoup.nodes.Attribute> objattrItr = objAttrs.iterator();
							while (objattrItr.hasNext()) {
								org.jsoup.nodes.Attribute objAttr = objattrItr.next();
								if (objAttr.getKey().equals("href")) {
									objBayutDetails.setReference(objAttr.getValue());
								}
							}

							String str = objElement3.text();
							String[] strs = str.split("-");
							if (strs.length >= 2) {
								objBayutDetails.setArea(strs[0]);
								objBayutDetails.setBuildingName(strs[1]);
							} else {
								objBayutDetails.setBuildingName(str);

							}
						}
					}
					// End Area and Building name

					// Start BedRoom types
					Elements objElementsBeds = objElement.getElementsByClass("beds");
					ListIterator<Element> obListBeds = objElementsBeds.listIterator();
					while (obListBeds.hasNext()) {
						Element objElement1 = obListBeds.next();
						String str = objElement1.text();
						objBayutDetails.setBedRoomType(str);
					}
					// End BedRoom types

					// Start SQFT
					Elements objElementsArea = objElement.getElementsByClass("area");
					ListIterator<Element> obListArea = objElementsArea.listIterator();
					while (obListArea.hasNext()) {
						Element objElement1 = obListArea.next();
						Elements objElements2 = objElement1.children();
						ListIterator<Element> obList2 = objElements2.listIterator();
						while (obList2.hasNext()) {
							Element objElement3 = obList2.next();
							String str = objElement3.text();
							str = str.replaceAll("\\D+", "");
							objBayutDetails.setSQFT(str);
						}
					}
					// End SQFT

					// Start AED
					Elements objElementsAED = objElement.getElementsByClass("_right");
					ListIterator<Element> obListAED = objElementsAED.listIterator();
					while (obListAED.hasNext()) {
						Element objElement1 = obListAED.next();
						Elements objElements2 = objElement1.children();
						ListIterator<Element> obList2 = objElements2.listIterator();
						while (obList2.hasNext()) {
							Element objElement3 = obList2.next();
							String str = objElement3.text();
							str = str.replaceAll("\\D+", "");
							objBayutDetails.setAED(str);
						}

					}
					// End AED
//					if (objBayutDetails.getAED().length() > 0 && objBayutDetails.getSQFT().length() > 0) {
//						objBayutDetails.setPriPerSqft(Double.parseDouble(objBayutDetails.getAED()) / Double.parseDouble(objBayutDetails.getSQFT()));
//					}
					
					try {
						// System.out.println("conn123----->"+conn.toString());
						if (conn == null || conn.isClosed()) {
							conn = UtilityClass.dbConnection();
							System.out.println("Bayut Connection Counter: -----> " + connCounter);
							connCounter ++;
						}
						pstmt = conn.prepareStatement("INSERT INTO bayut_data (Sno,domain_name, Bedrooms, "
								+ "Price_AED, sqft, Build_Area, Building, Reference, com_res, rent_sales,data_captured_time_stamp,Sub_Area)"
								+ " VALUES(?,?,?,?,?,?,?,?,?,?,?,?)");
						// TBD
						long endTime = System.currentTimeMillis();
						count = count + 1;
						pstmt.setInt(1, count);
						pstmt.setString(2, "Bayut");
						pstmt.setString(3, "" + objBayutDetails.getBedRoomType());
						pstmt.setString(4, "" + objBayutDetails.getAED());
						pstmt.setString(5, "" + objBayutDetails.getSQFT());
						pstmt.setString(6, "" + objBayutDetails.getArea());
						pstmt.setString(7, "" + objBayutDetails.getBuildingName());
						pstmt.setString(8, "" + objBayutDetails.getReference());
						pstmt.setString(9, siteComRes);
						pstmt.setString(10, sitePurpose);
						pstmt.setString(11, "" + endTime);
						pstmt.setString(12, "" + objBayutDetails.getArea());
						index = index + 1;

						conn.setAutoCommit(true);
						pstmt.executeUpdate();
					} catch (Exception ex) {
						System.out.println("Ex----->" + ex);
						ex.printStackTrace();
					}
				}
			}
		} catch (Exception ex) {
			System.out.println("Ex----->" + ex);
			ex.printStackTrace();
		}
	}
	
	public String GetCurrentTimestamp() {
		java.util.Date date= new java.util.Date();
		Timestamp ts = new Timestamp(date.getTime());
		return ts.toString();
	}
}
