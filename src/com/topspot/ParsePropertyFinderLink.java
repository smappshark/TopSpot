package com.topspot;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
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

import com.google.appengine.api.utils.SystemProperty;

public class ParsePropertyFinderLink {
	public static Connection conn = null;
	public static int count=0;
	 public static void main(String[] args) throws ClientProtocolException, IOException {
		 ParsePropertyFinderLink objParsePropertyFinderLink = new ParsePropertyFinderLink();
	/*	 String siteUrl1="http://www.propertyfinder.ae/en/buy/dubai/properties-for-sale.html?t/16/v/1";
		 String siteUrl2="http://www.propertyfinder.ae/en/rent/dubai/properties-for-rent.html?t/16/v/4";
		 String siteUrl3="http://www.propertyfinder.ae/en/commercial/dubai/properties-for-sale.html?t/0-16/v/3-1";
		 String siteUrl4="http://www.propertyfinder.ae/en/commercial/dubai/properties-for-rent.html?t/0-16/v/4-4";
		 
		 conn=UtilityClass.dbConnection();
			count= UtilityClass.recordCount();
		 objParsePropertyFinderLink.parseResponseForNoPages(siteUrl1);
		 System.out.println("siteUrl1 completed --- >");
		 objParsePropertyFinderLink.parseResponseForNoPages(siteUrl2);
		 System.out.println("siteUrl2 completed --- >");
		 objParsePropertyFinderLink.parseResponseForNoPages(siteUrl3);
		 System.out.println("siteUrl3 completed --- >");
		 objParsePropertyFinderLink.parseResponseForNoPages(siteUrl4);
		 System.out.println("siteUrl4 completed --- >");*/
	 }
	 
	 public ParsePropertyFinderLink()
	 {
		 String siteUrl1="http://www.propertyfinder.ae/en/buy/dubai/properties-for-sale.html?t/16/v/1";
		 String siteUrl2="http://www.propertyfinder.ae/en/rent/dubai/properties-for-rent.html?t/16/v/4";
		 String siteUrl3="http://www.propertyfinder.ae/en/commercial/dubai/properties-for-sale.html?t/0-16/v/3-1";
		 String siteUrl4="http://www.propertyfinder.ae/en/commercial/dubai/properties-for-rent.html?t/0-16/v/4-4";
		// ParsePropertyFinderLink objParsePropertyFinderLink = new ParsePropertyFinderLink();
		// conn=UtilityClass.dbConnection();
		 conn=UtilityClass.conn;
		 UtilityClass.purgeDomains("propertyfinder_data");
			count= UtilityClass.recordCount("propertyfinder_data");
		 parseResponseForNoPages(siteUrl1);
		 System.out.println("siteUrl1 completed --- >");
		 parseResponseForNoPages(siteUrl2);
		 System.out.println("siteUrl2 completed --- >");
		 parseResponseForNoPages(siteUrl3);
		 System.out.println("siteUrl3 completed --- >");
		 parseResponseForNoPages(siteUrl4);
		 System.out.println("siteUrl4 completed --- >");
	 }
	 
