<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@page import="topspot.ConnectToCloudSQL"%>
<%@page import="topspot.BuildingTrendDetails"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script>
    
    function selectedBuildingOne(selectedBuidling){
    	$('#buildingOne').text("");
    	$('#buildingOne').text(selectedBuidling);
    	$('#hid_Building1').val(selectedBuidling);
    }
    
    function selectedBuildingTwo(selectedBuidling){
    	$('#buildingTwo').text("");
    	$('#buildingTwo').text(selectedBuidling);
    	$('#hid_Building2').val(selectedBuidling);
    }

    function selectedBuildingThree(selectedBuidling){
    	$('#buildingThree').text("");
    	$('#buildingThree').text(selectedBuidling);
    	$('#hid_Building3').val(selectedBuidling);
    }

    if ( /*@cc_on!@*/ false && document.documentMode === 10)
    {
        document.documentElement.className += ' ie ie10';
    }
    </script>

    
    </head>
<%
String req_Building1 =null;
if(request.getParameter("hid_Building1") != null)
req_Building1=request.getParameter("hid_Building1");

String req_Building2 =null;
if(request.getParameter("hid_Building2") != null)
req_Building2=request.getParameter("hid_Building2");

String req_Building3 =null;
if(request.getParameter("hid_Building3") != null)
req_Building3=request.getParameter("hid_Building3");

String req_datepicker =null;
if(request.getParameter("hid_datepicker") != null  && !request.getParameter("hid_datepicker").equals("From date") && request.getParameter("hid_datepicker")!="")
req_datepicker=request.getParameter("hid_datepicker");

String req_datepicker1 =null;
if(request.getParameter("hid_datepicker1") != null  && !request.getParameter("hid_datepicker1").equals("To date") && request.getParameter("hid_datepicker")!="")
req_datepicker1=request.getParameter("hid_datepicker1");

ArrayList<Integer> colpersqftFrom=new ArrayList<Integer>();
ArrayList<Integer> colpersqftTo=new ArrayList<Integer>();
ConnectToCloudSQL objConnectToCloudSQL = new ConnectToCloudSQL();
ArrayList<String> colBuild =objConnectToCloudSQL.getConnection();
Iterator<String> colItr1=colBuild.iterator();
Iterator<String> colItr2=colBuild.iterator();
Iterator<String> colItr3=colBuild.iterator();

//Iterator<String> colAreaItr=objConnectToCloudSQL.colArea.iterator();
//Iterator<String> colSubAreaItr=objConnectToCloudSQL.colSubArea.iterator();

List<BuildingTrendDetails> colBuildingTrendDetails=objConnectToCloudSQL.getLineChartData(req_Building1,req_Building2,req_Building3,req_datepicker,req_datepicker1);
String buildin1From = objConnectToCloudSQL.buildin1From;
String buildin1To = objConnectToCloudSQL.buildin1To;
String buildin2From = objConnectToCloudSQL.buildin2From;
String buildin2To = objConnectToCloudSQL.buildin2To;
String buildin3From = objConnectToCloudSQL.buildin3From;
String buildin3To = objConnectToCloudSQL.buildin3To;
Iterator<String> colItrBuildingDate = null;
java.util.ArrayList<String> colDate = objConnectToCloudSQL.colDate;
if(colDate !=null && colDate.size()> 0)
{
colItrBuildingDate = colDate.iterator();
}
Iterator<BuildingTrendDetails> colItrBuildingTrendDetails1=null;
List<String> colListBuil=new ArrayList<String>();
if(colBuildingTrendDetails != null && colBuildingTrendDetails.size() > 0)
{
	colItrBuildingTrendDetails1=colBuildingTrendDetails.iterator();
}
if(colItrBuildingTrendDetails1 !=null)
{
	while(colItrBuildingTrendDetails1.hasNext())
	{
		BuildingTrendDetails BuildingTrendDetailsobj=colItrBuildingTrendDetails1.next();
		colpersqftFrom.add((int)BuildingTrendDetailsobj.getFromPriPerSqft());
		colpersqftTo.add((int)BuildingTrendDetailsobj.getToPriPerSqft());
		colListBuil.add(BuildingTrendDetailsobj.getBuilding());
	}
}
Iterator<String> colItrBuilding = null;
if(colListBuil != null && colListBuil.size()> 0)
{
	colItrBuilding = colListBuil.iterator();
}
java.util.ArrayList<java.util.ArrayList<Integer>> colreps= new java.util.ArrayList<java.util.ArrayList<Integer>>();
if(colpersqftFrom.size()>0 && colpersqftTo.size()>0)
{
colreps.add(colpersqftFrom);
colreps.add(colpersqftTo);
}
Iterator<java.util.ArrayList<Integer>> colItrBuildingPSQFT =null;
if(colreps != null && colreps.size()>0)
{
	colItrBuildingPSQFT = colreps.iterator();
}

