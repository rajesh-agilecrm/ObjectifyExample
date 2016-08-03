package com.objecitfyExample.jersey;
import javax.ws.rs.Path;
import javax.ws.rs.GET;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.google.appengine.labs.repackaged.org.json.JSONArray;
import com.google.appengine.labs.repackaged.org.json.JSONException;
import com.google.appengine.labs.repackaged.org.json.JSONObject;
import com.googlecode.objectify.ObjectifyService;
import com.googlecode.objectify.cmd.Query;
import com.objectifyExample.entities.Register;

import java.util.*;
@Path("/hello")
public class RestClass {
	
	/*@GET
	@Produces(MediaType.TEXT_PLAIN)
	public String sayPlainTextHello() {
	    return "Hello Jersey";
	}*/
	
	/*@GET
	@Produces(MediaType.TEXT_XML)
	public String sayXMLHello() {
		return "<?xml version=\"1.0\"?>" + "<hello> Hello Jersey" + "</hello>";
	}*/

	@GET
	@Produces(MediaType.APPLICATION_JSON)
	public String sayJsonHello(){
		//JSONObject responseDetailsJson = new JSONObject();
	    JSONArray jsonArray = new JSONArray();
		 try {
			 List<Register> authenticate = ObjectifyService.ofy().load().type(Register.class).list();
			 if(authenticate.size() > 0){
				 for(Register entities: authenticate){
					 JSONObject obj = new JSONObject();
					 obj.put("fullname", entities.fullname);
					 obj.put("email", entities.email);
					 obj.put("mobilenumber", entities.mobileno);
					 obj.put("gender", entities.gender);
					 obj.put("dob", entities.dob);
					 jsonArray.put(obj);
				 }
			 }
			 //responseDetailsJson.put("Data", jsonArray);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return jsonArray.toString();
	}
	
}
