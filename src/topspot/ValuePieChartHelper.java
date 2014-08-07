package topspot;

import java.sql.DriverManager;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

import com.google.appengine.api.utils.SystemProperty;
import com.topspot.ConnectionUtil;

import com.topspot.common.Constants;

public class ValuePieChartHelper {
	String url = null;
	public static Connection conn =null;
	ResultSet rs1 = null;
	public ArrayList<String> colArea=new ArrayList<String>();
	public ArrayList<String> colSubArea=new ArrayList<String>();
	public ArrayList<String> colBuildType=new ArrayList<String>();
	public ArrayList<String> colcomres=new ArrayList<String>();
	public ArrayList<String> colrentsales=new ArrayList<String>();
	public ArrayList<TopspotBean> colPropValue=new ArrayList<TopspotBean>();
	public String Fromdate=null;
	public String Todate=null;
	public String scattValue=null;
	public String Fromdate1=null;
	public String Todate1=null;
	public String DBName=null;
	public String DBName1=null;
	public String DBName2=null;
	public void getConnection()
	{
		try
		{
			
			System.out.println("getConnection");
			/*if (SystemProperty.environment.value() == SystemProperty.Environment.Value.Development) 
			{*/
			  // Load the class that provides the new "jdbc:google:mysql://" prefix.
			
			//Class.forName("com.mysql.jdbc.Driver");
			//url = "jdbc:mysql://173.194.85.211:3306/TameerClientDB?user=root&password=tameer123";
			
			//commenetd by gopal on 31-07-2014
			/*Class.forName("com.mysql.jdbc.GoogleDriver");
	        url = "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root";
			DBName = "TameerClientDB";*/ 
			//commenetd by gopal on 31-07-2014
			
//			  Class.forName("com.mysql.jdbc.GoogleDriver");
//			  url = "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root";
			  //DBName = "topspot";
		/*	} 
			else 
			{
			  // Local MySQL instance to use during development.
			  Class.forName("com.mysql.jdbc.Driver");
			  url = "jdbc:mysql://192.168.10.192:3306/topspot?user=root";
			  DBName = "topspot";
			}*/
			
			//commenetd by gopal on 31-07-2014
			//conn = DriverManager.getConnection(url);
			//commenetd by gopal on 31-07-2014
			
			//added by gopal on 31-07-2014
			Constants objConstants = new Constants(); //for reading properties file 
			conn = ConnectionUtil.getConnection(); //for getting google cloud sql connection from util class
			DBName = objConstants.getValue("DBName"); //reading db name from properties file
			
			DBName1="done1";
			rs1 = conn.createStatement().executeQuery("SELECT DISTINCT(Build_Area) FROM "+DBName+".newton WHERE (Build_Area IS NOT NULL) ORDER BY Build_Area");
			
			while(rs1.next())
			{
				String ss2= rs1.getString(1);
				colArea.add(ss2);
			}
			rs1 = conn.createStatement().executeQuery("SELECT DISTINCT(Sub_Area) FROM "+DBName+".newton WHERE (Sub_Area IS NOT NULL) ORDER BY Sub_Area");
			while(rs1.next())
			{
				String ss2= rs1.getString(1);
				colSubArea.add(ss2);
			}
			
			rs1 = conn.createStatement().executeQuery("SELECT DISTINCT(Build_Type) FROM "+DBName+".newton  WHERE (Build_Type IS NOT NULL) ORDER BY Build_Type");
			while(rs1.next())
			{
				String ss2= rs1.getString(1);
				colBuildType.add(ss2);
			}
			
			rs1 = conn.createStatement().executeQuery("SELECT DISTINCT(com_res) FROM "+DBName+".newton  WHERE (com_res IS NOT NULL) ORDER BY com_res");
			while(rs1.next())
			{
				String ss2= rs1.getString(1);
				colcomres.add(ss2);
			}
			
			rs1 = conn.createStatement().executeQuery("SELECT DISTINCT(rent_sales) FROM "+DBName+".newton WHERE (rent_sales IS NOT NULL) ORDER BY rent_sales");
			while(rs1.next())
			{
				String ss2= rs1.getString(1);
				colrentsales.add(ss2);
			}
			
			
		}
		catch(Exception ex)
		{
			System.out.println("ValuePieChartHelper Exception 107----> "+ex);
			DBName2 = ex.toString();
		}
		
	}
	