%>
<body>
<div class="innerLR">
                <h2 class="margin-none">Analytics &nbsp;<i class="fa fa-fw fa-pencil text-muted"></i>
                </h2>
                <div class="row">
                    <div class="col-md-8" style="width:100%">
                        
                        <div class="subnav">
                            <ul id="nav">
                                <li><a href="#" id="buildingOne">Building 1</a>
                                    <ul>
                                    <%
										if(colItr1!=null)
										{
										while(colItr1.hasNext())
											{
												String ss1= colItr1.next();
												if(ss1 != null && !ss1.equals("NULL") && !ss1.equals("null") && ss1.equals(req_Building1))
												{
										%>
                                        <li><a href="#" onclick="selectedBuildingOne('<%= ss1 %>');"><%= ss1 %></a></li>
                                 <%
											}
										else
											{
									%>
									 <li><a href="#" onclick="selectedBuildingOne('<%= ss1 %>');"><%= ss1 %></a></li>
												<%
											}
										}
									}
									%>
                                    </ul>
                                </li>
                                <li><a href="#" id="buildingTwo">Building 2</a>
                                    <ul>
            <%                           if(colItr2!=null)
		{
		while(colItr2.hasNext())
			{
				String ssSubA= colItr2.next();
				if(ssSubA != null && !ssSubA.equals("NULL") && !ssSubA.equals("null") && ssSubA.equals(req_Building2))
				{
			%>
                                        <li><a href="#" onclick="selectedBuildingTwo('  <%=ssSubA %>  ');"><%= ssSubA %></a></li>
                                        <%
				}
			else
				{
		%>
		<li><a href="#" onclick="selectedBuildingTwo('  <%=ssSubA %>  ');"><%=ssSubA %></a> </li>
		<%
				}
			}	
		}
		%>
                                    </ul>
                                </li>
                                
                                <li><a href="#" id="buildingThree" >Building 3</a>
                                    <ul>
                                    <%
				if(colItr3!=null)
		{
		while(colItr3.hasNext())
			{
				String sb3= colItr3.next();
				if(sb3 != null && !sb3.equals("NULL") && !sb3.equals("null") && sb3.equals(req_Building3))
				{
			%>
                                        <li><a href="#" onclick="selectedBuildingThree(' <%=sb3 %> ');"><%=sb3 %></a></li>
                                  <%
				}
			else
				{
		%>
		<li><a href="#" onclick="selectedBuildingThree(' <%=sb3 %> ');"><%=sb3 %></a> </li>
		<%
				}
			}	
		}
		%>
                                    </ul>
                                </li>
                                <li><input type="text" id="datepicker" name="date" class="tcal" value="From date"/> </li>
                                 <li><input type="text" id="datepicker1" name="date1" class="tcal" value="To date"> </li>
                                 <li><input type ="submit" value="Show Report" name="B1"/> </li>
                                <!--  <li><a href="#">Type 1</a>
                                    <ul>
                                        <li><a href="#">Type</a></li>
                                        <li><a href="#">Type</a></li>
                                        <li><a href="#">Type</a></li>
                                    </ul>
                                </li> -->
                            </ul>
                        </div>
                        <!-- //Row -->
                        <!-- Widget -->
                        <div class=" widget widget-body-white " style="width:100%">
                           
                            <div class="widget-body innerAll">
                                <!-- Chart with lines and fill with no points -->
                              <!--  <div id="chart_lines_fill_nopoints_2" class="flotchart-holder"></div>-->
                                <div class="rightBlock">
		<div id="piechart" style="width: 600px; height: 400px;" class="wrapper"></div>
		</div>
                            </div>
                        </div>
                        <!-- //Widget -->
                        <div class="row">
                            <div class="tabmargin">
                    <div class="tabContentSec"> <h2 style="background:none;" class="asset-icon">Project Information Building 1</h2> </div>
                    <div class="tabContent_data">
                        <table cellpadding="5" cellspacing="0" width="100%" class="dataTbl">
                            <tr>
                                <td>Project Name</td> <td>Princess Tower</td> <td>Type</td> <td>Highr Rise</td> 
                            </tr>
                            <tr>
                                <td>Area</td> <td>Dubau Marina</td> <td>Developer</td> <td>Tameer Holdind Investments</td> 
                            </tr>
                            <tr>
                                <td>No. of Floors</td> <td>107</td> <td>Building Status</td> <td>Completed</td> 
                            </tr>
                            <tr>
                                <td>Completion Date</td> <td>2012</td> <td></td> <td></td> 
                            </tr>
                            <tr>
                                <td>Usage</td> <td>Residential</td> <td></td> <td></td> 
                            </tr>
                        </table>
                    </div>
                </div><!--tabmargin end-->
                            <div class="tabmargin">
                                <div class="tabContentSec"> <h2 style="background:none;" class="asset-icon">Project Information Building 2</h2> </div>
                                <div class="tabContent_data">
                                    <table cellpadding="5" cellspacing="0" width="100%" class="dataTbl">
                                        <tr>
                                            <td>Project Name</td> <td>Princess Tower</td> <td>Type</td> <td>Highr Rise</td> 
                                        </tr>
                                        <tr>
                                            <td>Area</td> <td>Dubau Marina</td> <td>Developer</td> <td>Tameer Holdind Investments</td> 
                                        </tr>
                                        <tr>
                                            <td>No. of Floors</td> <td>107</td> <td>Building Status</td> <td>Completed</td> 
                                        </tr>
                                        <tr>
                                            <td>Completion Date</td> <td>2012</td> <td></td> <td></td> 
                                        </tr>
                                        <tr>
                                            <td>Usage</td> <td>Residential</td> <td></td> <td></td> 
                                        </tr>
                                    </table>
                                </div>
                            </div><!--tabmargin end-->
                            <div class="tabmargin">
                                <div class="tabContentSec"> <h2 style="background:none;" class="asset-icon">Project Information Building 3</h2> </div>
                                <div class="tabContent_data">
                                    <table cellpadding="5" cellspacing="0" width="100%" class="dataTbl">
                                        <tr>
                                            <td>Project Name</td> <td>Princess Tower</td> <td>Type</td> <td>Highr Rise</td> 
                                        </tr>
                                        <tr>
                                            <td>Area</td> <td>Dubau Marina</td> <td>Developer</td> <td>Tameer Holdind Investments</td> 
                                        </tr>
                                        <tr>
                                            <td>No. of Floors</td> <td>107</td> <td>Building Status</td> <td>Completed</td> 
                                        </tr>
                                        <tr>
                                            <td>Completion Date</td> <td>2012</td> <td></td> <td></td> 
                                        </tr>
                                        <tr>
                                            <td>Usage</td> <td>Residential</td> <td></td> <td></td> 
                                        </tr>
                                    </table>
                                </div>
                            </div><!--tabmargin end-->
                            <div class="tabmargin">
                                <div class="tabContentSec"> <h2 style="background:none;" class="asset-icon">Project Information Building 4</h2> </div>
                                <div class="tabContent_data">
                                    <table cellpadding="5" cellspacing="0" width="100%" class="dataTbl">
                                        <tr>
                                            <td>Project Name</td> <td>Princess Tower</td> <td>Type</td> <td>Highr Rise</td> 
                                        </tr>
                                        <tr>
                                            <td>Area</td> <td>Dubau Marina</td> <td>Developer</td> <td>Tameer Holdind Investments</td> 
                                        </tr>
                                        <tr>
                                            <td>No. of Floors</td> <td>107</td> <td>Building Status</td> <td>Completed</td> 
                                        </tr>
                                        <tr>
                                            <td>Completion Date</td> <td>2012</td> <td></td> <td></td> 
                                        </tr>
                                        <tr>
                                            <td>Usage</td> <td>Residential</td> <td></td> <td></td> 
                                        </tr>
                                    </table>
                                </div>
                            </div><!--tabmargin end-->
                        </div><br/>
                        <!-- //Row -->
                        <!-- Widget	 -->
                        <div class="widget">
                            <div class="widget-head innerAll half">
                                <h4 class="margin-none"><i class="fa fa-fw icon-star"></i> Trends</h4>
                            </div>
                            <!-- Widget -->
                            <div class="widget-body innerAll inner-2x">
                                <table class="table table-striped margin-none">
                                    <thead>
                                        <tr>
                                            <th>Building</th>
                                            <th class="text-center">Average Price</th>
                                            <th class="text-right" style="width: 100px;">Trend</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>
                                                <strong>1.</strong>Frozen</td>
                                            <td class="text-center">&euro;8,718,939</td>
                                            <td class="text-right">
                                                <div class="sparkline" style="width: 100px;" sparkHeight="20" sparkType="line"
                                                sparkWidth="100%" sparkLineWidth="2"
                                                sparkLineColor="#3695d5" sparkFillColor=""
                                                data-data="[358,232,192,259,111,414,220,402,381,257]">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <strong>2.</strong>The Hobbit 2</td>
                                            <td class="text-center">&euro;7,800,000</td>
                                            <td class="text-right">
                                                <div class="sparkline" style="width: 100px;" sparkHeight="20" sparkType="line"
                                                sparkWidth="100%" sparkLineWidth="2"
                                                sparkLineColor="#3695d5" sparkFillColor=""
                                                data-data="[272,316,460,170,392,279,222,135,300,195]">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <strong>3.</strong>The Wolf of Wall Street</td>
                                            <td class="text-center">&euro;5,671,036</td>
                                            <td class="text-right">
                                                <div class="sparkline" style="width: 100px;" sparkHeight="20" sparkType="line"
                                                sparkWidth="100%" sparkLineWidth="2"
                                                sparkLineColor="#3695d5" sparkFillColor=""
                                                data-data="[255,280,124,254,305,399,197,292,245,392]">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <strong>4.</strong>Iron Man 3</td>
                                            <td class="text-center">&euro;409,013,994</td>
                                            <td class="text-right">
                                                <div class="sparkline" style="width: 100px;" sparkHeight="20" sparkType="line"
                                                sparkWidth="100%" sparkLineWidth="2"
                                                sparkLineColor="#3695d5" sparkFillColor=""
                                                data-data="[357,465,222,471,349,129,150,217,194,476]">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <strong>5.</strong>Catching Fire</td>
                                            <td class="text-center">&euro;398,327,026</td>
                                            <td class="text-right">
                                                <div class="sparkline" style="width: 100px;" sparkHeight="20" sparkType="line"
                                                sparkWidth="100%" sparkLineWidth="2"
                                                sparkLineColor="#3695d5" sparkFillColor=""
                                                data-data="[299,384,280,402,246,395,271,219,179,306]">
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <strong>6.</strong>Despicable Me 2</td>
                                            <td class="text-center">&euro;367,835,345</td>
                                            <td class="text-right">
                                                <div class="sparkline" style="width: 100px;" sparkHeight="20" sparkType="line"
                                                sparkWidth="100%" sparkLineWidth="2"
                                                sparkLineColor="#3695d5" sparkFillColor=""
                                                data-data="[442,231,191,323,445,203,455,295,303,130]">
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                            <!-- // End Widget Body -->
                        </div>
                        <!-- // End Widget -->
                        <!-- Widget	 -->
                        <div class="widget widget-body-white overflow-hidden">
                            <div class="widget-head innerAll half">
                                <h4 class="margin-none"><i class="fa fa-fw icon-wallet"></i> Sales Volume</h4>
                            </div>
                            <div class="widget-body innerAll">
                                <!-- Horizontal Bars Chart -->
                                <div id="chart_horizontal_bars" class="flotchart-holder"></div>
                            </div>
                        </div>
                        <!-- //Widget -->
                    </div>
                  
                </div>
            </div>
                 <input type="hidden" name="hid_Building1" id="hid_Building1">
