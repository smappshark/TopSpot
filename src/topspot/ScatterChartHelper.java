package topspot;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import com.topspot.ConnectionUtil;
import com.topspot.common.Constants;
public class ScatterChartHelper {
	String url = null;
	String req_Building =null;
	ResultSet rs1 = null;
	public static Connection conn =null;
	public ArrayList<String> colBuildin=new ArrayList<String>();
	public ArrayList<String> colArea=new ArrayList<String>();
	public ArrayList<String> colSubArea=new ArrayList<String>();
	public String scattValue=null;
	public String scattValue1=null;
	public String scattValue2=null;
	public String Fromdate=null;
	public String Todate=null;
	public String Fromdate1=null;
	public String Todate1=null;
	public String Tosplit=null;
	public String Fromsplit=null;
	public String DBName=null;
	
	
	
	public ArrayList<String> colScatBuildNames=null;
	public Map<String,ArrayList<String>> mapScatBuildNames = new HashMap<String,ArrayList<String>>();
	public java.util.ArrayList<java.util.ArrayList<Integer>> colSctcounts = new java.util.ArrayList<java.util.ArrayList<Integer>>();
	public ArrayList<String> colScatBBuild= new ArrayList<String>();
	public static void main(String[] args)
	{
		ScatterChartHelper objScatterChartHelper = new ScatterChartHelper();
		objScatterChartHelper.getConnection();
	}
	public void getConnection()
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
			//commented on 01-08-2014 by gopal
			/*Class.forName("com.mysql.jdbc.GoogleDriver");
	        url = "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root";
			DBName = "TameerClientDB";*/
			//commented on 01-08-2014 by gopal
			//DBName = "TameerClientDB";
		//	}
				//commenetd by gopal on 31-07-2014
				//conn = DriverManager.getConnection(url);
				//commenetd by gopal on 31-07-2014
			  
