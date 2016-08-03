<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.objectifyExample.entities.Register" %>
<%@ page import="com.googlecode.objectify.ObjectifyService" %>
<%@ page import="com.googlecode.objectify.Key" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

	<%@ include file="header.jsp" %>
		<div class="container">
			<div class="table-responsive" style="width: 100%;margin-top: 60px;">
				<table class="table">
				    <thead>
					    <tr>
					      <th>#</th>
					      <th>User Name</th>
					      <th>Full Name</th>
					      <th>Mobile Number</th>
					      <th>Gender</th>
					      <th>Date of Birth</th>
					      <th>Edit</th>
					      <th>Delete</th>
					    </tr>
					</thead>
					<tbody>
						<%
							Register register;
							
							List<Register> authenticate = ObjectifyService.ofy().load().type(Register.class).list();
							if(authenticate.size() > 0){
								for(Register entities: authenticate){
									%>
										<tr>
									      <th scope="row"><%=entities.id %></th>
									      <td id="<%=entities.id%>email"><%=entities.email %></td>
									      <td id="<%=entities.id%>fname"><%=entities.fullname %></td>
									      <td id="<%=entities.id%>mno"><%=entities.mobileno %></td>
									      <td id="<%=entities.id%>gen"><%=entities.gender %></td>
									      <td id="<%=entities.id%>dob"><%=entities.dob%></td>
									      <td><a href="javascript:editEntry(<%=entities.id %>)" id="<%=entities.id%>edit">Edit</a></td>
									      <td><a href="javascript:deleteEntry(<%=entities.id %>)" id="<%=entities.id%>delete">Delete</a></td>
									    </tr>
									<%
								}
							}else{
								
							}
						%>
					</tbody>
				</table>
			</div>
		</div>
		<script type="text/javascript">
			function editEntry(id){
				$("#"+id+"edit").text("Save");
				$("#"+id+"edit").attr("href","javascript:saveEntry('"+id+"')");
				$("#"+id+"email").attr("contenteditable",true);
				$("#"+id+"fname").attr("contenteditable",true);
				$("#"+id+"mno").attr("contenteditable",true);
				$("#"+id+"gen").attr("contenteditable",true);
				$("#"+id+"dob").attr("contenteditable",true);
			}
			function saveEntry(id){
				var id = id;
				$("#"+id+"edit").text("Edit");
				$("#"+id+"edit").attr("href","javascript:editEntry('"+id+"')");
				var  email = $("#"+id+"email").text();
				var  fname = $("#"+id+"fname").text();
				var  mno = $("#"+id+"mno").text();
				var  gen = $("#"+id+"gen").text();
				var  dob = $("#"+id+"dob").text();
				var request = $.ajax({
				  url: "/updateUser",
				  method: "POST",
				  data: { id : id, email:email, fullname : fname, mno: mno, gen: gen, dob: dob},
				  dataType: "html"
				});
				request.done(function( msg ) {
					window.location.href="/homepage.jsp"
				});
				request.fail(function( jqXHR, textStatus ) {
				  alert( "Request failed: " + textStatus );
				});
			}
			function deleteEntry(id){
				var id = id;
				var request = $.ajax({
				  url: "/deleteUser",
				  method: "POST",
				  data: { id : id},
				  dataType: "html"
				});
				request.done(function( msg ) {
					window.location.href="/homepage.jsp"
				});
				request.fail(function( jqXHR, textStatus ) {
				  alert( "Request failed: " + textStatus );
				});	
			}
		
		</script>
	</body>
</html>