<input type="hidden" name="hid_Building2" id="hid_Building2">
<input type="hidden" name="hid_Building3" id="hid_Building3">
<input type="hidden" name="hid_datepicker" id="hid_datepicker">
<input type="hidden" name="hid_datepicker1" id="hid_datepicker1">
<script type="text/javascript" src="https://www.google.com/jsapi"></script>
<script Language="JavaScript">
var jsArr = new Array();  
google.load("visualization", "1", {packages:["corechart"]});
google.setOnLoadCallback(drawChart);
function drawChart() 
{
	<% 
	int i=0;
	if(colreps!= null && colreps.size() > 0)
	{
	while(colItrBuildingDate.hasNext())
	{ 
		String dat=colItrBuildingDate.next();
		ArrayList<Integer> colnum=colreps.get(i);
		int j=1;
		Iterator<Integer> itrnum= colnum.iterator();
%>
jsArr[<%= i %>] = new Array(); 
jsArr[<%= i %>][0]='<%= dat%>'; 
<% 
		while(itrnum.hasNext())
		{ 
			int in=itrnum.next();
	%>
jsArr[<%= i %>][<%= j %>]= '<%=in%>'; 
<% 
			j++;
		}
		i++;
	} 
}
%>
if(jsArr != null && jsArr.length > 0)
{
var data = new google.visualization.DataTable();
data.addColumn('string', 'Transaction Date');
<%
if(colItrBuilding != null)
{
while(colItrBuilding.hasNext())
{ 
String strb=colItrBuilding.next();
%>
var valb = '<%=strb%>';
data.addColumn('number', valb); 
<%
}
}
%>
if(jsArr != null && jsArr.length > 0)
{
data.addRows(jsArr.length);
for  (var i = 0; i < jsArr.length; i++){
var arr=jsArr[i];
for  (var j = 0; j < arr.length; j++){
	data.setCell(i,j,jsArr[i][j]);
}
}
var options = {
      title: "Buildings Price Trends",
    };
var chart = new google.visualization.LineChart(document.getElementById('piechart'));
chart.draw(data, options);
}
}

  }
function onloadchanges()
{
	var pickvalue;
	<%
	if(req_datepicker == null || req_datepicker.equals("null") || req_datepicker.equals("From date") || req_datepicker.equals(""))
	{
	%>
	pickvalue ="From date";
	<%
		}
		else
		{
	%>
	pickvalue = '<%=req_datepicker%>';
	<%
		}
	%>
	
	var pickvalueTodate;
	<%
	if(req_datepicker1 == null || req_datepicker1.equals("null") || req_datepicker1.equals("To date") || req_datepicker1.equals("") )
	{
	%>
	pickvalueTodate ="To date";
	<%
		}
		else
		{
	%>
	pickvalueTodate = '<%=req_datepicker1%>';
	<%
		}
	%>
	document.getElementById("datepicker").value=pickvalue;
	document.getElementById("datepicker1").value=pickvalueTodate;
}

	function checkForm() {
		var datepicker = document.getElementById("datepicker").value;
		var datepicker1 = document.getElementById("datepicker1").value;
		document.getElementById("hid_datepicker").value = datepicker;
		document.getElementById("hid_datepicker1").value = datepicker1;			
		$('form').submit();
	}
    </script>
            
</body>
</html>