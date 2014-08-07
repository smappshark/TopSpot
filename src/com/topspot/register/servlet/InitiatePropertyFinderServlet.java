package com.topspot.register.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.topspot.ProcessPropertyFinder;

/**
 * Servlet implementation class InitiatePropertyFinderServlet
 */

public class InitiatePropertyFinderServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
    
    public InitiatePropertyFinderServlet() 
    {
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			ProcessPropertyFinder pPf = new ProcessPropertyFinder();
			pPf.process();
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub		
	}
}
