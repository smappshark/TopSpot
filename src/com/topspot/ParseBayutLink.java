package com.topspot;

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

import java.sql.*;
public class ParseBayutLink 
{
	public static Connection conn = null;
	public static int count=0;
	public static void main(String[] args) throws ClientProtocolException, IOException 
	{
		 new ParseBayutLink();
	/*	 UtilityClass objUtilityClass = new UtilityClass();
		 String siteUrl1="http://www.bayut.com/search/results.html?rd_purpose=1&page_view=1&page=1&cat_id=5002,&property_type=3,16,4,12,14,17,#rd_purpose=1&page_view=1&page=1&cat_id=5002,&property_type=3,16,4,12,14,17,";
		 String siteUrl2="http://www.bayut.com/search/results.html?rd_purpose=2&page_view=1&page=1&cat_id=5002,&property_type=3,16,4,12,14,17,#rd_purpose=2&page_view=1&page=1&cat_id=5002,&property_type=3,16,4,12,14,17,";
		 String siteUrl3="http://www.bayut.com/search/results.html?rd_purpose=1&page_view=1&page=1&cat_id=5002,&property_type=5,6,7,8,13,15,9,10,11,#rd_purpose=1&page_view=1&page=1&cat_id=5002,&property_type=5,6,7,8,13,15,9,10,11,";
		 String siteUrl4="http://www.bayut.com/search/results.html?rd_purpose=2&page_view=1&page=1&cat_id=5002,&property_type=5,6,7,8,13,15,9,10,11,#rd_purpose=2&page_view=1&page=1&cat_id=5002,&property_type=5,6,7,8,13,15,9,10,11,";
		conn=UtilityClass.dbConnection();
		count= UtilityClass.recordCount();
		 System.out.println("siteUrl1 before count --- >"+objParseBayutLink.count);
		 objParseBayutLink.parseResponseForNoPages(siteUrl1);
		 System.out.println("siteUrl1 completed --- >");
		 objParseBayutLink.parseResponseForNoPages(siteUrl2);
		 System.out.println("siteUrl2 completed --- >");
		 objParseBayutLink.parseResponseForNoPages(siteUrl3);
		 System.out.println("siteUrl3 completed --- >");
		 objParseBayutLink.parseResponseForNoPages(siteUrl4);
		 System.out.println("siteUrl4 completed --- >");*/
	 }
	 
