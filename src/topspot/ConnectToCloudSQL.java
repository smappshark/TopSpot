package topspot;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.topspot.ConnectionUtil;
import com.topspot.common.Constants;


public class ConnectToCloudSQL {
	String url = null;
	//String req_Building =null;
	
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
	
	public ArrayList<String> getConnection()
	{
		try
		{
		/*	if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Production) 
			{
			  // Load the class that provides the new "jdbc:google:mysql://" prefix.
			  Class.forName("com.mysql.jdbc.GoogleDriver");
			  url = "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root";
			} 
			else 
			{*/
			  // Local MySQL instance to use during development.
			//Class.forName("com.mysql.jdbc.Driver");
			//url = "jdbc:mysql://192.168.10.192:3306/topspot?user=root";
			//commenetd by gopal on 31-07-2014
			/*Class.forName("com.mysql.jdbc.GoogleDriver");
	        url = "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root";
			DBName = "TameerClientDB";*/ 
			//commenetd by gopal on 31-07-2014
	//		}
			//commenetd by gopal on 31-07-2014
			//conn = DriverManager.getConnection(url);
			//commenetd by gopal on 31-07-2014
			
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
	}
	
	public List<BuildingTrendDetails> getLineChartData(String req_Building1,String req_Building2,String req_Building3,String req_datepicker, String req_datepicker1)
	{
		List<BuildingTrendDetails> colBuildingTrendDetails=new ArrayList<BuildingTrendDetails>();
		try 
		{
		//	req_Building="'23 Marina'";
			if(req_Building1!=null || req_Building2!=null || req_Building3!=null)
			{
				build1 = req_Building1;
				build2 = req_Building2;
				build3 = req_Building3;
				String Fromdate1=null;
				String Todate1=null;
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
				
				String strquery = queryBuilder(req_Building1,req_Building2,req_Building3,DBName);
				ResultSet rs = ConnectionUtil.executeChartQueries(strquery);
				
				if(req_Building1!=null)
				{
					build1= "Entered here";
					int recordsize1=0;
					int recordsize2=0;
					BuildingTrendDetails objBuildingTrendDetails1 = new BuildingTrendDetails();
					if(Fromdate1!=null && Fromdate1.length()==10)
					{
						//String strquery="SELECT Building,AVG(Price_sqft),tran_date FROM "+DBName+".newton WHERE tran_date= '"+Fromdate1+"' and building in('"+req_Building1+"')";
						//String strquery="SELECT Building,AVG(Price_sqft),tran_date FROM "+DBName+".newton WHERE building in('"+req_Building1+"')";
						//buildin1From = strquery;
						//ResultSet rs = conn.createStatement().executeQuery(strquery);
						if(rs!=null)
						{
							if(rs.next())
							{
								recordsize1 = recordsize1+1;
								String toBuildingName2=rs.getString(1);
								Date ToDateVal2=rs.getDate(3);
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
						//String strquery1="SELECT Building,AVG(Price_sqft),tran_date FROM "+DBName+".newton WHERE tran_date= '"+Todate1+"' and building in('"+req_Building1+"')";
						//String strquery1="SELECT Building,AVG(Price_sqft),tran_date FROM "+DBName+".newton WHERE building in('"+req_Building1+"')";
						//buildin1To = strquery1;
						//ResultSet rss = conn.createStatement().executeQuery(strquery1);
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
						//String strquery="SELECT Building,AVG(Price_sqft),tran_date FROM "+DBName+".newton WHERE tran_date= '"+Fromdate1+"' and building in('"+req_Building2+"')";
						//String strquery="SELECT Building,AVG(Price_sqft),tran_date FROM "+DBName+".newton WHERE building in('"+req_Building2+"')";
						//buildin2From = strquery;
//						ResultSet rs = conn.createStatement().executeQuery(strquery);
						if(rs!=null)
						{
							if(rs.next())
							{
								recordsize1 = recordsize1+1;
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
						//String strquery1="SELECT Building,AVG(Price_sqft),tran_date FROM "+DBName+".newton WHERE tran_date= '"+Todate1+"' and building in('"+req_Building2+"')";
						//String strquery1="SELECT Building,AVG(Price_sqft),tran_date FROM "+DBName+".newton WHERE building in('"+req_Building2+"')";
						//buildin2To = strquery1;
						//ResultSet rss = conn.createStatement().executeQuery(strquery1);
						if(rs!=null)
						{
								recordsize2 = recordsize2+1;
								//objBuildingTrendDetails1.setBuilding(rss.getString(1));
								//int topsqftval=rss.getInt(2);
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
				//	req_Building="'29 Burj Boulevard Tower 1'";
					int recordsize1=0;
					int recordsize2=0;
					BuildingTrendDetails objBuildingTrendDetails3 = new BuildingTrendDetails();
					if(Fromdate1!=null && Fromdate1.length()==10)
					{
						//String strquery="SELECT Building,AVG(Price_sqft),tran_date FROM "+DBName+".newton WHERE tran_date= '"+Fromdate1+"' and building in('"+req_Building3+"')";
						//String strquery="SELECT Building,AVG(Price_sqft),tran_date FROM "+DBName+".newton WHERE building in('"+req_Building3+"')";
						//buildin3From = strquery;
						//ResultSet rs = conn.createStatement().executeQuery(strquery);
						if(rs!=null)
						{
							if(rs.next())
							{
							recordsize1 = recordsize1+1;
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
						//String strquery1="SELECT Building,AVG(Price_sqft),tran_date FROM "+DBName+".newton WHERE tran_date= '"+Todate1+"' and building in('"+req_Building3+"')";
						//String strquery1="SELECT Building,AVG(Price_sqft),tran_date FROM "+DBName+".newton WHERE building in('"+req_Building3+"')";
//						buildin3To = strquery1;
//						ResultSet rss = conn.createStatement().executeQuery(strquery1);
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
				
			}
			else
			{
					String strquery="SELECT Building,AVG(Price_sqft),tran_date FROM "+DBName+".newton limit 0";
					ResultSet rs = conn.createStatement().executeQuery(strquery);
					//ResultSet rss = conn.createStatement().executeQuery(strquery);
			}
			
		}
		catch(Exception ex)
		{
			System.out.println("objBuildingTrendDetails exception --->"+ex);
			build1= "Entered here with exception"+ex.getMessage();
		}
		return colBuildingTrendDetails;
	}
	
	public static String queryBuilder(String req_Building1,String req_Building2,String req_Building3,String DBName){
		String lineChartBuildQuery = "SELECT Building,AVG(Price_sqft),tran_date FROM "+DBName+".newton WHERE building in('";
		
		if(req_Building1 != null)
		{
			lineChartBuildQuery = lineChartBuildQuery + req_Building1 + "','";
		}
		if(req_Building2 != null)
		{
			lineChartBuildQuery = lineChartBuildQuery + req_Building2 + "','";
		}
		
		if(req_Building3 != null)
		{
			lineChartBuildQuery = lineChartBuildQuery + req_Building3 + "') GROUP BY Building";
		}
		
		return lineChartBuildQuery;
	}
	
	
}
