<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.google.appengine.api.utils.SystemProperty" %>
<%@ page import="com.topspot.common.Constants" %>
<%@ page import="com.topspot.ConnectionUtil" %>

<html>
  <body>
<%
String url = null;
String DBName = null;
/* if (SystemProperty.environment.value() ==
    SystemProperty.Environment.Value.Production) {
  // Load the class that provides the new "jdbc:google:mysql://" prefix.
  Class.forName("com.mysql.jdbc.GoogleDriver");
  url = "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root";
} else {
  // Local MySQL instance to use during development.
  Class.forName("com.mysql.jdbc.Driver");
  url = "jdbc:mysql://127.0.0.1:3306/TameerClientDB?user=root";
} */
//Class.forName("com.mysql.jdbc.Driver");
//url = "jdbc:mysql://173.194.85.211:3306/TameerClientDB?user=root&password=tameer123";

//commented on 01-08-2014 by gopal
//Class.forName("com.mysql.jdbc.GoogleDriver");
//url = "jdbc:google:mysql://optimum-time-518:tameer-db/TameerClientDB?user=root";
//commented on 01-08-2014 by gopal

//DBName = "TameerClientDB";
String req_Building =null;
ResultSet rs = null;
ResultSet rss = null;
if(request.getParameter("hid_Building") != null)
req_Building=request.getParameter("hid_Building");
//req_Building="23 Marina";

//commented on 01-08-2014 by gopal
//Connection conn = DriverManager.getConnection(url);
//commented on 01-08-2014 by gopal

//added by gopal on 31-07-2014
Constants objConstants = new Constants(); //for reading properties file 
Connection conn = ConnectionUtil.getConnection(); //for getting google cloud sql connection from util class
DBName = objConstants.getValue("DBName"); //reading db name from properties file

ResultSet rs1 = null;
rs1 = conn.createStatement().executeQuery("SELECT DISTINCT(building) FROM "+DBName+".newton ORDER BY building");
	String ss1=null;

		if(req_Building!=null)
		{
			String strquery="SELECT Building,AVG(Price_sqft),tran_date FROM "+DBName+".newton WHERE tran_date= (SELECT MIN(tran_date) FROM TameerClientDB.newton";
			strquery = strquery+"  WHERE building ='"+req_Building+"') and building ='"+req_Building+"'";
			rs = conn.createStatement().executeQuery(strquery);

			String strquery1="SELECT Building,AVG(Price_sqft),tran_date FROM "+DBName+".newton WHERE tran_date= (SELECT MAX(tran_date) FROM TameerClientDB.newton";
			strquery1 = strquery1+"  WHERE building ='"+req_Building+"') and building ='"+req_Building+"'";
			rss = conn.createStatement().executeQuery(strquery1);
		}
		else
		{
				String strquery="SELECT Building,AVG(Price_sqft),tran_date FROM "+DBName+".newton limit 0";
			rs = conn.createStatement().executeQuery(strquery);
			rss = conn.createStatement().executeQuery(strquery);
		}
%>
<form action="PriceTrendsLineChart.jsp" method="post" onsubmit="checkForm();">
<table style="border-collapse:collapse" border="1">
<tr><td>
<table style="border-collapse:collapse" border="0" align="center">
<tr>
	<td nowrap>
		
		<div align="center">Building <br>
		<select name="sel_Building" id="sel_Building">
		<%
			if(req_Building == null || req_Building.equals("null") || req_Building.equals("All") )
			{
		%>
		<option value="All" selected>All</option>
		<%
			}
		else
		{
			%>
			<option value="All">All</option>
			<%
		}
		while(rs1.next())
			{
				ss1= rs1.getString(1);
				if(ss1.equals(req_Building))
				{
			%>
			<option value= "<%= ss1 %>" selected><%=ss1 %></option> 
			<%
				}
			else
				{
		%>
		<option value= "<%= ss1 %>" ><%=ss1 %></option> 
		<%
				}
			}							
		%>
</select> 
</div>
	</td>
</tr>
</table>
</td>
</tr>
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script Language="JavaScript">
var jsArr = new Array();  
      google.load("visualization", "1", {packages:["corechart"]});
      google.setOnLoadCallback(drawChart);
      function drawChart() {
		  <% 
			  int i=0;
			  while(rs.next())
			{ %>
jsArr[<%= i %>] = new Array(); 
jsArr[<%= i %>][0]='<%= rs.getDate(3)%>'; 
jsArr[<%= i %>][1]= '<%=rs.getInt(2) %>'; 
<% 
	i++;
} %>
<% 
		  while(rss.next())
			{ %>
jsArr[<%= i %>] = new Array(); 
jsArr[<%= i %>][0]='<%= rss.getDate(3)%>'; 
jsArr[<%= i %>][1]= '<%= rss.getInt(2) %>'; 
<% 
	i++;
} %>
alert("jsArr-->"+jsArr);
var data = new google.visualization.DataTable();
data.addColumn('string', 'Transaction Date');
data.addColumn('number', 'Building Value'); 
data.addRows(jsArr.length);
for  (var i = 0; i < jsArr.length; i++){
  data.setCell(i,0,jsArr[i][0]);
data.setCell(i,1,jsArr[i][1]);
}
var options = {
          title: "Buildings Price Trends",
        };
	var chart = new google.visualization.LineChart(document.getElementById('piechart'));
    chart.draw(data, options);
	  }

        function checkForm() {
var e1 = document.getElementById("sel_Building");
var strselSubArea = e1.options[e1.selectedIndex].value;
document.getElementById("hid_Building").value =strselSubArea;
        }
    </script>
<tr>
<td align='center' valign='center'>
 <div id="piechart" style="width: 900px; height: 500px;"></div>
	</td>
</tr>
<tr height='80px'>
	<td align='center' valign='center'>
<input type ="submit" value="Show Report" name="B1">
<input type="hidden" name="hid_Building" id="hid_Building">
</td></tr>
</table>
	</form>
  </body>
</html>