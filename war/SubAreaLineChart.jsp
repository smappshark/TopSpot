<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
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
//commented on 01-08-2014 by gopal
//Connection conn = DriverManager.getConnection(url);
//commented on 01-08-2014 by gopal

//added by gopal on 31-07-2014
Constants objConstants = new Constants(); //for reading properties file 
Connection conn = ConnectionUtil.getConnection(); //for getting google cloud sql connection from util class
DBName = objConstants.getValue("DBName"); //reading db name from properties file
		
ResultSet rs1 = null;
String strquery="SELECT Area , AVG(price_sqft) FROM "+DBName+".sales_csv";
		int querycount=0;
		strquery = strquery+" GROUP BY Area";
ResultSet rs = conn.createStatement().executeQuery(strquery);
%>
<form action="SubAreaLineChart.jsp" method="post" onsubmit="checkForm();">
<table style="border-collapse:collapse" border="1">
<tr height='80px'>
	<td align='center' valign='center'>
	
<input type ="submit" value="Show Report" name="B1">
<input type="hidden" name="hid_Sub_Area" id="hid_Sub_Area">
<input type="hidden" name="hid_Area" id="hid_Area">
<input type="hidden" name="hid_Type" id="hid_Type">
<input type="hidden" name="hid_com_res" id="hid_com_res">
<input type="hidden" name="hid_rent_sales" id="hid_rent_sales">
</td></tr>
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
jsArr[<%= i %>][0]='<%= rs.getString(1) %>'; 
jsArr[<%= i %>][1]= '<%= rs.getInt(2) %>'; 
<% 
	i++;
} %>
var data = new google.visualization.DataTable();
data.addColumn('string', 'SubArea Name');
data.addColumn('number', 'Price per Sqft'); 
data.addRows(jsArr.length);
for  (var i = 0; i < jsArr.length; i++){
  data.setCell(i,0,jsArr[i][0]);
data.setCell(i,1,jsArr[i][1]);
}
var options = {
          title: "Sub-Areas by Value",
         curveType: 'function',
        };
	var chart = new google.visualization.LineChart(document.getElementById('linechart'));
    chart.draw(data, options);
	  }
    </script>
<tr>
<td align='center' valign='center'>
 <div id="linechart" style="width: 900px; height: 500px;"></div>
	</td>
</tr>

</table>
	</form>
  </body>
</html>