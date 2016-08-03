package com.objectifyExample.controllers;


import java.io.IOException;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.cmd.Query;
import com.objectifyExample.entities.Register;

/**
 * Servlet implementation class AuthenticationServlet
 */
public class AuthenticationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AuthenticationServlet() {
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
			String username = request.getParameter("username");
			String password = request.getParameter("pwd");
			HttpSession session = null;
			//List<Register> authenticate = ObjectifyService.ofy().load().type(Register.class).list();
			
			List<Register> authenticate = ObjectifyService.ofy().load().type(Register.class).filter("email", username).filter("password", password).list();
			System.out.println(authenticate.size()+"===========");
			
			if(authenticate.size() > 0){
				session = request.getSession();
				session.setAttribute("id", authenticate.get(0).id);
				session.setAttribute("Fullname", authenticate.get(0).fullname);
				response.sendRedirect("/homepage.jsp");
			}else{
				response.sendRedirect("/landingpage.jsp?email="+username+"&error=invalid username or password");
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}

}
