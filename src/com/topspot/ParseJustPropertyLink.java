package com.topspot;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
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

public class ParseJustPropertyLink {
	public static Connection conn = null;
	public static int count=0;
	 public static void main(String[] args) throws ClientProtocolException, IOException {
		 ParseJustPropertyLink objParseJustPropertyLink = new ParseJustPropertyLink();
	/*	 conn=UtilityClass.dbConnection();
			count= UtilityClass.recordCount();
		 String siteUrl1="http://www.justproperty.com/dubai/villas-for-sale.html?pagin_flag=1&limit=20&limitstart=0";
		 String siteUrl2="http://www.justproperty.com/dubai/apartments-for-sale.html?pagin_flag=1&limit=20&limitstart=0";
		 String siteUrl3="http://www.justproperty.com/dubai/commercial-for-sale.html?pagin_flag=1&limit=20&limitstart=0";
		 
		 String siteUrlRentals1="http://www.justrentals.com/dubai/apartments-for-rent.html?pagin_flag=1&limit=20&limitstart=0";
		 String siteUrlRentals2="http://www.justrentals.com/dubai/villas-for-rent.html?pagin_flag=1&limit=20&limitstart=0";
		 String siteUrlRentals3="http://www.justrentals.com/dubai/commercial-for-rent.html?pagin_flag=1&limit=20&limitstart=0";
		 

		 objParseJustPropertyLink.parseResponseForNoPages(siteUrl2);
		 System.out.println("one completed--->");
		 objParseJustPropertyLink.parseResponseForNoPages(siteUrl1);
		 System.out.println("Two completed--->");
		 objParseJustPropertyLink.parseResponseForNoPages(siteUrl3);
		 System.out.println("Three completed--->");*/
		 
		 /* objParseJustPropertyLink.parseResponseForNoPages(siteUrlRentals1);
		 System.out.println("siteUrlRentals1 completed--->");
		 objParseJustPropertyLink.parseResponseForNoPages(siteUrlRentals2);
		 System.out.println("siteUrlRentals2 completed--->");
		 objParseJustPropertyLink.parseResponseForNoPages(siteUrlRentals3);
		 System.out.println("siteUrlRentals3 completed--->");*/
	 }
	 
