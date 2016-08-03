package com.objectifyExample.controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -7467746071153524064L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		try{
		HttpSession session = request.getSession(false);
		if(session != null){
			session.invalidate();
		}
		response.setContentType("text/html");
		response.sendRedirect("/");
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