	public void getValuePieChartData(String req_Area,String req_Sub_Area,String req_Building_Type,String req_com_res, String req_rent_sales,String req_datepicker,String req_datepicker1)
	{
		Fromdate1=req_datepicker;
		Todate1=req_datepicker1;
		int indexval=0;
		try
		{
			String strquery="SELECT Building , MAX(price_sqft) FROM "+DBName+".newton";
			int querycount=0;
			if(req_Area != null && !req_Area.equals("null") && req_Area.length() > 0 && !req_Area.equals("All") )
			{
				strquery = strquery+" where Build_Area='"+req_Area+"' ";
				querycount=querycount+1;
			}
		/*	if(req_Sub_Area != null && !req_Sub_Area.equals("null") && req_Sub_Area.length() > 0 && !req_Sub_Area.equals("All") )
			{
				
				if(querycount > 0)
					strquery = strquery+" and Sub_Area='"+req_Sub_Area+"'";
						else
							strquery = strquery+" where Sub_Area='"+req_Sub_Area+"'";
					querycount=querycount+1;
			}*/
			if(req_Building_Type != null && !req_Building_Type.equals("null") && req_Building_Type.length() > 0 && !req_Building_Type.equals("All") )
			{
					if(querycount > 0)
				strquery = strquery+" and Build_Type='"+req_Building_Type+"'";
					else
						strquery = strquery+" where Build_Type='"+req_Building_Type+"'";
				querycount=querycount+1;
			}
			if(req_com_res != null && !req_com_res.equals("null") && req_com_res.length() > 0 && !req_com_res.equals("All"))
			{
					if(querycount > 0)
				strquery = strquery+" and com_res='"+req_com_res+"'";
					else
						strquery = strquery+" where com_res='"+req_com_res+"'";
				querycount=querycount+1;
			}
			if(req_rent_sales != null && !req_rent_sales.equals("null") && req_rent_sales.length() > 0  && !req_rent_sales.equals("All"))
			{
					if(querycount > 0)
				strquery = strquery+" and rent_sales='"+req_rent_sales+"'";
					else
						strquery = strquery+" where rent_sales='"+req_rent_sales+"'";
				querycount=querycount+1;
			}
			if(req_datepicker != null && !req_datepicker.equalsIgnoreCase("") && !req_datepicker.equalsIgnoreCase("null") && !req_datepicker.equalsIgnoreCase("From date") && req_datepicker.length()==10)
			{
				String[] strdate=req_datepicker.split("/");
				Fromdate=strdate[2]+"-"+strdate[0]+"-"+strdate[1];
				if(querycount>0)
				{
					strquery = strquery + " And tran_date >= '"+Fromdate+"'";
					querycount=querycount+1;
				}
				else
				{
					strquery = strquery + " where tran_date >= '"+Fromdate+"'";
					querycount=querycount+1;
				}
			}
			if(req_datepicker1 != null && !req_datepicker1.equalsIgnoreCase("") && !req_datepicker1.equalsIgnoreCase("null") && !req_datepicker1.equalsIgnoreCase("To date") && req_datepicker1.length()==10)
			{
				String[] strdate=req_datepicker1.split("/");
				Todate=strdate[2]+"-"+strdate[0]+"-"+strdate[1];
				if(querycount>0)
				{
					strquery = strquery + " And tran_date <= '"+Todate+"'";
				}
				else
				{
					strquery = strquery + " where tran_date <= '"+Todate+"'";
				}
			}
			
			strquery = strquery+" GROUP BY Building ORDER BY MAX(price_sqft) DESC LIMIT 10";
			scattValue=strquery;
			ResultSet rs = conn.createStatement().executeQuery(strquery);
			while(rs.next())
			{
				TopspotBean objTopspotBean = new TopspotBean();
				objTopspotBean.setBuildingName(rs.getString(1));
				objTopspotBean.setBuildValue(rs.getInt(2));
				colPropValue.add(objTopspotBean);	
			}
		}
		catch(Exception ex)
		{
			scattValue="Exception--->"+ex.getMessage();
		}
	}
	
}