	 public void dbConnection()
	 {
		 
		 try
		  {
			  String url = null;
		/*	  if (SystemProperty.environment.value() ==
			      SystemProperty.Environment.Value.Production) {
			    // Load the class that provides the new "jdbc:google:mysql://" prefix.
			    Class.forName("com.mysql.jdbc.GoogleDriver");
			    url = "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root";
			  } else { */
			    // Local MySQL instance to use during development.
			  /*  Class.forName("com.mysql.jdbc.Driver");
			    url = "jdbc:mysql://127.0.0.1:3306/topspot?user=root";*/
			  Class.forName("com.mysql.jdbc.GoogleDriver");
			    url = "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root";
			//  }
			  conn = DriverManager.getConnection(url);
			  System.out.println("conn----->"+conn.toString());
		  }
		  catch(Exception ex)
		  {
			  System.out.println("Ex----->"+ex);
		  }
		 
	 }
	public void parseResponseForNoPages(String siteUrl)
	{
		
		Document doc = null;
		int noPages=0;
		String siteComRes=null;
		String sitePurpose=null;
		String[] spliturls=siteUrl.split(".html?");
		if(spliturls[1].equals("?t/16/v/1"))
		{
			siteComRes ="Residential";
			sitePurpose="Sales";
		}
		else if(spliturls[1].equals("?t/16/v/4"))
		{
			siteComRes ="Residential";
			sitePurpose="Rent";
		}
		else if(spliturls[1].equals("?t/0-16/v/3-1"))
		{
			siteComRes ="commercial";
			sitePurpose="Sales";
		}
		else if(spliturls[1].equals("?t/0-16/v/4-4"))
		{
			siteComRes ="commercial";
			sitePurpose="Rent";
		}
		System.out.println("siteComRes --- >"+siteComRes);
		System.out.println("sitePurpose --- >"+sitePurpose);
		HttpClient client = new DefaultHttpClient();
		  HttpGet request = new HttpGet(siteUrl);
		  try {
			  HttpResponse response = client.execute(request);
			  doc =Jsoup.parse(response.getEntity().getContent(), null, "http://www.propertyfinder.com");
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		  Elements objElementNoPages =doc.getElementsByClass("search-results-number");
			ListIterator<Element> obListNoPages=objElementNoPages.listIterator();
		  while(obListNoPages.hasNext())
		  {
			  Element objElementNoPage= obListNoPages.next();
			  String strSize=objElementNoPage.text();
			  String[] Nopages=strSize.split("of");
			  String str = Nopages[1].replaceAll("\\D+","");
			  noPages =Integer.parseInt(str);
		  }
		  int nop= noPages/15;
		  int noprem= noPages%15;
		  if(noprem > 0)
		  {
			  nop = nop+1;
		  }
		  for(int ind=1; ind <= nop ; ind++)
		  {
			  int in=ind;
			  if(in > 1)
			  {
				  if(in==2)
				  {
					  if(sitePurpose.equalsIgnoreCase("Sales"))
					  {
						  siteUrl = siteUrl.replace("properties-for-sale","properties-for-sale-page"+(in));
					  }
					  else if(sitePurpose.equalsIgnoreCase("Rent"))
					  {
						  siteUrl = siteUrl.replace("properties-for-rent","properties-for-rent-page"+(in));
					  }
				  }
				  else
				  {
					  if(sitePurpose.equalsIgnoreCase("Sales"))
					  {
						  siteUrl = siteUrl.replace("properties-for-sale-page"+(in-1),"properties-for-sale-page"+(in));
					  }
					  else if(sitePurpose.equalsIgnoreCase("Rent"))
					  {
						  siteUrl = siteUrl.replace("properties-for-rent-page"+(in-1),"properties-for-rent-page"+(in));
					  }
				  }
			  }
			  System.out.println("siteUrl --- >"+siteUrl);
			  parseResponse(siteUrl,sitePurpose, siteComRes);
			  if(ind==3)
			  {
				  break;
			  }
		  } 
	}
	public void parseResponse(String siteUrl, String sitePurpose, String siteComRes)
	{
		int index=0;
		
		Document doc = null;
		  List<BayutDetails> colBayutDetails= new ArrayList<BayutDetails>();
		  HttpClient client = new DefaultHttpClient();
		  HttpGet request = new HttpGet(siteUrl);
		  try {
			  HttpResponse response = client.execute(request);
			  doc =Jsoup.parse(response.getEntity().getContent(), null, "http://www.propertyfinder.com");
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// Document doc =Jsoup.parse(response.getEntity().getContent(), null, "http://www.propertyfinder.com");
		  Element objElement =doc.getElementById("content");
		 // System.out.println("objElement--->"+objElement);
		  Elements objElementsListing = objElement.getElementsByClass("general-listing");
		  ListIterator<Element> obListListing=objElementsListing.listIterator();
		  while(obListListing.hasNext())
		  {
			  Element objElement1= obListListing.next();
	// Start Building		  
			  BayutDetails objBayutDetails = new BayutDetails();
			  Elements objElementsBuilding = objElement1.getElementsByClass("category");
			  ListIterator<Element> obListBuilding=objElementsBuilding.listIterator();
			  while(obListBuilding.hasNext())
			  {
				  Element objElement2= obListBuilding.next();
				  String str= objElement2.text();
		//		  System.out.println("Building Area --->"+str);
				  String[] strAreaDetails=str.split(",");
				  if(strAreaDetails.length >=4)
				  {
						  objBayutDetails.setCity(strAreaDetails[0]);
					//	  System.out.println("strAreaDetails[0] --->"+strAreaDetails[0]);
						  objBayutDetails.setArea(strAreaDetails[1]);
					//	  System.out.println("strAreaDetails[0] --->"+strAreaDetails[1]);
						  objBayutDetails.setSubArea(strAreaDetails[2]);
					//	  System.out.println("strAreaDetails[0] --->"+strAreaDetails[2]);
						  String buildName = strAreaDetails[3];
						  objBayutDetails.setBuildingName(buildName);
					//	  System.out.println("strAreaDetails[0] --->"+strAreaDetails[3]);
				  }
				  else if(strAreaDetails.length ==3)
				  {
					  objBayutDetails.setArea(strAreaDetails[0]);
						//	  System.out.println("strAreaDetails[0] --->"+strAreaDetails[1]);
							  objBayutDetails.setSubArea(strAreaDetails[1]);
						//	  System.out.println("strAreaDetails[0] --->"+strAreaDetails[2]);
							  String buildName = strAreaDetails[2];
							  objBayutDetails.setBuildingName(buildName);
				  }
			  }
	// End Building		  

	// Start BedRooms		  
			  Elements objElementsBedrooms = objElement1.getElementsByClass("bedroom");
			  ListIterator<Element> obListBedrooms=objElementsBedrooms.listIterator();
			  while(obListBedrooms.hasNext())
			  {
				  Element objElement3= obListBedrooms.next();
				  Elements objElements3 = objElement3.children();
				  ListIterator<Element> obList3=objElements3.listIterator();
				  while(obList3.hasNext())
				  {
					  Element objElement4= obList3.next();
					  String str= objElement4.text();
				//	  System.out.println("Bedroom Type--->"+str);
					  if(str == null || str.equalsIgnoreCase("null") || str.equalsIgnoreCase("NULL"))
					  {
						  str="0";
					  }
					  objBayutDetails.setBedRoomType(str);
				  }
			  }
	// End BedRooms		 		 
			  
	// Start Building Type and SQFT		  
			  Elements objElementsBuildSQFT = objElement1.getElementsByClass("type");
			  ListIterator<Element> obListBuildSQFT=objElementsBuildSQFT.listIterator();
			  while(obListBuildSQFT.hasNext())
			  {
				  Element objElement5= obListBuildSQFT.next();
				  Elements objElements5 = objElement5.children();
				  ListIterator<Element> obList5=objElements5.listIterator();
				  int Inde=1;
				  while(obList5.hasNext())
				  {
					  Element objElement6= obList5.next();
					  String str= objElement6.text();
					//  System.out.println("Building Type and SQFT--->"+str);
					  if(Inde==1)
					  {
						  str = str.replaceAll("\\D+","");
						  //objBayutDetails.setSQFT(Double.parseDouble(str));
						  objBayutDetails.setSQFT((str));
					  }
					  else if(Inde==2)
					  {
						  objBayutDetails.setBuildingType(str);
					  }
					  Inde = Inde+1;
				  }
			  }
	// End BedRooms		

	// Start AED	  
			  Elements objElementsAED = objElement1.getElementsByClass("amount");
			  ListIterator<Element> obListAED=objElementsAED.listIterator();
			  while(obListAED.hasNext())
			  {
				  Element objElement7= obListAED.next();
				  Elements objElements7 = objElement7.children();
				  ListIterator<Element> obList7=objElements7.listIterator();
				  int Inde=1;
				  while(obList7.hasNext())
				  {
					  Element objElement8= obList7.next();
					  String str= objElement8.text();
					//  System.out.println("AED--->"+str);
					  if(Inde==2)
					  {
						//  System.out.println("AED1234--->"+str);
						  str = str.replaceAll("\\D+","");
						  //objBayutDetails.setAED(Double.parseDouble(str));
						  objBayutDetails.setAED((str));
					  }
					  Inde = Inde+1;
				  }
			  }
	// End AED	
	// Reference Start
			  Elements objElementsRef =objElement1.getElementsByClass("btnMore");
			  ListIterator<Element> obListRef=objElementsRef.listIterator();
			  while(obListRef.hasNext())
			  {
				  Element objElementRef= obListRef.next();
				  org.jsoup.nodes.Attributes objAttrs= objElementRef.attributes();
				  Iterator<org.jsoup.nodes.Attribute> objattrItr=objAttrs.iterator();
				  while(objattrItr.hasNext())
				  {
					  org.jsoup.nodes.Attribute objAttr=objattrItr.next();
					  if(objAttr.getKey().equals("href"))
					  {
				//		  System.out.println("objAttr.getValue--->"+objAttr.getValue());
						//  System.out.println("objAttr.getValue--->"+"http://www.justproperty.com"+objAttr.getValue());
						  objBayutDetails.setReference(objAttr.getValue());
					  }
				  }

			  }
	// Reference End			 
			 // objBayutDetails.setPriPerSqft(objBayutDetails.getAED()/objBayutDetails.getSQFT());
			  colBayutDetails.add(objBayutDetails);
			  
			//  break;
		  }
		  propertyFinderDataStore(colBayutDetails, sitePurpose, siteComRes);
		 
	}
	public void propertyFinderDataStore(List<BayutDetails> colBayutDetails, String sitePurpose, String siteComRes)
	{
		 try
		  {
			 
			 System.out.println("conn123----->"+conn.toString());
			  if(conn == null || conn.isClosed())
			  {
				  conn = UtilityClass.dbConnection();
			  }
			  
			  System.out.println("conn123----->"+conn.toString());
			  //PreparedStatement pstmt = conn.prepareStatement(
              //       "INSERT INTO propertyfinder_data (Sno,domain_name, Bedrooms, " + 
               //      "Price_AED, sqft, Build_Area, Building, Reference, com_res, rent_sales,Price_sqft,data_captured_time_stamp,Sub_Area, Build_Type, City)" +
               //      " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"); 
			  
			  PreparedStatement pstmt = conn.prepareStatement(
	                     "INSERT INTO propertyfinder_data (Sno,domain_name, Bedrooms, " + 
	                     "Price_AED, sqft, Build_Area, Building, Reference, com_res, rent_sales,data_captured_time_stamp,Sub_Area, Build_Type, City)" +
	                     " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)"); 

			  Iterator objiterator=colBayutDetails.iterator();
			  while(objiterator.hasNext())
			  {
				  BayutDetails objBayutDetails= (BayutDetails)objiterator.next();
				  long endTime = System.currentTimeMillis();
				  count = count+1;
				  pstmt.setInt(1,count);
	                pstmt.setString(2, "propertyfinder");
	                pstmt.setString(3, objBayutDetails.getBedRoomType());
	                //pstmt.setInt(4, (int)objBayutDetails.getAED());
	                //pstmt.setInt(5, (int)objBayutDetails.getSQFT());
	                
	                pstmt.setString(4, objBayutDetails.getAED());
	                pstmt.setString(5, objBayutDetails.getSQFT());
	                
	                pstmt.setString(6, objBayutDetails.getArea());
	                pstmt.setString(7, objBayutDetails.getBuildingName());
	                pstmt.setString(8, objBayutDetails.getReference());
	                pstmt.setString(9, siteComRes);
	                pstmt.setString(10, sitePurpose);
	                //pstmt.setInt(11, (int)objBayutDetails.getPriPerSqft());
	                //pstmt.setLong(12, (long)endTime);
	                //pstmt.setString(13, objBayutDetails.getSubArea());
	                //pstmt.setString(14, objBayutDetails.getBuildingType());
	                //pstmt.setString(15, objBayutDetails.getCity());
	                
	                pstmt.setLong(11, (long)endTime);
	                pstmt.setString(12, objBayutDetails.getSubArea());
	                pstmt.setString(13, objBayutDetails.getBuildingType());
	                pstmt.setString(14, objBayutDetails.getCity());
	                // Add row to the batch.
	                pstmt.addBatch();
	          //      index = index + 1;
			//		  System.out.println("End of Property : "+index);
					  System.out.println("End of Property count : "+count);
				 
			  }
			 
	                // Batch is ready, execute it to insert the data
	                pstmt.executeBatch();
	          //      conn.commit();
	                System.out.println("=================================>>");
		  }
		  catch(Exception ex)
		  {
			  System.out.println("Ex----->"+ex);
		  }
	}
	
}
