<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page session="true" %>
<%
    if (session.getAttribute("adminEmail") == null) {
        // Redirect to login page if session does not contain adminEmail
        response.sendRedirect(request.getContextPath() + "/productadmin");
        return;
    }
%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Admin</title>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/styles.css">
<script defer
	src="${pageContext.request.contextPath}/resources/js/register.js"></script>
</head>
<body>
	<div class="container">
		<form id="form" action="${pageContext.request.contextPath}/register"
			method="post">
			<h1>Registration</h1>

			<!-- Success Message -->
			<c:if test="${not empty successMessage}">
				<div class="success-message">${successMessage}</div>
			</c:if>

			<!-- Error Message -->
			<c:if test="${not empty errorMessage}">
				<div class="error-message">${errorMessage}</div>
			</c:if>

			<!-- First Name Field -->
			<div class="input-control">
				<label for="firstname">First name</label> <input id="firstname"
					name="first_name" type="text"
					value="${admin.first_name != null ? admin.first_name : ''}">
				<div class="error">${errors.first_name != null ? errors.first_name : ''}</div>
			</div>

			<!-- Last Name Field -->
			<div class="input-control">
				<label for="lastname">Last name</label> <input id="lastname"
					name="last_name" type="text"
					value="${admin.last_name != null ? admin.last_name : ''}">
				<div class="error">${errors.last_name != null ? errors.last_name : ''}</div>
			</div>

			<!-- Email Field -->
			<div class="input-control">
				<label for="email">Email</label> <input id="email" name="email"
					type="text" value="${admin.email != null ? admin.email : ''}">
				<div class="error">${errors.email != null ? errors.email : ''}</div>
			</div>


			<!-- Password Field -->
			<div class="input-control">
				<label for="password">Password</label> <input id="password"
					name="password" type="password">
				<div class="error">${errors.password != null ? errors.password : ''}</div>
			</div>

			<!-- Confirm Password Field -->
			<div class="input-control">
				<label for="password2">Confirm Password</label> <input
					id="password2" name="password2" type="password">
				<div class="error">${errors.password2 != null ? errors.password2 : ''}</div>
			</div>
			<!-- Role Field -->
			<div class="input-control">
				<label for="role">Role</label> <select id="role" name="role">
					<option value="" disabled selected>Select Role</option>
					<option value="Sell-Admin"
						${admin.role == 'sell-Admin' ? 'selected' : ''}>Sell-Admin</option>
					<option value="Product-Admin"
						${admin.role == 'product-Admin' ? 'selected' : ''}>Product-Admin</option>
				</select>
				<div class="error">${errors.role != null ? errors.role : ''}</div>
			</div>




			<button type="submit">Sign Up</button>
			<!-- Already have an account link -->
			<div class="login-link">
				<p>
					Already have an account? <a
						href="${pageContext.request.contextPath}/adminlogin">Login
						here</a>
				</p>
			</div>

		</form>


	</div>
</body>
</html>