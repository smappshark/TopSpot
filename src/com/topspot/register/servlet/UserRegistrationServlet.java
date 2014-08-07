package com.topspot.register.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;

import com.topspot.ConnectionUtil;
import com.topspot.Mailer;
import com.topspot.register.Dao.BuildingDao;
import com.topspot.register.beans.Building;
import com.topspot.register.beans.UserBean;


/**
 * Servlet implementation class UserRegistrationServlet
 * @author pdudekula
 */
@WebServlet("/UserRegistrationServlet")
public class UserRegistrationServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final String INSERT_QUERY_START = "insert into users(user_name,prefrred_name,email_id,phone,city,user_area,address,prefrred_communication,country,login_name,user_type,about_me,status) values ('";
	private static final String REGISTRATION_PAGE = "/register.jsp";
	private static final String HOME_PAGE = "/success.jsp";
	
 

	/**
	 * Pulls the request parameters and generates the insert query which would 
	 * insert the new user being registered
	 * @param request
	 * @return String representing the insert query
	 */
	private String generateInsertQuery(HttpServletRequest request) {
		String name = request.getParameter("name");
		String preferredName = request.getParameter("preferredName");
		String email = request.getParameter("emailId");
		String phone = request.getParameter("phone");
		String city = request.getParameter("city");
		String area = request.getParameter("area");
		String address = request.getParameter("address");
		String preferredCommunication = request.getParameter("preferredComm");
		String country = request.getParameter("country");
		String loginName = request.getParameter("loginName");
		String userType = request.getParameter("userType");
		String aboutMe = request.getParameter("aboutMe");
        
		StringBuffer strQuery = new StringBuffer(INSERT_QUERY_START);

		strQuery.append(name);
		strQuery.append("', '");

		strQuery.append(preferredName);
		strQuery.append("', '");

		strQuery.append(email);
		strQuery.append("', '");

		strQuery.append(phone);
		strQuery.append("', '");

		strQuery.append(city);
		strQuery.append("', '");

		strQuery.append(area);
		strQuery.append("', '");

		strQuery.append(address);
		strQuery.append("', '");

		strQuery.append(preferredCommunication);
		strQuery.append("', '");

		strQuery.append(country);
		strQuery.append("', '");

		strQuery.append(loginName);
		strQuery.append("', '");

		strQuery.append(userType);
		strQuery.append("', '");

		strQuery.append(aboutMe);
		strQuery.append("', '");
		
		strQuery.append("pending");
		strQuery.append("')");

		return strQuery.toString();

	}
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		 if(StringUtils.equals("adminGetUsers", request.getParameter("fromPage"))){
			 RequestDispatcher requestDispatcher=getServletContext().getRequestDispatcher("/admin.jsp");
			 String query = "select u.id,u.user_name,u.email_id,u.user_type,u.status,us.created from users u join users_session us on (u.id=us.user_id) WHERE password IS NOT NULL AND  u.status='pending'";
			 Connection conn=null;
			 try {
				 List<UserBean> usersList = new ArrayList<UserBean>();
				 conn = ConnectionUtil.getConnection();
				 Statement stmt=conn.createStatement();
				 ResultSet rs = stmt.executeQuery(query);
				 while(rs.next()){
					 UserBean usr = new UserBean();
					 usr.setId( rs.getInt(1));
					 usr.setUsername(rs.getString("u.user_name"));
					 usr.setEmailId(rs.getString("u.email_id"));
					 usr.setUserType(rs.getString("u.user_type"));
					 usr.setStatus(rs.getString("u.status"));
					 usr.setCreated(rs.getString("us.created"));
					 usersList.add(usr);
				 }
				 
				 if(CollectionUtils.isNotEmpty(usersList)){
					 request.setAttribute("usersList",usersList);
					 requestDispatcher.forward(request,response);
				 }else{
					 request.setAttribute("usersList",usersList);
					 requestDispatcher.forward(request,response);
				 }
				 
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				ConnectionUtil.closeConnection(conn);
			}
		 }
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		
		if("investorComments".equals(request.getParameter("fromUser"))){
			
			RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/index.html");

			String buildingId = request.getParameter("buildingId");
			String Comments = request.getParameter("comments");
			

			try {
				BuildingDao.UpdateComments(buildingId,Comments);
				requestDispatcher.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

			
		}
	   else if ("investorFactSheet".equals(request.getParameter("fromUser"))) {
			

			RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/investorFactSheet.jsp");

			String area = request.getParameter("area");
			String propertyType = request.getParameter("property_type");
			String buildingStatus = request.getParameter("building_status");
			String sMetierial = request.getParameter("structural_material");
			String archStyle = request.getParameter("arch_style");

			try {
				List<Building> building = BuildingDao.getBuildingDetails(area,propertyType,buildingStatus,sMetierial,archStyle);
				request.setAttribute("building", building);
				requestDispatcher.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if ("showMap".equals(request.getParameter("fromUser"))) {
			RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/buildMap.jsp");

			String area = request.getParameter("area");
			String subArea = request.getParameter("subarea");
			String buildingStr = request.getParameter("building");

			try {
				List<Building> building = BuildingDao.getBuildingDetails(area,
						subArea, buildingStr);
				request.setAttribute("building", building);
				requestDispatcher.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if ("userLogin".equals(request.getParameter("fromPage"))) {
			validateUser(request, response);
		} else if ("editUserStatus".equals(request.getParameter("fromPage"))) {
			editUserStatus(request, response);
		} else if ("changePassword".equals(request.getParameter("fromPage"))) {
			changePassword(request, response);
		} else {

			String strUserMsg = null;
			// HttpSession session = request.getSession();
			// System.out.println(request.getContextPath());
			RequestDispatcher reqDisp = request.getRequestDispatcher(REGISTRATION_PAGE);
			Connection conn=null;
			try {
				String emailId = request.getParameter("emailId");
				String loginName = request.getParameter("loginName");
				ConnectionUtil.executeQuery(generateInsertQuery(request));

				String query = "select id from users where email_id='"+ emailId + "'";
			    conn = ConnectionUtil.getConnection();

				if (conn != null) {

					int userId = ConnectionUtil.getUserIdByEmailId(conn, query);

					java.util.Date javaDate = new java.util.Date();
					long javaTime = javaDate.getTime();
					Timestamp sqlTimestamp = new Timestamp(javaTime);

					long start_time = System.currentTimeMillis();
					String userSession = String.valueOf(start_time);
					userSession = userId + "_" + userSession;
					String created = sqlTimestamp.toString();
					String lastUpDated = sqlTimestamp.toString();

					String insertQuery = "insert into users_session values("+ userId + ",'" + userSession + "','" + created + "','" + lastUpDated + "')";
					try {
						ConnectionUtil.executeQuery(insertQuery);
					} catch (Exception e) {
						e.printStackTrace();
					}finally {
						ConnectionUtil.closeConnection(conn);
					}
					StringBuffer url = request.getRequestURL();
					String	path = url.substring(0, url.indexOf("registrationServlet"));
					
					String text = "<html><body style='margin:5px; font-family:Arial, Helvetica, sans-serif; font-size:13px;'>"
							    +"<div style='width:680px; min-height:250px; margin:0 auto;background:#f6fcfd;border:1px solid #d9e9eb;border-radius:5px; padding:10px 15px;'>"
							    +"<h1 style='font-size:13px;'>Verify your Email address!</h1>"
							    +"<h2 style='font-size:12px; color:#125f86;'>Dear <span style='font-size:14px;'>"+loginName+"</span></h2>"
							    +"<p style='line-height:20px;'>Congratulations on successfully registering with us.</p>"
								+"<p style='line-height:20px;'>To complete your registration, please verify your email address by clicking below</p>"
							    +"<p>"+path+"changePass.jsp?loginName="+ loginName + "&userSession=" + userSession
							    +"</p><div style='font-size:14px; margin:50px 0 0 0; color:#032c75; line-height:20px;'>"
							    +"Thanks &amp; Regards<br/>TopSpot team<br/>"
						//	    +"<img src='"+path+"images/sign_logo.png'/>"
							    +"</div></div></body></html>";
					Mailer.sendMail("apps@topspot.ae","Cl0ud@ppz", "apps@topspot.ae",emailId, "New registration", text);
				}

				// session.setAttribute("userName",
				// request.getParameter("userName"));
				response.sendRedirect(getServletContext().getContextPath()+ HOME_PAGE);

			} catch (SQLException sqle) {
				// Check if we are getting duplicate key exception on userName
				if (sqle.getMessage().indexOf("Duplicate entry") != -1) {
					strUserMsg = "User name "+ request.getParameter("userName") + " already "+ "exists. Please try another user name.";
				} else { // If other SQLException than dup key exception
					strUserMsg = "Unable to register user "+ request.getParameter("userName")+ ". Please try again later.";
				}
				
				request.setAttribute("userMsg", strUserMsg);
				reqDisp.forward(request, response);

			} catch (Exception e) {
				strUserMsg = "Unable to register user "+ request.getParameter("userName")+ ". Please try again later.";
				
				request.setAttribute("userMsg", strUserMsg);
				reqDisp.forward(request, response);

			}finally {
				ConnectionUtil.closeConnection(conn);
			}
		}

	}

	private void validateUser(HttpServletRequest request,HttpServletResponse response) {
		
		    String userId = request.getParameter("userId");
		    String password = request.getParameter("password");
		    String userType = request.getParameter("userType");
		 
		    Connection conn=null;
			 try {
				 String query = "select u.id,u.login_name,u.email_id,u.user_type,u.status,u.password from users u where u.email_id='"+ userId + "' OR login_name='"+ userId + "'";
				 conn = ConnectionUtil.getConnection();
				 Statement stmt=conn.createStatement();
				 ResultSet rs = stmt.executeQuery(query);
				 UserBean usr = new UserBean();
				 boolean isExists = rs.next();
				 
				 if(!isExists){
					 response.sendRedirect("signin.jsp?message="+"Sorry, you are not a registered user! Please sign up.");
				 }
				if(isExists){
				 usr.setId( rs.getInt(1));
				 usr.setLoginName(rs.getString("u.login_name"));
				 usr.setEmailId(rs.getString("u.email_id"));
				 usr.setUserType(rs.getString("u.user_type"));
				 usr.setStatus(rs.getString("u.status"));
				 usr.setPassword(rs.getString("password"));
				
				 if((StringUtils.isNotEmpty(usr.getEmailId()) || StringUtils.isNotEmpty(usr.getLoginName())) && StringUtils.isNotEmpty(usr.getPassword())){
					 	
					 if(StringUtils.isNotEmpty(usr.getStatus())){
						 	
						 if((StringUtils.equals(userId, usr.getEmailId())||StringUtils.equals(userId, usr.getLoginName())) && StringUtils.equals(ConnectionUtil.encryptMD5(password),usr.getPassword())){
						
							 if(StringUtils.equals(userType, usr.getUserType())){
								 	
								if(StringUtils.equalsIgnoreCase("active", usr.getStatus())){
							
									// valid login navigating page based on user type
									/*	
									 HttpSession session = request.getSession(true);
									 session.setAttribute("currentSessionUser",usr);
									 session.setMaxInactiveInterval(30*60);*/
									 /*if(StringUtils.equals("admin",usr.getUserType())) response.sendRedirect("adminMainPage.jsp");
									 else if (StringUtils.equals("investor",usr.getUserType())) response.sendRedirect("investorLogged.jsp");  
									 else if(StringUtils.equals("broker",usr.getUserType()))  response.sendRedirect("brokerLogged.jsp");
									 else{ 
										 response.sendRedirect("agentLogged.jsp");
									 }*/
									 
									if(StringUtils.equals("admin",usr.getUserType())) response.sendRedirect("admin.jsp");
									else if(StringUtils.equals("investor",usr.getUserType())) response.sendRedirect("investorFactSheet.jsp");
									else response.sendRedirect("pageUnderConstruction.jsp");
								}else{
									
									if(StringUtils.equalsIgnoreCase("pending", usr.getStatus())){
										// registration pending
										 response.sendRedirect("signin.jsp?message="+"Your registration is still pending,need admin approval.");
									}
								} 
						  }else{
							  response.sendRedirect("signin.jsp?message="+"Invalid user type."); 
						  }
						 }else{
							 // Invalid user
							 response.sendRedirect("signin.jsp?message="+"Invalid user name or password.");
						 }
						 
					 }
					 
				 }else{
					 if(StringUtils.isEmpty(usr.getPassword())){
						 response.sendRedirect("signin.jsp?message="+"A link sent to your email to set your password.");
					 }
				 }
			 }
		}catch(Exception e){
			e.printStackTrace();
		}finally {
			ConnectionUtil.closeConnection(conn);
		}
		
	}

	private void editUserStatus(HttpServletRequest request,HttpServletResponse response) {
		String userId = request.getParameter("user_id");
		String status = request.getParameter("status");
		String emailId =  request.getParameter("emailId");
		
		RequestDispatcher reqDisp = request.getRequestDispatcher("/admin.jsp");
		String insertQuery="UPDATE users SET status = '"+status+"'  where id="+userId;
		try{
			ConnectionUtil.executeQuery(insertQuery);
			String text = "<htm><body style='margin:5px; font-family:Arial, Helvetica, sans-serif; font-size:13px;'>"
					     + "<div style='width:420px; min-height:80px; margin:0 auto;background:#f6fcfd;border:1px solid #d9e9eb;border-radius:5px; padding:10px 15px;'>"
					     + "<p style='line-height:25px; color:#0f4962; text-align:center;'>You are successfully Activated!</p></div></body></html>";
			
			Mailer.sendMail("apps@topspot.ae","Cl0ud@ppz", "apps@topspot.ae",emailId, "Registration activated", text);
			reqDisp.forward(request, response);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}

	private void changePassword(HttpServletRequest request,HttpServletResponse response){
		RequestDispatcher reqDisp = request.getRequestDispatcher("/CPsuccess.jsp");
	//	String userName = request.getParameter("name");
		String password = request.getParameter("password");
		String sessionId = request.getParameter("sessionId");
		String userId=null;
		if(StringUtils.isNotEmpty(sessionId)){
			 userId =sessionId.substring(0, sessionId.lastIndexOf("_"));
		}
		String insertQuery="UPDATE users SET password = '"+ConnectionUtil.encryptMD5(password)+"' , status='pending' where id="+userId;
		try{
			ConnectionUtil.executeQuery(insertQuery);
			reqDisp.forward(request, response);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
}
