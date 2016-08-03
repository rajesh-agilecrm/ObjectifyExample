package com.objectifyExample.controllers;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import java.io.*;

import com.googlecode.objectify.ObjectifyService;
import com.objectifyExample.entities.Register;
public class RegistrationServlet extends HttpServlet{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2336593535412506190L;
	
	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException{
		try{
			Register register;
			
			String fullname = req.getParameter("fullname");
			String mobileno = req.getParameter("mobileno");
			String gender = req.getParameter("gender");
			String dob = req.getParameter("dob");
			String email = req.getParameter("email");
			String password = req.getParameter("password");
			register = new Register(fullname, mobileno, gender, dob, email, password);
			
			ObjectifyService.ofy().save().entity(register).now();
			
			res.sendRedirect("/landingpage.jsp?email="+email);
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}

}