	 public ParseBayutLink()
	 {
		 
		/* String siteUrl1="http://www.bayut.com/search/results.html?rd_purpose=1&page_view=1&page=1&cat_id=5002,&property_type=3,16,4,12,14,17,#rd_purpose=1&page_view=1&page=1&cat_id=5002,&property_type=3,16,4,12,14,17,";
		 String siteUrl2="http://www.bayut.com/search/results.html?rd_purpose=2&page_view=1&page=1&cat_id=5002,&property_type=3,16,4,12,14,17,#rd_purpose=2&page_view=1&page=1&cat_id=5002,&property_type=3,16,4,12,14,17,";
		 String siteUrl3="http://www.bayut.com/search/results.html?rd_purpose=1&page_view=1&page=1&cat_id=5002,&property_type=5,6,7,8,13,15,9,10,11,#rd_purpose=1&page_view=1&page=1&cat_id=5002,&property_type=5,6,7,8,13,15,9,10,11,";
		 String siteUrl4="http://www.bayut.com/search/results.html?rd_purpose=2&page_view=1&page=1&cat_id=5002,&property_type=5,6,7,8,13,15,9,10,11,#rd_purpose=2&page_view=1&page=1&cat_id=5002,&property_type=5,6,7,8,13,15,9,10,11,";*/
		 List<String> urls = getSiteUrls();		 
		/*conn=UtilityClass.dbConnection();
		UtilityClass.purgeDomains("bayut_data");
		count= UtilityClass.recordCount("bayut_data");
		 System.out.println("siteUrl1 before count --- >"+count);
		 parseResponseForNoPages(siteUrl1);
		 System.out.println("siteUrl1 completed --- >");
		 parseResponseForNoPages(siteUrl2);
		 System.out.println("siteUrl2 completed --- >");
		parseResponseForNoPages(siteUrl3);
		 System.out.println("siteUrl3 completed --- >");
		 parseResponseForNoPages(siteUrl4);
		 System.out.println("siteUrl4 completed --- >");*/
		 conn=UtilityClass.dbConnection();
		 UtilityClass.purgeDomains("bayut_data");
		 for(String url:urls)
		 {
			 parseResponseForNoPages(url);
			 System.out.println(url+"---------->Completed");
		 }
	 }
	 
	 
	public void parseResponseForNoPages(String siteUrl)
	{
		Document doc = null;
		int noPages=0; 
		//siteUrl="http://www.bayut.com/search/results.html?rd_purpose=1&page_view=1&page=1&cat_id=5002,&property_type=3,16,4,12,14,17,#rd_purpose=1&page_view=1&page=1&cat_id=5002,&property_type=3,16,4,12,14,17,";
		String siteComRes=null;
		String sitePurpose=null;
		
		HttpClient client = new DefaultHttpClient();
		  HttpGet request = new HttpGet(siteUrl);
		  try {
			  HttpResponse response = client.execute(request);
			  doc =Jsoup.parse(response.getEntity().getContent(), null, "http://www.bayut.com");
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		  Elements objElementNoPages =doc.getElementsByClass("pg_page_of_pages_txt");
			ListIterator<Element> obListNoPages=objElementNoPages.listIterator();
		  while(obListNoPages.hasNext())
		  {
			  Element objElementNoPage= obListNoPages.next();
			  Elements objElements2 = objElementNoPage.children();
			  ListIterator<Element> obList2=objElements2.listIterator();
			  while(obList2.hasNext())
			  {
				  Element objElement3= obList2.next();
				  org.jsoup.nodes.Attributes objAttrs= objElement3.attributes();
				  Iterator<org.jsoup.nodes.Attribute> objattrItr=objAttrs.iterator();
				  while(objattrItr.hasNext())
				  {
					  org.jsoup.nodes.Attribute objAttr=objattrItr.next();
					  if(objAttr.getKey().equals("value"))
					  {
						  System.out.println("objAttr.getValue --- >"+objAttr.getValue());
						  noPages =Integer.parseInt(objAttr.getValue());
					  }
				  }
			  }
		  }
		  String sitePurposeUrl=siteUrl.substring("http://www.bayut.com/search/results.html?#rd_purpose".length(), "http://www.bayut.com/search/results.html?#rd_purpose".length()+1);
		//  System.out.println("sitePurposeUrl--->"+sitePurposeUrl);
		  if(sitePurposeUrl.equals("1"))
		  {
			  sitePurpose="Sales";
		  }
		  else if(sitePurposeUrl.equals("2"))
		  {
			  sitePurpose="Rent";
		  }
		//  System.out.println("siteUrlabc--->"+siteUrl);
		  siteUrl.lastIndexOf("&property_type=");
		  String splitVal =siteUrl.substring(siteUrl.lastIndexOf("&property_type=")+("&property_type=").length(), siteUrl.length());
		//  System.out.println("splitVal--->"+splitVal);
		//  String[] splitVal=siteUrl.split("&property_type=");
		  
		  if(splitVal != null && splitVal.equals("3,16,4,12,14,17,"))
		  {
			  siteComRes="Residential";
		  }
		  else if(splitVal != null && splitVal.equals("5,6,7,8,13,15,9,10,11,"))
		  {
			  siteComRes="Commercial";
		  }
		//  System.out.println("siteComRes--->"+siteComRes);
		//  System.out.println("sitePurpose--->"+sitePurpose);
		  parseResponse(siteUrl,"Sales","Residential");
		  for(int ind=1; ind <= noPages ; ind++)
		  {
			  int in=ind;			  
			  if(in > 1)
			  {				 
				  String patternPage = "[^\\w](page)[^\\w](\\d)+";
				  siteUrl = siteUrl.replaceAll(patternPage,"&page="+(in));
				  String patternPageView = "[^\\w](page_view)[^\\w](\\d)+";
				  siteUrl = siteUrl.replaceAll(patternPageView,"&page_view="+(in));
				  // System.out.println("Bayut siteUrl123--->"+siteUrl);
			  }
			  System.out.println("in--->"+in);
			  //  System.out.println("siteComRes--->"+siteComRes);
			  // System.out.println("sitePurpose--->"+sitePurpose);
			  //System.out.println("Bayut siteUrl--->"+siteUrl);
			  parseResponse(siteUrl,sitePurpose,siteComRes);
			  if(ind==3)
				  break;
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
			  doc =Jsoup.parse(response.getEntity().getContent(), null, "http://www.bayut.com");
		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		  if(doc!= null)
		  {
		  Elements objElements =doc.getElementsByClass("listing");
		  ListIterator<Element> obList=objElements.listIterator();
		  while(obList.hasNext())
		  {
			  BayutDetails objBayutDetails = new BayutDetails();
			  Element objElement= obList.next();
		// Start Area and Building name
			  Elements objElements1 =objElement.getElementsByClass("_left");
			  ListIterator<Element> obList1=objElements1.listIterator();
			  while(obList1.hasNext())
			  {
				  Element objElement1= obList1.next();
				  Elements objElements2 = objElement1.children();
				  ListIterator<Element> obList2=objElements2.listIterator();
				  while(obList2.hasNext())
				  {
					  Element objElement3= obList2.next();
					  org.jsoup.nodes.Attributes objAttrs= objElement3.attributes();
					  Iterator<org.jsoup.nodes.Attribute> objattrItr=objAttrs.iterator();
					  while(objattrItr.hasNext())
					  {
						  org.jsoup.nodes.Attribute objAttr=objattrItr.next();
						  if(objAttr.getKey().equals("href"))
						  {
							  objBayutDetails.setReference(objAttr.getValue());
						  }
					  }
					  
					  String str= objElement3.text();
					  String[] strs=str.split("-");
					  if(strs.length >=2)
					  {
						  objBayutDetails.setArea(strs[0]);
						  objBayutDetails.setBuildingName(strs[1]);
					  }
					  else
					  {
						  objBayutDetails.setBuildingName(str);
					  }
				  }
			  }
		// End Area and Building name	 
		
		// Start BedRoom types	  
			  Elements objElementsBeds =objElement.getElementsByClass("beds");
			  ListIterator<Element> obListBeds=objElementsBeds.listIterator();
			  while(obListBeds.hasNext())
			  {
				  Element objElement1= obListBeds.next();
				  String str= objElement1.text();
				  objBayutDetails.setBedRoomType(str);
			  }
		// End BedRoom types	  
			  
		// Start SQFT	  
			  Elements objElementsArea =objElement.getElementsByClass("area");
			  ListIterator<Element> obListArea=objElementsArea.listIterator();
			  while(obListArea.hasNext())
			  {
				  Element objElement1= obListArea.next();
				  Elements objElements2 = objElement1.children();
				  ListIterator<Element> obList2=objElements2.listIterator();
				  while(obList2.hasNext())
				  {
					  Element objElement3= obList2.next();
					  String str= objElement3.text();
					  str = str.replaceAll("\\D+","");
					  //objBayutDetails.setSQFT(Double.parseDouble(str));
					  objBayutDetails.setSQFT(str);
				  }
			  }
		// End SQFT	  
		
		// Start AED	  
			  Elements objElementsAED =objElement.getElementsByClass("_right");
			  ListIterator<Element> obListAED=objElementsAED.listIterator();
			  while(obListAED.hasNext())
			  {
				  Element objElement1= obListAED.next();
				  Elements objElements2 = objElement1.children();
				  ListIterator<Element> obList2=objElements2.listIterator();
				  while(obList2.hasNext())
				  {
					  Element objElement3= obList2.next();
					  String str= objElement3.text();
					  str = str.replaceAll("\\D+","");
					  //objBayutDetails.setAED(Double.parseDouble(str));
					  objBayutDetails.setAED(str);
				  }
				  
			  }
		// End AED	  
			  
			  //objBayutDetails.setPriPerSqft(objBayutDetails.getAED()/objBayutDetails.getSQFT());
			  
			  
			//  index = index + 1;
			  colBayutDetails.add(objBayutDetails);
		/*	  if(index >= 2)
			  {
			  break;
			  } */
		  }
	}
		  PreparedStatement pstmt=null;
		  try
		  {
			  
			  System.out.println("conn123----->"+conn.toString());
			  if(conn == null || conn.isClosed())
			  {
				  conn = UtilityClass.dbConnection();
			  }
			  
			  
			  // pstmt = conn.prepareStatement(
              //        "INSERT INTO bayut_data (Sno,domain_name, Bedrooms, " + 
              //        "Price_AED, sqft, Build_Area, Building, Reference, com_res, rent_sales,Price_sqft,data_captured_time_stamp,Sub_Area)" +
              //        " VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			  
			  pstmt = conn.prepareStatement(
                      "INSERT INTO bayut_data (Sno,domain_name, Bedrooms, " + 
                      "Price_AED, sqft, Build_Area, Building, Reference, com_res, rent_sales,data_captured_time_stamp,Sub_Area)" +
                      " VALUES(?,?,?,?,?,?,?,?,?,?,?,?)"); 

			  Iterator objiterator=colBayutDetails.iterator();
			  while(objiterator.hasNext())
			  {
				  BayutDetails objBayutDetails= (BayutDetails)objiterator.next();
				 /* System.out.println("objBayutDetails.getArea()--->"+objBayutDetails.getArea());
				  System.out.println("objBayutDetails.getBuildingName()--->"+objBayutDetails.getBuildingName());
				  System.out.println("objBayutDetails.getBedRoomType()--->"+objBayutDetails.getBedRoomType());
				  System.out.println("objBayutDetails.getSQFT()--->"+objBayutDetails.getSQFT());
				  System.out.println("objBayutDetails.getAED()--->"+objBayutDetails.getAED());
				  System.out.println("objBayutDetails.getPriPerSqft()--->"+objBayutDetails.getPriPerSqft());
				  System.out.println("objBayutDetails.getReference()--->"+objBayutDetails.getReference());*/
				  
				  long endTime = System.currentTimeMillis();
				  
				  
				  count = count+1;
				  pstmt.setInt(1,count);
	                pstmt.setString(2, "Bayut");
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
	                //pstmt.setString(13, objBayutDetails.getArea());
	                pstmt.setLong(11, (long)endTime);
	                pstmt.setString(12, objBayutDetails.getArea());
	                // Add row to the batch.
	                pstmt.addBatch();
	                index = index + 1;
			//		  System.out.println("End of Property : "+index);
					  System.out.println("End of Property count : "+count);
				 
			  }
			 
	                // Batch is ready, execute it to insert the data
	                pstmt.executeBatch();
	           //     conn.commit();
	                System.out.println("=================================>>");
		  }
		  catch(Exception ex)
		  {
			  System.out.println("Ex----->"+ex);
		  }finally {
		        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
		        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
		    }
	}
	
	public List<String> getSiteUrls(){
		List<String> urls = new ArrayList<String>();
		try(Connection connection=UtilityClass.dbConnection();Statement stmt=connection.createStatement();){
			String query ="SELECT link FROM domain_links WHERE Domain='Bayut.com' LIMIT 1000";
			 ResultSet rs = stmt.executeQuery(query);
			 while(rs.next()){
				 String url = rs.getString("link");
				 urls.add(url);
			 }
			 
		}catch(Exception e){
			e.printStackTrace();
		}
		return urls;
	}

}
