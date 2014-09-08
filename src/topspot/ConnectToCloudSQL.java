package topspot;

import java.sql.Connection;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.topspot.ConnectionUtil;
import com.topspot.common.Constants;


public class ConnectToCloudSQL {
	String url = null;
		
	ResultSet rs1 = null;
	public static Connection conn =null;
	String ss1=null;
	public ArrayList<String> colBuildin=new ArrayList<String>();
	public ArrayList<String> colArea=new ArrayList<String>();
	public ArrayList<String> colSubArea=new ArrayList<String>();
	public java.util.ArrayList<java.util.ArrayList<Integer>> colrep = new java.util.ArrayList<java.util.ArrayList<Integer>>();
	public java.util.ArrayList<String> colDate = new java.util.ArrayList<String>();
	public ArrayList<String> colBuil=new ArrayList<String>();
	public String build1=null;
	public String build2=null;
	public String build3=null;
	
	public String Fromdate=null;
	public String Todate=null;
	public String buildin1From=null;
	public String buildin2From=null;
	public String buildin3From=null;
	public String buildin1To=null;
	public String buildin2To=null;
	public String buildin3To=null;
	public String Fromdate1=null;
	public String Todate1=null;
	public String DBName="TameerClientDB";
	
	/*public ArrayList<String> getConnection()
	{
		try
		{
			//added by gopal on 31-07-2014
			Constants objConstants = new Constants(); //for reading properties file 
			conn = ConnectionUtil.getConnection(); //for getting google cloud sql connection from util class
			DBName = objConstants.getValue("DBName"); //reading db name from properties file
			
			rs1 = conn.createStatement().executeQuery("SELECT DISTINCT(building) FROM "+DBName+".newton where building != 'null' ORDER BY building");
			while(rs1.next())
			{
				String ss2= rs1.getString(1);
				colBuildin.add(ss2);
			}
			
			rs1 = conn.createStatement().executeQuery("SELECT DISTINCT(Build_Area) FROM "+DBName+".newton ORDER BY Build_Area");
			while(rs1.next())
			{
				String ss2= rs1.getString(1);
				colArea.add(ss2);
			}
			rs1 = conn.createStatement().executeQuery("SELECT DISTINCT(Sub_Area) FROM "+DBName+".newton ORDER BY Sub_Area");
			while(rs1.next())
			{
				String ss2= rs1.getString(1);
				colSubArea.add(ss2);
			}
			
			
		}
		catch(Exception ex)
		{
		}
		return colBuildin;
	}*/
	