	 public ParseJustPropertyLink()
	 {
	//	 conn=UtilityClass.dbConnection();
		 conn=UtilityClass.conn;
		 UtilityClass.purgeDomains("justproperty_data");
			count= UtilityClass.recordCount("justproperty_data");
		 String siteUrl1="http://www.justproperty.com/dubai/villas-for-sale.html?pagin_flag=1&limit=20&limitstart=0";
		 String siteUrl2="http://www.justproperty.com/dubai/apartments-for-sale.html?pagin_flag=1&limit=20&limitstart=0";
		 String siteUrl3="http://www.justproperty.com/dubai/commercial-for-sale.html?pagin_flag=1&limit=20&limitstart=0";
		 
		 String siteUrlRentals1="http://www.justrentals.com/dubai/apartments-for-rent.html?pagin_flag=1&limit=20&limitstart=0";
		 String siteUrlRentals2="http://www.justrentals.com/dubai/villas-for-rent.html?pagin_flag=1&limit=20&limitstart=0";
		 String siteUrlRentals3="http://www.justrentals.com/dubai/commercial-for-rent.html?pagin_flag=1&limit=20&limitstart=0";
		 

		 parseResponseForNoPages(siteUrl2);
		 System.out.println("one completed--->");
		 parseResponseForNoPages(siteUrl1);
		 System.out.println("Two completed--->");
		 parseResponseForNoPages(siteUrl3);
		 System.out.println("Three completed--->");
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
		
		String[] siteUrls= siteUrl.split(".html?");
		int beginindex=siteUrls[0].lastIndexOf("/");
		String subSiteUrl=siteUrls[0].substring(beginindex+1, siteUrls[0].length());
		
	//	String[] subsiteUrls=subSiteUrl.split(".");
		int FirstIndex=subSiteUrl.indexOf("-");
		int EndIndex=subSiteUrl.lastIndexOf("-");
		String buildingType=subSiteUrl.substring(0,FirstIndex);
		String businessType=subSiteUrl.substring(EndIndex+1,subSiteUrl.length());
	//	System.out.println("subsiteUrls[0]--->"+subSiteUrl);
//		System.out.println("buildingType--->"+buildingType);
//		System.out.println("businessType--->"+businessType);
		siteComRes = buildingType;
		sitePurpose = businessType;
		/*if(subSiteUrl.equalsIgnoreCase("apartments-for-sale"))
		{
			siteComRes="apartments";
			sitePurpose="Sales";
		}
		else if(subSiteUrl.equalsIgnoreCase("villas-for-sale"))
		{
			siteComRes="villas";
			sitePurpose="Sales";
		}
		else if(subSiteUrl.equalsIgnoreCase("commercial-for-sale"))
		{
			siteComRes="commercial";
			sitePurpose="Sales";
		}*/
		System.out.println("siteUrl--->"+siteUrl);
		HttpClient client = new DefaultHttpClient();
		  HttpGet request = new HttpGet(siteUrl);
		  try {
			  HttpResponse response = client.execute(request);
			  doc =Jsoup.parse(response.getEntity().getContent(), null, "http://www.justproperty.com");
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			System.out.println("except--->"+e);
		//	e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			System.out.println("except2--->"+e);
		//	e.printStackTrace();
		}
		  catch (Exception e) {
				// TODO Auto-generated catch block
				System.out.println("except3--->"+e);
			//	e.printStackTrace();
			}
	//	  System.out.println("siteUrlabcd--->");
		  if(doc != null)
		  {
	//		  System.out.println("siteUrlabcd123--->");
		  Elements objElementNoPages =doc.getElementsByClass("pagination_result_of");		  
		  ListIterator<Element> obListNoPages=objElementNoPages.listIterator();
	//	  System.out.println("siteUrlXYZ--->");
		  while(obListNoPages.hasNext())
		  {
	//		  System.out.println("Doc123--->");
			  Element objElementNoPage= obListNoPages.next();
			  String strSize=objElementNoPage.text();
	//		  System.out.println("strSizeDocABC--->"+strSize);
			  String[] Nopages=strSize.split("of");
			//  System.out.println("Nopages[1] --- >"+Nopages[1]);
			  String str = Nopages[1].replaceAll("\\D+","");
			  System.out.println("number of pages --- >"+str);
			  noPages =Integer.parseInt(str);
		  }
		  for(int ind=0; ind < noPages ; ind++)
		  {
			  int in=ind;
			  if(in > 0)
			  {
				  siteUrl = siteUrl.replace("&limitstart="+((in-1)*20),"&limitstart="+(in*20));
			  }
			  System.out.println("siteUrl : "+ind+" --- >"+siteUrl);
			  parseResponse(siteUrl,sitePurpose, siteComRes);
			  if(in==3)
			  {
				  break;
			  }
		  }
	}
	  else
	  {
		  System.out.println("doc is null--->");
	  }
	}
	public void parseResponse(String siteUrl, String sitePurpose, String siteComRes)
	{
		Document doc = null;
		int noPages=0;
		List<BayutDetails> colBayutDetails= new ArrayList<BayutDetails>();
		HttpClient client = new DefaultHttpClient();
		  HttpGet request = new HttpGet(siteUrl);
		  try {
			  HttpResponse response = client.execute(request);
			  doc =Jsoup.parse(response.getEntity().getContent(), null, "http://www.justproperty.com");
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		  Elements objElements =doc.getElementsByClass("search_listings_box");
		  ListIterator<Element> obList=objElements.listIterator();
		  while(obList.hasNext())
		  {
			  Element objElement= obList.next();
	//		  System.out.println("objElement--->"+objElement);
	// Start Building Name	  
			  BayutDetails objBayutDetails = new BayutDetails();
			  Elements objElementsBuilding =objElement.getElementsByClass("h4_service");
			  ListIterator<Element> obListBuilding=objElementsBuilding.listIterator();
			  while(obListBuilding.hasNext())
			  {
				  Element objElement1= obListBuilding.next();
				  String str= objElement1.text();
			//	  System.out.println("Building Address --->"+str);
				  String[] address=str.split("\\|");
			//	  System.out.println("Address Size --->"+address.length);
				  if(siteComRes !=null && siteComRes.equalsIgnoreCase("Commercial"))
				  {
					  if(address.length == 3)
					  {
						  String Area=address[2];
						  String SubArea=address[1];
						  String buildingName=address[1];
						  objBayutDetails.setArea(Area);
						  objBayutDetails.setSubArea(SubArea);
						  objBayutDetails.setBuildingName(buildingName);
				//		  System.out.println("Area3 --->"+Area);
				//		  System.out.println("SubArea3 --->"+SubArea);
					//	  System.out.println("buildingName3 --->"+buildingName);
					  }
					  else if(address.length == 2)
					  {
						  String Area=address[1];
						  String SubArea=address[1];
						  String buildingName=address[1];
						  objBayutDetails.setArea(Area);
						  objBayutDetails.setSubArea(SubArea);
						  objBayutDetails.setBuildingName(buildingName);
				//		  System.out.println("Area3 --->"+Area);
				//		  System.out.println("SubArea3 --->"+SubArea);
					//	  System.out.println("buildingName3 --->"+buildingName);
					  }
				  }
				  else if(siteComRes !=null && !siteComRes.equalsIgnoreCase("Commercial"))
				  {
					  if(address.length >= 4)
					  {
						  String Area=address[3];
						  String SubArea=address[2];
						  String buildingName=address[2];
						  objBayutDetails.setArea(Area);
						  objBayutDetails.setSubArea(SubArea);
						  objBayutDetails.setBuildingName(buildingName);
					//	  System.out.println("Area1 --->"+Area);
					//	  System.out.println("SubArea1 --->"+SubArea);
					//	  System.out.println("buildingName1 --->"+buildingName);
					  }
					  else if(address.length == 3)
					  {
						  String Area=address[2];
						  String SubArea=address[2];
						  String buildingName=address[2];
						  objBayutDetails.setArea(Area);
						  objBayutDetails.setSubArea(SubArea);
						  objBayutDetails.setBuildingName(buildingName);
					//	  System.out.println("Area2 --->"+Area);
					//	  System.out.println("SubArea2 --->"+SubArea);
					//	  System.out.println("buildingName2 --->"+buildingName);
					  }
				 }
			  }
	// End Building Name
			  
	// Start Bedroom Type and SQFT	  
			  Elements objElementsBedrooms =objElement.getElementsByClass("listing_info");
			  ListIterator<Element> obListBedrooms=objElementsBedrooms.listIterator();
			  while(obListBedrooms.hasNext())
			  {
				  Element objElement1= obListBedrooms.next();
				  Elements objElements2 = objElement1.children();
				  ListIterator<Element> obList2=objElements2.listIterator();
				  int index=0;
				  while(obList2.hasNext())
				  {
					  Element objElement3= obList2.next();
					  if(siteComRes !=null && siteComRes.equalsIgnoreCase("Commercial"))
					  {
						  if(index > 1)
						  {
							  String str= objElement3.text();
							  if(index==2)
							  {
								  String strSQFT =str.replaceAll("\\D+","");
								  //objBayutDetails.setSQFT(Double.parseDouble(strSQFT));
								  objBayutDetails.setSQFT((strSQFT));
						//		  System.out.println("SQFT2--->"+strSQFT);
							  }
						  }
						 
					  }
					  else if(siteComRes !=null && !siteComRes.equalsIgnoreCase("Commercial"))
					  {
						  if(index>= 0)
						  {
							  String str= objElement3.text();
							  if(index==1)
							  {
								  String strBedrroms =str.replaceAll("\\D+","");
								  objBayutDetails.setBedRoomType(strBedrroms);
						//		  System.out.println("Bedroom Type--->"+strBedrroms);
							  }
							  if(index==2)
							  {
								  String strSQFT =str.replaceAll("\\D+","");
								  //objBayutDetails.setSQFT(Double.parseDouble(strSQFT));
								  objBayutDetails.setSQFT((strSQFT));
						//		  System.out.println("SQFT--->"+strSQFT);
							  }
						  }
					  }
					  index=index+1;
				  }
			  }
	// End Bedroom Type and SQFT	

	// Start AED	  
			  Elements objElementsAED =objElement.getElementsByClass("price_column");
			  ListIterator<Element> obListAED=objElementsAED.listIterator();
			  while(obListAED.hasNext())
			  {
				  Element objElement1= obListAED.next();
				  String str= objElement1.text();
				  String strAED =str.replaceAll("\\D+","");
				  //objBayutDetails.setAED(Double.parseDouble(strAED));
				  objBayutDetails.setAED((strAED));
				//  System.out.println("AED --->"+strAED);
			  }
	// End BedRoom types		
	// Reference Start
			  Elements objElementsRef =objElement.getElementsByClass("photo");
			  ListIterator<Element> obListRef=objElementsRef.listIterator();
			  while(obListRef.hasNext())
			  {
				  Element objElement1= obListRef.next();
				  org.jsoup.nodes.Attributes objAttrs= objElement1.attributes();
				  Iterator<org.jsoup.nodes.Attribute> objattrItr=objAttrs.iterator();
				  while(objattrItr.hasNext())
				  {
					  org.jsoup.nodes.Attribute objAttr=objattrItr.next();
					  if(objAttr.getKey().equals("href"))
					  {
						  objBayutDetails.setReference("http://www.justproperty.com"+objAttr.getValue());
						//  System.out.println("objAttr.getValue--->"+"http://www.justproperty.com"+objAttr.getValue());
						  
					  }
				  }

			  }
	// Reference End		
			  //objBayutDetails.setPriPerSqft(objBayutDetails.getAED()/objBayutDetails.getSQFT());
			  objBayutDetails.setBuildingType(siteComRes);
			  colBayutDetails.add(objBayutDetails);
			//  break;
		  }
		 justPropertyDataStore(colBayutDetails, sitePurpose, siteComRes);
	}
	public void justPropertyDataStore(List<BayutDetails> colBayutDetails, String sitePurpose, String siteComRes)
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
              //       "INSERT INTO justproperty_data (Sno,domain_name, Bedrooms, " + 
              //       "Price_AED, sqft, Build_Area, Building, Reference, com_res, rent_sales,Price_sqft,data_captured_time_stamp,Sub_Area, Build_Type, City)" +
              //      " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"); 
			  
			  PreparedStatement pstmt = conn.prepareStatement(
	                     "INSERT INTO justproperty_data (Sno,domain_name, Bedrooms, " + 
	                     "Price_AED, sqft, Build_Area, Building, Reference, com_res, rent_sales,data_captured_time_stamp,Sub_Area, Build_Type, City)" +
	                     " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?)"); 

			  Iterator objiterator=colBayutDetails.iterator();
			  while(objiterator.hasNext())
			  {
				  BayutDetails objBayutDetails= (BayutDetails)objiterator.next();
				  long endTime = System.currentTimeMillis();
				  count = count+1;
				  pstmt.setInt(1,count);
	                pstmt.setString(2, "justproperty");
	                pstmt.setString(3, objBayutDetails.getBedRoomType());
	                //pstmt.setInt(4, (int)objBayutDetails.getAED());
	                //pstmt.setInt(5, (int)objBayutDetails.getSQFT());
	                
	                pstmt.setString(4, objBayutDetails.getAED());
	                pstmt.setString(5, objBayutDetails.getSQFT());
	                
	                pstmt.setString(6, objBayutDetails.getArea());
	                pstmt.setString(7, objBayutDetails.getBuildingName());
	                pstmt.setString(8, objBayutDetails.getReference());
	                if(siteComRes != null && siteComRes.equalsIgnoreCase("Commercial"))
	                {
	                pstmt.setString(9, siteComRes);
	                }
	                else
	                {
	                	pstmt.setString(9, "Residential");
	                }
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