			//added by gopal on 31-07-2014
				Constants objConstants = new Constants(); //for reading properties file 
				conn = ConnectionUtil.getConnection(); //for getting google cloud sql connection from util class
				DBName = objConstants.getValue("DBName"); //reading db name from properties file
			System.out.println("conn ----- >"+conn);
			rs1 = conn.createStatement().executeQuery("SELECT DISTINCT(Build_Area) FROM "+DBName+".newton  WHERE (Build_Area IS NOT NULL) ORDER BY Build_Area");
			while(rs1.next())
			{
				String ss2= rs1.getString(1);
				colArea.add(ss2);
			}
			rs1 = conn.createStatement().executeQuery("SELECT DISTINCT(Sub_Area) FROM TameerClientDB.newton WHERE (Sub_Area IS NOT NULL) ORDER BY Sub_Area");
			while(rs1.next())
			{
				String ss2= rs1.getString(1);
				colSubArea.add(ss2);
			}
		}
		catch(Exception ex)
		{
			System.out.println("ex123 ----- >"+ex);
		}
	}
	
	public void getScatterChartData(String req_Area,String req_SubArea,String req_datepicker,String req_datepicker1)
	{
		ResultSet rsBuildNamesForRent = null;
		ResultSet rsBuildNamesForSale = null;
		ResultSet rsBuildNames = null;
		try 
		{
			Fromdate1=req_datepicker;
			Todate1=req_datepicker1;
			int indexval=0;
			String tableName="TameerClientDB.newton";
			String strScatBuildingQuery="SELECT DISTINCT Building,rent_sales FROM "+tableName;
			
			if(req_Area != null && req_Area.length() > 0 && !req_Area.equals("NULL") && !req_Area.equals("null") && !req_Area.equalsIgnoreCase("All"))
			{
				strScatBuildingQuery = strScatBuildingQuery + " WHERE Build_Area='"+req_Area+"'";
				indexval=indexval+1;
			}
			
			else if(req_SubArea != null && req_SubArea.length() > 0 && !req_SubArea.equals("NULL") && !req_SubArea.equals("null") && !req_SubArea.equalsIgnoreCase("All"))
			{
				strScatBuildingQuery = strScatBuildingQuery + " WHERE Sub_Area='"+req_SubArea+"'";
				indexval=indexval+1;
			}
			if(req_datepicker != null && !req_datepicker.equalsIgnoreCase("") && !req_datepicker.equalsIgnoreCase("null") && !req_datepicker.equalsIgnoreCase("From date") && req_datepicker.length()==10)
			{
				String[] strdate=req_datepicker.split("/");
				Fromdate=strdate[2]+"-"+strdate[0]+"-"+strdate[1];
				if(indexval>0)
				{
					strScatBuildingQuery = strScatBuildingQuery + " And tran_date >= '"+Fromdate+"'";
					indexval=indexval+1;
				}
				else
				{
					strScatBuildingQuery = strScatBuildingQuery + " where tran_date >= '"+Fromdate+"'";
					indexval=indexval+1;
				}
			}
			if(req_datepicker1 != null && !req_datepicker1.equalsIgnoreCase("") && !req_datepicker1.equalsIgnoreCase("null") && !req_datepicker1.equalsIgnoreCase("To date") && req_datepicker1.length()==10)
			{
				String[] strdate=req_datepicker1.split("/");
				Todate=strdate[2]+"-"+strdate[0]+"-"+strdate[1];
				if(indexval>0)
				{
					strScatBuildingQuery = strScatBuildingQuery + " And tran_date <= '"+Todate+"'";
				}
				else
				{
					strScatBuildingQuery = strScatBuildingQuery + " where tran_date <= '"+Todate+"'";
				}
			}
			
			strScatBuildingQuery = strScatBuildingQuery + " ORDER BY Building";
			scattValue = strScatBuildingQuery;
			//System.out.println("#136:   " + strScatBuildingQuery);
			rsBuildNames = conn.createStatement().executeQuery(strScatBuildingQuery);
			while(rsBuildNames.next())
			{
				colScatBuildNames=new ArrayList<String>();
					if(mapScatBuildNames != null && mapScatBuildNames.containsKey(rsBuildNames.getString(1)))
					{
						colScatBuildNames = mapScatBuildNames.get(rsBuildNames.getString(1));
					}
				colScatBuildNames.add(rsBuildNames.getString(2));	
				mapScatBuildNames.put(rsBuildNames.getString(1), colScatBuildNames);
				colScatBuildNames=null;
			}
			rsBuildNames=null;
			
			Set<String> setScatBuild=mapScatBuildNames.keySet();
			Iterator setItrScatBuild=setScatBuild.iterator();
			String inputParametersForQuery = "";
			while(setItrScatBuild.hasNext())
			{
				String strSctVal=(String)setItrScatBuild.next();
				if(strSctVal !=null && mapScatBuildNames.containsKey(strSctVal))
				{
					if(mapScatBuildNames.get(strSctVal).size() ==2)
					{
						colScatBBuild.add(strSctVal);
						inputParametersForQuery = inputParametersForQuery + "'"+strSctVal+"',";
					}
				}
			}
			
			Iterator<String> colItrScatBuild=colScatBBuild.iterator();
			inputParametersForQuery =  inputParametersForQuery.substring(0,inputParametersForQuery.length() - 1);
			
			//for Rent
			String dynamciSqlQueryForRent = scatterChartQueryBuilder(tableName,"Rent",inputParametersForQuery);
			rsBuildNamesForRent = ConnectionUtil.executeChartQueries(dynamciSqlQueryForRent,conn);
			
			//for Sales
			String dynamciSqlQueryForSale = scatterChartQueryBuilder(tableName,"Sales",inputParametersForQuery);
			rsBuildNamesForSale = ConnectionUtil.executeChartQueries(dynamciSqlQueryForSale,conn);
			
			while(colItrScatBuild.hasNext())
			{
				java.util.ArrayList<Integer> colSctCount=new java.util.ArrayList<Integer>();
				rsBuildNamesForRent.next();
				rsBuildNamesForSale.next();
				colSctCount.add(rsBuildNamesForRent.getInt(1));
				colSctCount.add(rsBuildNamesForSale.getInt(1));	
				colSctcounts.add(colSctCount);
			}
			
			
			/*Iterator colItrScatBuild=colScatBBuild.iterator();
			while(colItrScatBuild.hasNext())
			{
				java.util.ArrayList<Integer> colSctCount=new java.util.ArrayList<Integer>();
				String strSctBuil=(String)colItrScatBuild.next();
				String strScatRentQuery="SELECT AVG(Price_sqft) FROM "+tableName+" WHERE Building='"+strSctBuil+"' AND rent_sales='Rent'";
				scattValue1=strScatRentQuery;
				rsBuildNames = conn.createStatement().executeQuery(strScatRentQuery);
				rsBuildNames.next();
				colSctCount.add(rsBuildNames.getInt(1));
				rsBuildNames=null;
				String strScatSalesQuery="SELECT AVG(Price_sqft) FROM "+tableName+" WHERE Building='"+strSctBuil+"' AND rent_sales='Sales'";
				scattValue2=strScatSalesQuery;
				//System.out.println("#178:   " + strScatSalesQuery);
				rsBuildNames = conn.createStatement().executeQuery(strScatSalesQuery);
				rsBuildNames.next();
				colSctCount.add(rsBuildNames.getInt(1));
				colSctcounts.add(colSctCount);
			}*/
			
		}
		catch(Exception ex)
		{
			scattValue="Exception--->"+ex.getMessage();
		}
		
	}
	
	public static String scatterChartQueryBuilder(String tableName,String salesType,String inParameterString){
		String sqlQuery = "SELECT AVG(Price_sqft),Building FROM "+tableName+" WHERE Building IN(" + inParameterString;
		
		
		if(inParameterString != null)
		{
			sqlQuery = sqlQuery + ") AND rent_sales='"+salesType+"' GROUP BY Building";
		}
		
		return sqlQuery;
	}
}