	public List<BuildingTrendDetails> getLineChartData(String req_Building1,String req_Building2,String req_Building3,String req_Building4,String req_Building5,String req_datepicker, String req_datepicker1)
	{
		List<BuildingTrendDetails> colBuildingTrendDetails=new ArrayList<BuildingTrendDetails>();
		String Fromdate1=null;
		String Todate1=null;
		String buildingType="";
		String developer="";
		String buildingStatus="";
		String building="";
		String area="";
		String noOfFloors="";
		String completionYear="";
		String usageType="";
		try 
		{
			
			Constants objConstants = new Constants(); //for reading properties file 
			conn = ConnectionUtil.getConnection(); //for getting google cloud sql connection from util class
			DBName = objConstants.getValue("DBName"); //reading db name from properties file
			
		//	req_Building="'23 Marina'";
			if(req_Building1!=null || req_Building2!=null || req_Building3!=null)
			{
				build1 = req_Building1;
				build2 = req_Building2;
				build3 = req_Building3;
				
			
				System.out.println("req_Building1 --->"+req_Building1);
				System.out.println("req_Building2 --->"+req_Building2);
				System.out.println("req_Building3 --->"+req_Building3);
				System.out.println("req_datepicker --->"+req_datepicker);
				System.out.println("req_datepicker1 --->"+req_datepicker1);
				if(req_datepicker != null && !req_datepicker.equalsIgnoreCase("") && !req_datepicker.equalsIgnoreCase("null") && !req_datepicker.equalsIgnoreCase("From date") && req_datepicker.length()==10)
				{
					String[] strdate=req_datepicker.split("/");
					Fromdate=strdate[2]+"-"+strdate[0]+"-"+strdate[1];
					Fromdate1=Fromdate;
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-dd-mm");
					try {
				 		Date dateFrom = formatter.parse(Fromdate1);
				 		String newDateString = formatter.format(dateFrom);
				 		colDate.add(newDateString);
					} catch (Exception e) {
						System.out.println("exception req_datepicker --->"+e);
						//e.printStackTrace();
					}
					
				}
				if(req_datepicker1 != null && !req_datepicker1.equalsIgnoreCase("") && !req_datepicker1.equalsIgnoreCase("null") && !req_datepicker1.equalsIgnoreCase("To date") && req_datepicker1.length()==10)
				{
					String[] strdate=req_datepicker1.split("/");
					Todate=strdate[2]+"-"+strdate[0]+"-"+strdate[1];
					Todate1=Todate;
					SimpleDateFormat formatter = new SimpleDateFormat("yyyy-dd-mm");
					try {
				 		Date dateTo = formatter.parse(Todate1);
				 		String newDateString = formatter.format(dateTo);
				 		colDate.add(newDateString);
					} catch (Exception e) {
						System.out.println("exception req_datepicker1 --->"+e);
					//	e.printStackTrace();
					}
				}
				
				String strquery = queryBuilder(req_Building1,req_Building2,req_Building3,req_Building4,req_Building5,DBName);
				System.out.println("strquery --->"+strquery);
				
				ResultSet rs = ConnectionUtil.executeChartQueries(strquery,conn);
				
				
				
				if(req_Building1!=null)
				{
					build1= "Entered here";
					int recordsize1=0;
					int recordsize2=0;
					BuildingTrendDetails objBuildingTrendDetails1 = new BuildingTrendDetails();
					
					if(Fromdate1!=null && Fromdate1.length()==10)
					{
						if(rs!=null)
						{
							if(rs.next())
							{
								recordsize1 = recordsize1+1;
								
								buildingType=rs.getString(4);
								 developer=rs.getString(5);
								 buildingStatus=rs.getString(6);
								 building=rs.getString(7);
								 area=rs.getString(8);
								 noOfFloors= new Integer(rs.getInt(9)).toString();
								 completionYear= new Integer(rs.getInt(10)).toString();
								 usageType=rs.getString(11);
								 
									
								if(buildingType != null && buildingType != "")
									objBuildingTrendDetails1.setBuilding_Type(buildingType);
								
								if(developer != null && developer != "")
									objBuildingTrendDetails1.setDeveloper(developer);
								
								if(buildingStatus != null && buildingStatus != "")
									objBuildingTrendDetails1.setBuildingStatus(buildingStatus);
								
								if(building != null && building != "")
									objBuildingTrendDetails1.setBuilding(building);
								
								if(area != null && area != "")
									objBuildingTrendDetails1.setArea(area);
								
								if(noOfFloors != null && noOfFloors != "")
									objBuildingTrendDetails1.setFloors(noOfFloors);
								
								if(completionYear != null && completionYear != "")
									objBuildingTrendDetails1.setCompletion(completionYear);
								
								if(usageType != null && usageType != "")
									objBuildingTrendDetails1.setUsage(usageType);
								
								String toBuildingName2=rs.getString(1);
								Date ToDateVal2=rs.getDate(3);
								//String formattedDate = DateUtil.formatDate(ToDateVal2.toString());
    							 
								if(toBuildingName2 != null	&& ToDateVal2 !=null)
								{
									System.out.println("objBuildingTrendDetails1 condition0 entered --->");
								objBuildingTrendDetails1.setBuilding(toBuildingName2);
								objBuildingTrendDetails1.setFromPriPerSqft(rs.getInt(2));
								objBuildingTrendDetails1.setFromTrandate(ToDateVal2);
								}
							}
						}
					}
					
					if(Todate1!=null && Todate1.length()==10)
					{
						if(rs!=null)
						{
								recordsize2 = recordsize2+1;
								Date ToDateVal1=rs.getDate(3);
								String toBuildingName=rs.getString(1);
								System.out.println("objBuildingTrendDetails1 condition1 entered toBuildingName --->"+toBuildingName);
								if(toBuildingName != null && objBuildingTrendDetails1.getBuilding()!=null &&
								objBuildingTrendDetails1.getBuilding().equalsIgnoreCase(toBuildingName) 
								&& ToDateVal1 !=null)
								{
									System.out.println("objBuildingTrendDetails1 condition1 entered --->");
									objBuildingTrendDetails1.setToPriPerSqft(rs.getInt(2));
									objBuildingTrendDetails1.setToTrandate(ToDateVal1);
								}
						}
					}
					System.out.println("objBuildingTrendDetails1 recordsize1 --->"+recordsize1);
					System.out.println("objBuildingTrendDetails1 recordsize2 --->"+recordsize2);
					if(recordsize1> 0 && recordsize2 >0)
					{
						if(objBuildingTrendDetails1.getBuilding() !=null
						&& objBuildingTrendDetails1.getFromTrandate() !=null
						&& objBuildingTrendDetails1.getToTrandate() !=null)
						{
							System.out.println("objBuildingTrendDetails1 condition2 entered --->");
							colBuildingTrendDetails.add(objBuildingTrendDetails1);
						}
					}
					build1="Done 1";
				}
				
				
				if(req_Building2 != null)
				{
					build2="Entered here also";
				//	req_Building2="'29 Burj Boulevard Tower 1'";
					int recordsize1=0;
					int recordsize2=0;
					
					BuildingTrendDetails objBuildingTrendDetails2 = new BuildingTrendDetails();
					
					
					
					
					if(Fromdate1!=null && Fromdate1.length()==10)
					{
						if(rs!=null)
						{
							if(rs.next())
							{
								 recordsize1 = recordsize1+1;
								
								 buildingType=rs.getString(4);
								 developer=rs.getString(5);
								 buildingStatus=rs.getString(6);
								 building=rs.getString(7);
								 area=rs.getString(8);
								 noOfFloors= new Integer(rs.getInt(9)).toString();
								 completionYear= new Integer(rs.getInt(10)).toString();
								 usageType=rs.getString(11);
								
								if(buildingType != null && buildingType != "")
									objBuildingTrendDetails2.setBuilding_Type(buildingType);
								
								if(developer != null && developer != "")
									objBuildingTrendDetails2.setDeveloper(developer);
								
								if(buildingStatus != null && buildingStatus != "")
									objBuildingTrendDetails2.setBuildingStatus(buildingStatus);
								
								if(building != null && building != "")
									objBuildingTrendDetails2.setBuilding(building);
								
								if(area != null && area != "")
									objBuildingTrendDetails2.setArea(area);
								
								if(noOfFloors != null && noOfFloors != "")
									objBuildingTrendDetails2.setFloors(noOfFloors);
								
								if(completionYear != null && completionYear != "")
									objBuildingTrendDetails2.setCompletion(completionYear);
								
								if(usageType != null && usageType != "")
									objBuildingTrendDetails2.setUsage(usageType);
								
								String toBuildingName2=rs.getString(1);
								Date ToDateVal2=rs.getDate(3);
								if(toBuildingName2 != null	&& ToDateVal2 !=null)
								{
									System.out.println("objBuildingTrendDetails2 condition0 entered --->");
									objBuildingTrendDetails2.setBuilding(toBuildingName2);
									objBuildingTrendDetails2.setFromPriPerSqft(rs.getInt(2));
									objBuildingTrendDetails2.setFromTrandate(ToDateVal2);
								}
							}
						}
					}
					if(Todate1!=null && Todate1.length()==10)
					{
						if(rs!=null)
						{
								recordsize2 = recordsize2+1;
								Date ToDateVal1=rs.getDate(3);
								String toBuildingName=rs.getString(1);
								if(toBuildingName != null && objBuildingTrendDetails2.getBuilding()!=null &&
								objBuildingTrendDetails2.getBuilding().equalsIgnoreCase(toBuildingName) 
								&& ToDateVal1 !=null)
								{
									System.out.println("objBuildingTrendDetails2 condition1 entered --->");
									objBuildingTrendDetails2.setToPriPerSqft(rs.getInt(2));
									objBuildingTrendDetails2.setToTrandate(ToDateVal1);
								}
							
						}
					}
					System.out.println("objBuildingTrendDetails2 recordsize1 --->"+recordsize1);
					System.out.println("objBuildingTrendDetails2 recordsize2 --->"+recordsize2);
					if(recordsize1> 0 && recordsize2 >0)
					{
						if(objBuildingTrendDetails2.getBuilding() !=null
						&& objBuildingTrendDetails2.getFromTrandate() !=null
						&& objBuildingTrendDetails2.getToTrandate() !=null)
						{
							System.out.println("objBuildingTrendDetails2 condition2 entered --->");
							colBuildingTrendDetails.add(objBuildingTrendDetails2);
						}
					}
				}
				
				
				if(req_Building3!=null)
				{
					build3="Entered here also once again";
					int recordsize1=0;
					int recordsize2=0;
					BuildingTrendDetails objBuildingTrendDetails3 = new BuildingTrendDetails();
					
					
					if(Fromdate1!=null && Fromdate1.length()==10)
					{
						if(rs!=null)
						{
							if(rs.next())
							{
								
							recordsize1 = recordsize1+1;
							 buildingType=rs.getString(4);
							 developer=rs.getString(5);
							 buildingStatus=rs.getString(6);
							 building=rs.getString(7);
							 area=rs.getString(8);
							 noOfFloors= new Integer(rs.getInt(9)).toString();
							 completionYear= new Integer(rs.getInt(10)).toString();
							 usageType=rs.getString(11);
							
							if(buildingType != null && buildingType != "")
								objBuildingTrendDetails3.setBuilding_Type(buildingType);
							
							if(developer != null && developer != "")
								objBuildingTrendDetails3.setDeveloper(developer);
							
							if(buildingStatus != null && buildingStatus != "")
								objBuildingTrendDetails3.setBuildingStatus(buildingStatus);
							
							if(building != null && building != "")
								objBuildingTrendDetails3.setBuilding(building);
							
							if(area != null && area != "")
								objBuildingTrendDetails3.setArea(area);
							
							if(noOfFloors != null && noOfFloors != "")
								objBuildingTrendDetails3.setFloors(noOfFloors);
							
							if(completionYear != null && completionYear != "")
								objBuildingTrendDetails3.setCompletion(completionYear);
							
							if(usageType != null && usageType != "")
								objBuildingTrendDetails3.setUsage(usageType);
							
							
							String toBuildingName2=rs.getString(1);
							Date ToDateVal2=rs.getDate(3);
								if(toBuildingName2 != null	&& ToDateVal2 !=null)
								{
									System.out.println("objBuildingTrendDetails3 condition0 entered --->");
									objBuildingTrendDetails3.setBuilding(toBuildingName2);
									objBuildingTrendDetails3.setFromPriPerSqft(rs.getInt(2));
									objBuildingTrendDetails3.setFromTrandate(ToDateVal2);
								}
							}
						}
					}
					if(Todate1!=null && Todate1.length()==10)
					{
						if(rs!=null)
						{
								recordsize2 = recordsize2+1;
								Date ToDateVal1=rs.getDate(3);
								String toBuildingName=rs.getString(1);
								if(toBuildingName != null && objBuildingTrendDetails3.getBuilding()!=null &&
								objBuildingTrendDetails3.getBuilding().equalsIgnoreCase(toBuildingName) 
								&& ToDateVal1 !=null)
								{
									System.out.println("objBuildingTrendDetails3 condition1 entered --->");
									objBuildingTrendDetails3.setToPriPerSqft(rs.getInt(2));
									objBuildingTrendDetails3.setToTrandate(ToDateVal1);
								}
							
						}
					}
					System.out.println("objBuildingTrendDetails3 recordsize1 --->"+recordsize1);
					System.out.println("objBuildingTrendDetails3 recordsize2 --->"+recordsize2);
					if(recordsize1> 0 && recordsize2 >0)
					{
						if(objBuildingTrendDetails3 != null && objBuildingTrendDetails3.getBuilding() !=null
						&& objBuildingTrendDetails3.getFromTrandate() !=null
						&& objBuildingTrendDetails3.getToTrandate() !=null)
						{
							System.out.println("objBuildingTrendDetails3 condition2 entered --->");
							colBuildingTrendDetails.add(objBuildingTrendDetails3);
						}
					}
				}
				
				if(req_Building4!=null)
				{
					build3="Entered here also once again";
					int recordsize1=0;
					int recordsize2=0;
					BuildingTrendDetails objBuildingTrendDetails4 = new BuildingTrendDetails();
					
					
					if(Fromdate1!=null && Fromdate1.length()==10)
					{
						if(rs!=null)
						{
							if(rs.next())
							{
								
							recordsize1 = recordsize1+1;
							 buildingType=rs.getString(4);
							 developer=rs.getString(5);
							 buildingStatus=rs.getString(6);
							 building=rs.getString(7);
							 area=rs.getString(8);
							 noOfFloors= new Integer(rs.getInt(9)).toString();
							 completionYear= new Integer(rs.getInt(10)).toString();
							 usageType=rs.getString(11);
							
							if(buildingType != null && buildingType != "")
								objBuildingTrendDetails4.setBuilding_Type(buildingType);
							
							if(developer != null && developer != "")
								objBuildingTrendDetails4.setDeveloper(developer);
							
							if(buildingStatus != null && buildingStatus != "")
								objBuildingTrendDetails4.setBuildingStatus(buildingStatus);
							
							if(building != null && building != "")
								objBuildingTrendDetails4.setBuilding(building);
							
							if(area != null && area != "")
								objBuildingTrendDetails4.setArea(area);
							
							if(noOfFloors != null && noOfFloors != "")
								objBuildingTrendDetails4.setFloors(noOfFloors);
							
							if(completionYear != null && completionYear != "")
								objBuildingTrendDetails4.setCompletion(completionYear);
							
							if(usageType != null && usageType != "")
								objBuildingTrendDetails4.setUsage(usageType);
							
							
							String toBuildingName2=rs.getString(1);
							Date ToDateVal2=rs.getDate(3);
								if(toBuildingName2 != null	&& ToDateVal2 !=null)
								{
									System.out.println("objBuildingTrendDetails4 condition0 entered --->");
									objBuildingTrendDetails4.setBuilding(toBuildingName2);
									objBuildingTrendDetails4.setFromPriPerSqft(rs.getInt(2));
									objBuildingTrendDetails4.setFromTrandate(ToDateVal2);
								}
							}
						}
					}
					if(Todate1!=null && Todate1.length()==10)
					{
						if(rs!=null)
						{
								recordsize2 = recordsize2+1;
								Date ToDateVal1=rs.getDate(3);
								String toBuildingName=rs.getString(1);
								if(toBuildingName != null && objBuildingTrendDetails4.getBuilding()!=null &&
										objBuildingTrendDetails4.getBuilding().equalsIgnoreCase(toBuildingName) 
								&& ToDateVal1 !=null)
								{
									System.out.println("objBuildingTrendDetails4 condition1 entered --->");
									objBuildingTrendDetails4.setToPriPerSqft(rs.getInt(2));
									objBuildingTrendDetails4.setToTrandate(ToDateVal1);
								}
							
						}
					}
					System.out.println("objBuildingTrendDetails4 recordsize1 --->"+recordsize1);
					System.out.println("objBuildingTrendDetails4 recordsize2 --->"+recordsize2);
					if(recordsize1> 0 && recordsize2 >0)
					{
						if(objBuildingTrendDetails4 != null && objBuildingTrendDetails4.getBuilding() !=null
						&& objBuildingTrendDetails4.getFromTrandate() !=null
						&& objBuildingTrendDetails4.getToTrandate() !=null)
						{
							System.out.println("objBuildingTrendDetails4 condition2 entered --->");
							colBuildingTrendDetails.add(objBuildingTrendDetails4);
						}
					}
				}
				if(req_Building5!=null)
				{
					build3="Entered here also once again";
					int recordsize1=0;
					int recordsize2=0;
					BuildingTrendDetails objBuildingTrendDetails5 = new BuildingTrendDetails();
					
					
					if(Fromdate1!=null && Fromdate1.length()==10)
					{
						if(rs!=null)
						{
							if(rs.next())
							{
								
							recordsize1 = recordsize1+1;
							 buildingType=rs.getString(4);
							 developer=rs.getString(5);
							 buildingStatus=rs.getString(6);
							 building=rs.getString(7);
							 area=rs.getString(8);
							 noOfFloors= new Integer(rs.getInt(9)).toString();
							 completionYear= new Integer(rs.getInt(10)).toString();
							 usageType=rs.getString(11);
							
							if(buildingType != null && buildingType != "")
								objBuildingTrendDetails5.setBuilding_Type(buildingType);
							
							if(developer != null && developer != "")
								objBuildingTrendDetails5.setDeveloper(developer);
							
							if(buildingStatus != null && buildingStatus != "")
								objBuildingTrendDetails5.setBuildingStatus(buildingStatus);
							
							if(building != null && building != "")
								objBuildingTrendDetails5.setBuilding(building);
							
							if(area != null && area != "")
								objBuildingTrendDetails5.setArea(area);
							
							if(noOfFloors != null && noOfFloors != "")
								objBuildingTrendDetails5.setFloors(noOfFloors);
							
							if(completionYear != null && completionYear != "")
								objBuildingTrendDetails5.setCompletion(completionYear);
							
							if(usageType != null && usageType != "")
								objBuildingTrendDetails5.setUsage(usageType);
							
							
							String toBuildingName2=rs.getString(1);
							Date ToDateVal2=rs.getDate(3);
								if(toBuildingName2 != null	&& ToDateVal2 !=null)
								{
									System.out.println("objBuildingTrendDetails5 condition0 entered --->");
									objBuildingTrendDetails5.setBuilding(toBuildingName2);
									objBuildingTrendDetails5.setFromPriPerSqft(rs.getInt(2));
									objBuildingTrendDetails5.setFromTrandate(ToDateVal2);
								}
							}
						}
					}
					if(Todate1!=null && Todate1.length()==10)
					{
						if(rs!=null)
						{
								recordsize2 = recordsize2+1;
								Date ToDateVal1=rs.getDate(3);
								String toBuildingName=rs.getString(1);
								if(toBuildingName != null && objBuildingTrendDetails5.getBuilding()!=null &&
										objBuildingTrendDetails5.getBuilding().equalsIgnoreCase(toBuildingName) 
								&& ToDateVal1 !=null)
								{
									System.out.println("objBuildingTrendDetails5 condition1 entered --->");
									objBuildingTrendDetails5.setToPriPerSqft(rs.getInt(2));
									objBuildingTrendDetails5.setToTrandate(ToDateVal1);
								}
							
						}
					}
					System.out.println("objBuildingTrendDetails5 recordsize1 --->"+recordsize1);
					System.out.println("objBuildingTrendDetails5 recordsize2 --->"+recordsize2);
					if(recordsize1> 0 && recordsize2 >0)
					{
						if(objBuildingTrendDetails5 != null && objBuildingTrendDetails5.getBuilding() !=null
						&& objBuildingTrendDetails5.getFromTrandate() !=null
						&& objBuildingTrendDetails5.getToTrandate() !=null)
						{
							System.out.println("objBuildingTrendDetails5 condition2 entered --->");
							colBuildingTrendDetails.add(objBuildingTrendDetails5);
						}
					}
				}
				 buildingType=null;
				 developer=null;
				 buildingStatus=null;
				 building=null;
				 area=null;
				 usageType=null;
				
			}
			else
			{
				/*	String strquery="SELECT newton.Building,AVG(newton.Price_sqft),newton.tran_date,bdf.Building_Type,bdf.Developer,bdf.Building_Status,bdf.Building,bdf.Area,bdf.Floors,bdf.Completion,bdf.UsageType FROM TameerClientDB.newton as newton,TameerClientDB.Building_Database_final as bdf WHERE newton.building = bdf.Building GROUP BY newton.Building ORDER BY newton.tran_date desc LIMIT 5";
					ResultSet rs = conn.createStatement().executeQuery(strquery);
					BuildingTrendDetails objBuildingTrendDetails = new BuildingTrendDetails();
					if(rs!=null)
					{
						while(rs.next())
						{
							
							buildingType=rs.getString(4);
							 developer=rs.getString(5);
							 buildingStatus=rs.getString(6);
							 building=rs.getString(7);
							 area=rs.getString(8);
							 noOfFloors= new Integer(rs.getInt(9)).toString();
							 completionYear= new Integer(rs.getInt(10)).toString();
							 usageType=rs.getString(11);
							 
								System.out.println("buildingType --->"+buildingType);
								System.out.println("developer --->"+developer);
								System.out.println("buildingStatus --->"+buildingStatus);
								System.out.println("building --->"+building);
								System.out.println("area --->"+area);
								System.out.println("noOfFloors --->"+noOfFloors);
								System.out.println("completionYear --->"+completionYear);
								System.out.println("usageType --->"+usageType);
								
							if(buildingType != null && buildingType != "")
								objBuildingTrendDetails.setBuilding_Type(buildingType);
							
							if(developer != null && developer != "")
								objBuildingTrendDetails.setDeveloper(developer);
							
							if(buildingStatus != null && buildingStatus != "")
								objBuildingTrendDetails.setBuildingStatus(buildingStatus);
							
							if(building != null && building != "")
								objBuildingTrendDetails.setBuilding(building);
							
							if(area != null && area != "")
								objBuildingTrendDetails.setArea(area);
							
							if(noOfFloors != null && noOfFloors != "")
								objBuildingTrendDetails.setFloors(noOfFloors);
							
							if(completionYear != null && completionYear != "")
								objBuildingTrendDetails.setCompletion(completionYear);
							
							if(usageType != null && usageType != "")
								objBuildingTrendDetails.setUsage(usageType);
							
							String toBuildingName2=rs.getString(1);
							Date ToDateVal2=rs.getDate(3);
							if(toBuildingName2 != null	&& ToDateVal2 !=null)
							{
								System.out.println("objBuildingTrendDetails1 condition0 entered --->");
								objBuildingTrendDetails.setBuilding(toBuildingName2);
								objBuildingTrendDetails.setFromPriPerSqft(rs.getInt(2));
								objBuildingTrendDetails.setFromTrandate(ToDateVal2);
							}
							colBuildingTrendDetails.add(objBuildingTrendDetails);
						}
					}*/
					
					
			}
			
			
			
		}
		catch(Exception ex)
		{
			System.out.println("objBuildingTrendDetails exception --->"+ex);
			build1= "Entered here with exception"+ex.getMessage();
		}finally {
			ConnectionUtil.closeConnection();
		}

		return colBuildingTrendDetails;
	}
	
