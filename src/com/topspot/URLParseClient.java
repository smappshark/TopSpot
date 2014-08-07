package com.topspot;


import java.io.IOException;

import org.apache.http.HttpResponse;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.DefaultHttpClient;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import java.util.Set;

public class URLParseClient {
 public static void main(String[] args) throws ClientProtocolException, IOException {
	 int in=1;
	 Map<String,ArrayList<String>> siteUrlMap= new HashMap<String,ArrayList<String>>();
  HttpClient client = new DefaultHttpClient();
  String siteUrl="http://www.propertyfinder.ae/en/buy/dubai/properties-for-sale.html?t/16/v/1";
  //String siteUrl="http://www.bayut.com/search/results.html?rd_purpose=1&page_view=1&page=1&cat_id=5002,&property_type=3,16,4,12,14,17,#rd_purpose=1&page_view=1&page=1&cat_id=5002,&property_type=3,16,4,12,14,17,";
 // String siteUrl="http://www.bayut.com/search/results.html?rd_purpose=1&page_view=1&page=1&cat_id=5002,&property_type=3,16,4,12,14,17,";
 // String siteUrl="http://www.justproperty.com/dubai/apartments-for-sale.html?pagin_flag=1&limit=20&limitstart=0";
  String strUrlName="http://www.propertyfinder.com";
 // String strUrlName="http://www.bayut.com1";
 // String strUrlName="http://www.justproperty.com";
  HttpGet request = new HttpGet(siteUrl);
  HttpResponse response = client.execute(request);
  
  if(siteUrlMap != null)
  {
	  Set SiteNames=siteUrlMap.keySet();
	  for(int ind=0; ind <SiteNames.size(); ind++)
	  {
		  List<String> colSitUrls=siteUrlMap.get(SiteNames);
		  if(SiteNames.equals("http://www.bayut.com"))
		  {
			  ParseBayutLink objParseBayutLink = new ParseBayutLink();
			  for(String str : colSitUrls)
			  {
				  objParseBayutLink.parseResponseForNoPages(str);
			  }
		  }
		  else if(SiteNames.equals("http://www.propertyfinder.com"))
		  {
			  ParsePropertyFinderLink objParsePropertyFinderLink = new ParsePropertyFinderLink();
			  for(String str : colSitUrls)
			  {
				  objParsePropertyFinderLink.parseResponseForNoPages(str);
			  }
		  }
	  }
  }
  
   if(strUrlName=="http://www.justproperty.com")
  { 
	  Document doc =Jsoup.parse(response.getEntity().getContent(), null, "http://www.justproperty.com");
	  Elements objElements =doc.getElementsByClass("search_listings_box");
	  ListIterator<Element> obList=objElements.listIterator();
	  while(obList.hasNext())
	  {
		  Element objElement= obList.next();
		  System.out.println("objElement--->"+objElement);
// Start Building Name	  
		  Elements objElementsBuilding =objElement.getElementsByClass("h4_service");
		  ListIterator<Element> obListBuilding=objElementsBuilding.listIterator();
		  while(obListBuilding.hasNext())
		  {
			  Element objElement1= obListBuilding.next();
			  String str= objElement1.text();
			  System.out.println("Building Name --->"+str);
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
				  if(index>= 0)
				  {
				  String str= objElement3.text();
				  System.out.println("Bedroom Type and SQFT--->"+str);
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
			  System.out.println("AED --->"+str);
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
					  System.out.println("objAttr.getValue--->"+"http://www.justproperty.com"+objAttr.getValue());
				  }
			  }

		  }
// Reference End		  
		  break;
	  }
  }
  else if(strUrlName=="http://www.propertyfinder.com")
  { 
	  Document doc =Jsoup.parse(response.getEntity().getContent(), null, "http://www.propertyfinder.com");
	  Element objElement =doc.getElementById("content");
	 // System.out.println("objElement--->"+objElement);
	  Elements objElementsListing = objElement.getElementsByClass("general-listing");
	  System.out.println("objElementsListing.size()==>"+objElementsListing.size());
	  ListIterator<Element> obListListing=objElementsListing.listIterator();
	  while(obListListing.hasNext())
	  {
		  Element objElement1= obListListing.next();
// Start Building		  
		  Elements objElementsBuilding = objElement1.getElementsByClass("category");
		  ListIterator<Element> obListBuilding=objElementsBuilding.listIterator();
		  while(obListBuilding.hasNext())
		  {
			  Element objElement2= obListBuilding.next();
			  String str= objElement2.text();
			  System.out.println("Building Area --->"+str);
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
				  System.out.println("Bedroom Type--->"+str);
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
			  while(obList5.hasNext())
			  {
				  Element objElement6= obList5.next();
				  String str= objElement6.text();
				  System.out.println("Building Type and SQFT--->"+str);
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
			  while(obList7.hasNext())
			  {
				  Element objElement8= obList7.next();
				  String str= objElement8.text();
				  System.out.println("AED--->"+str);
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
					  System.out.println("objAttr.getValue--->"+"http://www.justproperty.com"+objAttr.getValue());
				  }
			  }

		  }
// Reference End			  
		  System.out.println("End of Property--->");
		  System.out.println("====================================================");
		  break;
	  }
  }	  
 }
}