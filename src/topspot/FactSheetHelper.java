package topspot;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.topspot.ConnectionUtil;
import com.topspot.common.Constants;

public class FactSheetHelper {
	String url = null;
	String req_Building =null;
	ResultSet rs1 = null;
	public static Connection conn =null;
	public String DBName=null;
	public ArrayList<String> colBuildin=new ArrayList<String>();
	public String scattValue=null;
	public ArrayList<BuildingTrendDetails> colPropValue=new ArrayList<BuildingTrendDetails>();
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
			//url = "jdbc:mysql://173.194.85.211:3306/TameerClientDB?user=root&password=tameer123";
			
			//commented on 01-08-2014 by gopal
			/*Class.forName("com.mysql.jdbc.GoogleDriver");
	        url = "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root";
			DBName = "TameerClientDB";*/
			//commented on 01-08-2014 by gopal
			
		//	}
			//commenetd by gopal on 31-07-2014
			//conn = DriverManager.getConnection(url);
			//commenetd by gopal on 31-07-2014
		  
		//added by gopal on 31-07-2014
			Constants objConstants = new Constants(); //for reading properties file 
			conn = ConnectionUtil.getConnection(); //for getting google cloud sql connection from util class
			DBName = objConstants.getValue("DBName"); //reading db name from properties file
			
			rs1 = conn.createStatement().executeQuery("SELECT DISTINCT(Building) FROM "+DBName+".building_database_final ORDER BY Building");
			while(rs1.next())
			{
				String ss2= rs1.getString(1);
				colBuildin.add(ss2);
			}
		}
		catch(Exception ex)
		{
			System.out.println("getConnection Exception --->"+ex);
		}
		
	}
	public void getFactSheet(String req_Building)
	{
		try
		{
			
			if(req_Building != null && !req_Building.equals("null") && req_Building.length() > 0 && !req_Building.equals("All") )
			{
				String strquery="select City,Area,Building,Building_Type,Floors,Height,Completion,Developer FROM "+DBName+".building_database_final";
				strquery = strquery+" where Building='"+req_Building+"'";
				scattValue=strquery;
				System.out.println("scattValue --->"+scattValue);
				ResultSet rs = conn.createStatement().executeQuery(strquery);
				while(rs.next())
				{
					System.out.println("getConnection enter while loop --->");
					BuildingTrendDetails objTopspotBean = new BuildingTrendDetails();
					objTopspotBean.setCity(rs.getString(1));
					objTopspotBean.setArea(rs.getString(2));
					objTopspotBean.setBuilding(rs.getString(3));
					objTopspotBean.setBuilding_Type(rs.getString(4));
					objTopspotBean.setFloors(rs.getInt(5));
					objTopspotBean.setHeight(rs.getInt(6));
					objTopspotBean.setCompletion(rs.getInt(7));
					objTopspotBean.setDeveloper(rs.getString(8));
					colPropValue.add(objTopspotBean);	
				}
			}
		}
		catch(Exception ex)
		{
			System.out.println("getConnection Exception --->"+ex);
		}
	}
	public void updateFactSheet(String req_Building,String comments)
	{
		if(req_Building != null && !req_Building.equals("null") && req_Building.length() > 0 && !req_Building.equals("All") && 
				comments != null && !comments.equals("null") && comments.length() > 0 && !comments.equals(""))
		{
			try
			{
	            String sql = "UPDATE "+DBName+".building_database_final SET Comments='"+comments+"' where Building='"+req_Building+"'";
	            conn.createStatement().executeUpdate(sql);
			}
			catch(Exception ex)
			{
				System.out.println("updateFactSheet Exception --->"+ex);
			}
		}
	}
}