	public static String queryBuilder(String req_Building1,String req_Building2,String req_Building3,String req_Building4,String req_Building5,String DBName){
		//String lineChartBuildQuery = "SELECT Building,AVG(Price_sqft),tran_date,City,Bedrooms,Price_sqft,Build_Type,Build_Area,Sub_Area,Building,com_res,rent_sales FROM "+DBName+".newton WHERE building in('";
		String lineChartBuildQuery = "SELECT newton.Building,AVG(newton.Price_sqft),newton.tran_date,bdf.Building_Type,bdf.Developer,bdf.Building_Status,bdf.Building,bdf.Area,bdf.Floors,bdf.Completion,bdf.UsageType FROM TameerClientDB.newton as newton,TameerClientDB.Building_Database_final as bdf WHERE newton.building in(";
		if(req_Building1 != null)
		{
			lineChartBuildQuery = lineChartBuildQuery + "'" + req_Building1 + "','";
		}
		if(req_Building2 != null)
		{
			lineChartBuildQuery = lineChartBuildQuery + req_Building2 + "','";
		}
		
		if(req_Building3 != null)
		{
			lineChartBuildQuery = lineChartBuildQuery + req_Building3 + "','";
		}
		
		if(req_Building4 != null)
		{
			lineChartBuildQuery = lineChartBuildQuery + req_Building4 + "','";
		}
		
		if(req_Building5 != null)
		{
			lineChartBuildQuery = lineChartBuildQuery + req_Building5 + "'";
		}
		
			lineChartBuildQuery = lineChartBuildQuery + ") and newton.building = bdf.Building GROUP BY newton.Building LIMIT 10";
		
		return lineChartBuildQuery;
	}
	
	
}
