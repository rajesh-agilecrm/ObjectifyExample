<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Home</title>
		<link rel="stylesheet" type="text/css" href="stylesheets/bootstrap.min.css" />
		<script src="js/jquery.min.js"></script>
	    <script type="text/javascript" src="js/bootstrap.min.js"></script>
	    <script type="text/javascript" src="js/underscore.js"></script>
	    <script type="text/javascript" src="js/backbone.js"></script>
	    <script type="text/javascript" src="js/handlebars-v4.0.5.js"></script>
	</head>
	<body>
		<%
			String user = (String)session.getAttribute("Fullname");
		%>
		<nav role="navigation" class="navbar navbar-default navbar-fixed-top">
			<div class="container">
				<div class="navbar-header">
					<button type="button" data-target="#navbarCollapse" data-toggle="collapse" class="navbar-toggle">
						<span class="sr-only">Toggle Navigation</span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a href="#" class="navbar-brand"></a>
				</div>
				<div id="navbarCollapse" class="collapse navbar-collapse">
					<ul class="nav navbar-nav">
						<li class="active"><a href="/homepage.jsp">Home</a></li>
                		<li><a href="/profile.jsp">Profile</a></li>
                		<li><a href="/backbone.jsp">Backbone Example</a></li>
                		<li class="dropdown">
					        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Masters
					        <span class="caret"></span></a>
					        <ul class="dropdown-menu">
					          <li><a href="/createEmp.jsp">Employee</a></li>
					        </ul>
				       </li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li><a>Hi, <%= user %></a></li>
		                <li><a href="/logout">Logout</a></li>
		            </ul>
				</div>
			</div>
		</nav>