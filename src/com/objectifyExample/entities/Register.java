package com.objectifyExample.entities;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;

@Entity
public class Register {
	
	@Id
	public Long id;
	
	@Index public String email;
	@Index public String password;
	public String fullname;
	public String mobileno;
	public String gender;
	public String dob;
	
	public Register(){}
	
	public Register(String fullname, String mobileno, String gender, String dob, String email,String password){
		this.fullname = fullname;
		this.mobileno = mobileno;
		this.gender = gender;
		this.dob = dob;
		this.email = email;
		this.password = password;
	}
}
