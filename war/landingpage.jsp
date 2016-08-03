<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Login/Signup</title>
		<link rel="stylesheet" type="text/css" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" />
		<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
	    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	    <style type="text/css">
	    	.row{
	    		margin-top:10px;
	    	}
	    	#signup{
	    		display:none;
	    	}
	    	a{
	    		cursor:pointer;
	    	}
	    </style>
	</head>
	<body>
	<%
		String email = request.getParameter("email");
		request.setAttribute("email", email);
		String errormessage = (String)request.getParameter("error");
		if(errormessage != null){}else{
			errormessage = "";
		}
		if(email != null){}else{
			email = "";
		}
	
	%>
		<div class="col-md-4 col-md-offset-4" id="signin">
			<form method="POST" action="/login">
				<div class="error-class" style="color:red"><%=errormessage %></div>
				<div class="form-group">
					<label>Username:</label>
					<input type="email" class="form-control" name="username" placeholder="Enter username" value="<%=email %>" required />
				</div>
				<div class="form-group">
					<label>Password:</label>
					<input type="password" class="form-control" name="pwd" placeholder="Enter password" required />
				</div>
				<div class="form-group" style="text-align:center">
					<input type="submit" value="submit" class="btn btn-success" />
					<a href="javascript:changediv()">signup</a>
				</div>
			</form>
		</div>
		<div class="col-md-4 col-md-offset-4" id="signup">
			<form method="POST" action="/signup">
				<div class="form-group">
					<label>Email:</label>
					<input type="email" class="form-control" name="email" placeholder="Enter email" required />
				</div>
				<div class="form-group">
					<label>Password:</label>
					<input type="password" class="form-control" name="password" placeholder="Enter password" required />
				</div>
				<div class="form-group">
					<label>Full Name:</label>
					<input type="text" class="form-control" name="fullname" placeholder="Enter full name" required />
				</div>
				<div class="form-group">
					<label>Mobile No:</label>
					<input type="text" class="form-control" name="mobileno" placeholder="Enter mobile number" required />
				</div>
				<div class="form-group">
					<label>Gender:</label>
					<input type="text" class="form-control" name="gender" placeholder="Enter gender" required />
				</div>
				<div class="form-group">
					<label>Date Of Birth:</label>
					<input type="text" class="form-control" name="dob" placeholder="Enter date of birth" required />
				</div>
				<div class="form-group" style="text-align:center">
					<input type="submit" value="submit" class="btn btn-success" />
					<a href="javascript:changediv()">signin</a>
				</div>
			</form>
		</div>
		
		<script type="text/javascript">
			function changediv(){
				if($("#signin").is(":visible") == true){
					$("#signin").hide();
					$("#signup").show();
				}else{
					$("#signup").hide();
					$("#signin").show();
				}
				
			}
		
		</script>
	</body>
</html>