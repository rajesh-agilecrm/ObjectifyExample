package com.objectifyExample.controllers;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.Ref;
import com.googlecode.objectify.cmd.Query;
import com.objectifyExample.entities.Register;

public class UpdateDetailsServlet extends HttpServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateDetailsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try{
			String id = request.getParameter("id");
			String fullname = request.getParameter("fullname");
			String email = request.getParameter("email");
			String mno = request.getParameter("mno");
			String gen = request.getParameter("gen");
			String dob = request.getParameter("dob");
			
			Long idd = Long.parseLong(id);
			Register thing = ObjectifyService.ofy().load().type(Register.class).id(idd).get();
			thing.email = email;
			thing.fullname = fullname;
			thing.mobileno = mno;
			thing.gender = gen;
			thing.dob = dob;
	        ObjectifyService.ofy().save().entity(thing).now();
	        
	        response.sendRedirect("/homepage.jsp");
	        //ObjectifyService.ofy().clear();
		}catch(Exception e){
			e.printStackTrace();
		}
	}

}

