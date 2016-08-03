package com.objectifyExample.entities;
import java.util.Date;

import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Load;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.Ref;
@Entity
public class Employee{
	@Id
	public Long id;
	
	public String fullname;
	public String email;
	public String password;
	public String empid;
	public String designation;
	public Date created_on;
	@Load(Register.class) 
	public Ref<Register> register;   // Register is an @Entity
    
    public Employee(){}
    
    public Employee(String fullname, String email, String password, String empid, String designation, Date date, Ref<Register> register){
    	this.fullname = fullname;
    	this.email = email;
    	this.password = password;
    	this.empid = empid;
    	this.designation = designation;
    	this.created_on = date;
    	this.register= register;
    }
}
