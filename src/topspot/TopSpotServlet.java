package topspot;

import java.io.IOException;

import javax.servlet.http.*;

import com.google.appengine.api.utils.SystemProperty;

import java.sql.*;

import javax.servlet.http.*;

@SuppressWarnings("serial")
public class TopSpotServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException {
		resp.setContentType("text/plain");
		java.io.PrintWriter out =resp.getWriter();
		String url = null;
		String req_Building =null;
		ResultSet rs = null;
		ResultSet rss = null;
		ResultSet rs1 = null;
		Connection conn =null;
		String ss1=null;
		try
		{
		if (SystemProperty.environment.value() ==
		    SystemProperty.Environment.Value.Production) {
			out.println("Entered here1");
		  // Load the class that provides the new "jdbc:google:mysql://" prefix.
			//Class.forName("com.mysql.jdbc.Driver");
			//url = "jdbc:mysql://173.194.85.211:3306/TameerClientDB?user=root&password=tameer123";
			
			Class.forName("com.mysql.jdbc.GoogleDriver");
	        url = "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root";
			//DBName = "TameerClientDB";
		  out.println("Entered here3 -->"+url);
		} else {
		  // Local MySQL instance to use during development.
			out.println("Entered here4");
		  Class.forName("com.mysql.jdbc.Driver");
		  url = "jdbc:mysql://127.0.0.1:3306/TameerClientDB?user=root";
		  out.println("Entered here5 -->"+url);
		}
		
		if(req.getParameter("hid_Building") != null)
		req_Building=req.getParameter("hid_Building");
		//req_Building="23 Marina";
		out.println("Entered herereq_Building -->"+req_Building);
		conn = DriverManager.getConnection(url);
		
		rs1 = conn.createStatement().executeQuery("SELECT DISTINCT(building) FROM TameerClientDB.newton ORDER BY building");
			

				if(req_Building!=null)
				{
					String strquery="SELECT Building,AVG(Price_sqft),tran_date FROM TameerClientDB.newton WHERE tran_date= (SELECT MIN(tran_date) FROM TameerClientDB.newton";
					strquery = strquery+"  WHERE building ='"+req_Building+"') and building ='"+req_Building+"'";
					rs = conn.createStatement().executeQuery(strquery);

					String strquery1="SELECT Building,AVG(Price_sqft),tran_date FROM TameerClientDB.newton WHERE tran_date= (SELECT MAX(tran_date) FROM TameerClientDB.newton";
					strquery1 = strquery1+"  WHERE building ='"+req_Building+"') and building ='"+req_Building+"'";
					rss = conn.createStatement().executeQuery(strquery1);
				}
				else
				{
						String strquery="SELECT Building,AVG(Price_sqft),tran_date FROM TameerClientDB.newton limit 0";
					rs = conn.createStatement().executeQuery(strquery);
					rss = conn.createStatement().executeQuery(strquery);
				}
				
				while(rs1.next())
				{
					ss1= rs1.getString(1);
					out.println("Entered here5 ss1 -->"+ss1);
				}
				
				
		}
		catch(Exception ex)
		{
			
			out.println("Entered Exception ex -->"+ex);
			
		}
	}
}
