package com.objectifyExample.entities;
import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
import com.googlecode.objectify.annotation.Index;
import com.googlecode.objectify.annotation.Parent;

@Entity
public class Profile {

	@Id
	public Long id;
	
	@Index public String address;
	@Index public String skypeid;
	@Parent Key<Register> register;
	
	public Profile(){}
	
	public Profile(String address, String skypeid, Key<Register> register){
		this.address = address;
		this.skypeid = skypeid;
		this.register = register;
	}
}
