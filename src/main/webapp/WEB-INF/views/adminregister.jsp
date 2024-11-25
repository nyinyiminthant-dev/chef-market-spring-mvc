<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    if (session.getAttribute("adminEmail") == null) {
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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/styles.css">
    <script defer src="${pageContext.request.contextPath}/resources/js/adminRegister.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <style>
        /* Positioning the eye icon */
        .toggle-password {
            position: absolute;
            right: 25px;
            top: 41%;
            transform: translateY(-50%);
            cursor: pointer;
            font-size: 20px;
        }

        .input-control {
            position: relative;
        }

        #password {
            padding-right: 30px; /* Space for the eye icon */
        }
    </style>
</head>
<body>
    <script>
        function togglePasswordVisibility() {
            const passwordField = document.getElementById("password");
            const toggleIcon = document.getElementById("toggleIcon");

            if (passwordField.type === "password") {
                passwordField.type = "text";
                toggleIcon.textContent = "👁️";
            } else {
                passwordField.type = "password";
                toggleIcon.textContent = "👁️‍🗨️";
            }
        }
    </script>


<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="goowner">Add Admin</a>
        
        
        <ul class="navbar-nav ms-auto">
            <li class="nav-item">
                <a class="nav-link" href="goowner">

                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house-fill" viewBox="0 0 16 16">
                        <path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293z"/>
                        <path d="m8 3.293 6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5V9.293z"/>
                    </svg>
                    Home
                </a>
            </li>
              
        </ul>
    </div>
</nav>
    <div class="container">
        <form id="form" action="${pageContext.request.contextPath}/admin_register" method="post">
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
                <label for="firstname">First name</label>
                <input id="firstname" name="first_name" type="text" value="${admin.first_name != null ? admin.first_name : ''}">
                <div class="error">${errors.first_name != null ? errors.first_name : ''}</div>
            </div>

            <!-- Last Name Field -->
            <div class="input-control">
                <label for="lastname">Last name</label>
                <input id="lastname" name="last_name" type="text" value="${admin.last_name != null ? admin.last_name : ''}">
                <div class="error">${errors.last_name != null ? errors.last_name : ''}</div>
            </div>

            <!-- Email Field -->
            <div class="input-control">
                <label for="email">Email</label>
                <input id="email" name="email" type="text" value="${admin.email != null ? admin.email : ''}">
                <div class="error">${errors.email != null ? errors.email : ''}</div>
            </div>

            <!-- Password Field -->
            <div class="input-control">
                <label for="password">Password</label>
                <span id="toggleIcon" class="toggle-password" onclick="togglePasswordVisibility()">👁️‍🗨️</span>
                <input id="password" name="password" type="password">
                <div class="error">${errors.password != null ? errors.password : ''}</div>
            </div>

            <!-- Confirm Password Field -->
            <div class="input-control">
                <label for="password2">Confirm Password</label>
                <input id="password2" name="password2" type="password">
                <div class="error">${errors.password2 != null ? errors.password2 : ''}</div>
            </div>

            <!-- Role Field -->
            <div class="input-control">
                <label for="role">Role</label>
                <select id="role" name="role">
                    <option value="" disabled selected>Select Role</option>
                    <option value="Sell-Admin" ${admin.role == 'sell-Admin' ? 'selected' : ''}>Sell-Admin</option>
                    <option value="Product-Admin" ${admin.role == 'product-Admin' ? 'selected' : ''}>Product-Admin</option>
                </select>
                <div class="error">${errors.role != null ? errors.role : ''}</div>
            </div>

            <button type="submit">Sign Up</button>
        </form>
    </div>
</body>
</html>
