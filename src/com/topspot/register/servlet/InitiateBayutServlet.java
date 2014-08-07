package com.topspot.register.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.topspot.ProcessBayut;

/**
 * Servlet implementation class ActionServlet
 */

public class InitiateBayutServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
    
    public InitiateBayutServlet() 
    {
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try{
			ProcessBayut pb = new ProcessBayut();
			pb.process();
			
		}catch(Exception e)
			{
				e.printStackTrace();
			}
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		// TODO Auto-generated method stub		
	}
}
