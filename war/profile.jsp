<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.objectifyExample.entities.Register" %>
<%@ page import="com.objectifyExample.entities.Profile" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%@ page import="com.googlecode.objectify.Key" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreServiceFactory" %>
<%@ page import="com.google.appengine.api.blobstore.BlobstoreService" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    BlobstoreService blobstoreService = BlobstoreServiceFactory.getBlobstoreService();
%>
		<%@ include file="header.jsp" %>
		<%
			Long id = (Long)session.getAttribute("id");
			Key<Register> theBook = Key.create(Register.class, id);
			List<Profile> greetings = ObjectifyService.ofy().load().type(Profile.class).ancestor(theBook).list();
			if(greetings.size() > 0){
				for(Profile entities: greetings){
					 %>
					 	<div class="container">
					 		<div class="row" style="margin-top:60px">
						 		<div class="col-md-6">Address</div>
						 		<div class="col-md-6"><%=entities.address %></div>
						 		<div class="col-md-6">Skype Id</div>
						 		<div class="col-md-6"><%=entities.skypeid %></div>
					 		</div>
					 	</div>	
					 <%
				}
			}else{
				%>
					<div class="container">
						<div class="row">
							<div class="col-md-4 col-md-offset-4" style="margin-top:60px;">
								<form method="POST" action="<%= blobstoreService.createUploadUrl("/saveProfile") %>" id="profileform"enctype="multipart/form-data">
									<div class="form-group">
										<label>Address</label>
										<textarea class="form-control" name="address" required></textarea>
									</div>
									<div class="form-group">
										<label>Skype Id</label>
										<input type="text" class="form-control" name="skypeid" placeholder="Enter skype id" required />
									</div>
									<div class="form-group">
										<label>Upload Profile Pic</label>
										<input type="file" name="file" />
									</div>
									<div class="form-group" style="text-align:center">
										<input type="submit" class="btn btn-success" value="submit" /> or
										<a href="javascript:restForm()" class="btn btn-default">Reset</a>
									</div>
								</form>
							</div>
						</div>
					</div>
				<%
			}
		%>
		
		
		<script type="text/javascript">
			function restForm(){
				document.getElementById("profileform").reset();
			}
		</script>
	</body>
</html>