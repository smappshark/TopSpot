package com.topspot.sessionvalidation;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


/**
 * Servlet Filter implementation class AuthenticationFilter
 */
public class AuthenticationFilter implements Filter {

    /**
     * Default constructor. 
     */
    public AuthenticationFilter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		  HttpServletRequest req = (HttpServletRequest) request;
	        HttpServletResponse res = (HttpServletResponse) response;
	         Boolean isValidUrl = false;
	        String uri = req.getRequestURI();
	         System.out.println("uri - "+uri);
	         System.out.println("uri signin - "+uri.startsWith("/signin.jsp"));
	         System.out.println("uri registrationServlet- "+uri.startsWith("/registrationServlet"));
	        HttpSession session = req.getSession(false);
	        
	        if(uri.startsWith("/signin.jsp"))
	        	isValidUrl = true;
	        if(uri.startsWith("/registrationServlet"))
	        	isValidUrl = true;
	        if(uri.startsWith("/register.jsp"))
	        	isValidUrl = true;
	        if(uri.startsWith("/success.jsp"))
	        	isValidUrl = true;
	        if(uri.startsWith("/changePass.jsp"))
	        	isValidUrl = true;
	        
	       
	        if (!isValidUrl) {//excluding filters for signin ,registrationServlet 
	        	 System.out.println("if");
		        if(session == null){//check if session exists or not
		            res.sendRedirect("signin.jsp");
		        }else{
		            	Boolean isUserLoogedIn = (session.getAttribute("isUserLoogedIn") == null) ? false : true;
		            	 System.out.println("isUserLoogedIn = "+ isUserLoogedIn);
		        		// pass the request along the filter chain
		            	if(isUserLoogedIn){//check whether user logged in already
		            		System.out.println("inner if");
		            		chain.doFilter(request, response);
		            	}else{
		            		System.out.println("inner else");
		            		res.sendRedirect("signin.jsp");
		            	}
		        }
	        }else{
	        	System.out.println("else");
	        	//if user try to access signin page when session already exists
	        	 if(session != null){ //check if session exists
	        		 System.out.println("if session exists");
	        		 Boolean isUserLoogedIn = (session.getAttribute("isUserLoogedIn") == null) ? false : true;
	        		 System.out.println("isUserLoogedIn - "+ isUserLoogedIn);
	        		 //
	        		 if(isUserLoogedIn)//check whether user logged in already
	        			 res.sendRedirect("index.jsp");
	        		 else
	        			 chain.doFilter(request, response);
	        	 }else{
	        		 chain.doFilter(request, response);
	        	 }
	        }
	         
	         
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
