package com.topspot.register.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.topspot.ProcessJustRentals;

/**
 * Servlet implementation class InitiateJustRentalsServlet
 */

public class InitiateJustRentalsServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
    
    public InitiateJustRentalsServlet() 
    {
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			ProcessJustRentals pJr = new ProcessJustRentals();
			pJr.process();
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
