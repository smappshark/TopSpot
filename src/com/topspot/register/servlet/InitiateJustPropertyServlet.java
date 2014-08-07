package com.topspot.register.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.topspot.ProcessJustProperty;

/**
 * Servlet implementation class InitiateJustPropertyServlet
 */

public class InitiateJustPropertyServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
    
    public InitiateJustPropertyServlet() 
    {
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			ProcessJustProperty pJP = new ProcessJustProperty();
			pJP.process();
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
