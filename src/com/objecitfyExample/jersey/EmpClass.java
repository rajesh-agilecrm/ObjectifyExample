package com.objecitfyExample.jersey;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.POST;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

import com.google.gson.Gson;
import com.google.appengine.api.datastore.QueryResultIterable;
import com.google.appengine.api.datastore.QueryResultIterator;
import com.google.appengine.labs.repackaged.org.json.JSONArray;
import com.google.appengine.labs.repackaged.org.json.JSONException;
import com.google.appengine.labs.repackaged.org.json.JSONObject;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.Ref;
import com.googlecode.objectify.Result;
import com.googlecode.objectify.cmd.Loader;
import com.googlecode.objectify.cmd.Query;
import com.objectifyExample.entities.Employee;
import com.objectifyExample.entities.Register;
@Path("/emp")
public class EmpClass {

	@SuppressWarnings("unchecked")
	@Path("create")
	@POST
	@Produces(MediaType.TEXT_PLAIN)
	public String saveDetails(String jsonString, @Context  HttpServletRequest request){
		try {
			ObjectifyService.ofy().clear();
			
			HttpSession session = request.getSession();
			Long idd = (Long) session.getAttribute("id");
			
			Employee car = new Employee();
			car.register = Ref.create(Key.create(Register.class, idd));
			
			JSONObject jsonObj = new JSONObject(jsonString);
			car.fullname = (String) jsonObj.get("fullname");
			car.email = (String) jsonObj.get("email");
			car.password = (String) jsonObj.get("password");
			car.empid = (String) jsonObj.get("empid");
			car.designation = (String) jsonObj.get("designation");
			car.created_on = new Date();
			
			ObjectifyService.ofy().save().entity(car).now();
			
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "success";
	}
	
	/*public String saveDetails(@FormParam("fullname") String fullname,@FormParam("email") String email, @FormParam("password") String password,@FormParam("empid") String empid,@FormParam("designation") String designation, @Context HttpServletRequest request){
		try{
			ObjectifyService.ofy().clear();
			
			HttpSession session = request.getSession();
			Long idd = (Long) session.getAttribute("id");
			
			Employee car = new Employee();
			car.register = Ref.create(Key.create(Register.class, idd));
			car.fullname = fullname;
			car.email = email;
			car.password = password;
			car.empid = empid;
			car.designation = designation;
			car.created_on = new Date();
			
			ObjectifyService.ofy().save().entity(car).now();
		}catch(Exception e){
			e.printStackTrace();
		}
		return "success";
	}*/
	
	@SuppressWarnings({ "unchecked"})
	@Path("getEmpDetails")
	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public String getEmpDetails(@Context HttpServletRequest request){
		JSONArray jsonArray = new JSONArray();
		List<Employee> fetched =null;
		String json = null;
		try {
			ObjectifyService.ofy().clear();
			ObjectifyService.ofy().cache(false);
			/*HttpSession session = request.getSession();
			Long idd = (Long) session.getAttribute("id");
			Employee car = new Employee();
			car.register = Ref.create(Key.create(Register.class, idd));
			Employee fetched1 = ObjectifyService.ofy().load().entity(car).get();
			Register reg = fetched1.register.get();*/
			//fetched = ObjectifyService.ofy().load().group(Register.class).type(Employee.class).list(); //.offset(Integer.parseInt(param1)).limit(5).list();
			fetched = ObjectifyService.ofy().load().group(Register.class).type(Employee.class).list();
			json = new Gson().toJson(fetched); 
			/*if(fetched.size() > 0){
				 for(Employee entities: fetched){
					 JSONObject obj = new JSONObject();
					 obj.put("fullname", entities.fullname);
					 obj.put("email", entities.email);
					 obj.put("empid", entities.empid);
					 obj.put("designation", entities.designation);
					 obj.put("created_on", entities.created_on);
					 obj.put("created_by", entities.register.getValue().fullname);
					 jsonArray.put(obj);
				 }
			 }*/

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return json; //jsonArray.toString();
	}
	
}
