<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
    <title>Change Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"/>
    <script>
        // JavaScript function to check if passwords match
       function checkConfirmPassword() {
		const password = document.getElementById("newPassword").value;
		const confirmPassword = document.getElementById("confirmPassword").value;
		const confirmPasswordError = document
				.getElementById("confirmPasswordError");

		if (password !== confirmPassword) {
			confirmPasswordError.innerHTML = "Passwords do not match.";
		} else {
			confirmPasswordError.innerHTML = "";
		}
	}
        
        function checkPassword() {
    		const password = document.getElementById("newPassword").value;
    		const passwordError = document.getElementById("passerror");

    		const lengthCheck = password.length >= 8;
    		const numberCheck = /[0-9]/.test(password);
    		const specialCharCheck = /[!@#$%^&*]/.test(password);
    		const upperCaseCheck = /[A-Z]/.test(password);
    		const lowerCaseCheck = /[a-z]/.test(password);

    		passwordError.innerHTML = "";

    		if (!lengthCheck) {
    			passwordError.innerHTML += "Password must be at least 8 characters long.<br>";
    		}
    		if (!upperCaseCheck) {
    			passwordError.innerHTML += "Password must contain at least one uppercase letter.<br>";
    		}
    		if (!lowerCaseCheck) {
    			passwordError.innerHTML += "Password must contain at least one lowercase letter.<br>";
    		}
    		if (!numberCheck) {
    			passwordError.innerHTML += "Password must contain at least one number.<br>";
    		}
    		if (!specialCharCheck) {
    			passwordError.innerHTML += "Password must contain at least one special character.<br>";
    		}

    		return lengthCheck && upperCaseCheck && lowerCaseCheck && numberCheck
    				&& specialCharCheck;
    	}
        
        
        function togglePasswordVisibility() {
    		const passwordField = document.getElementById("newPassword");
    		const toggleIcon = document.getElementById("toggleIcon");

    		if (passwordField.type === "password") {
    			passwordField.type = "text";
    			 toggleIcon.textContent = "👁️";  // Icon for visibility
    		} else {
    			passwordField.type = "password";
    			toggleIcon.textContent = "👁️‍🗨️"; // Icon for hidden
    		}
    	}
    </script>
    
    <style type="text/css">
    
    .error{
     color: red;
    }
    
    
    .toggle-password{
         position: absolute;
         right:150px;
         top:130px;    
    }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h2>Change Password</h2>
        <form action="change-password" method="post" onsubmit="return validatePassword()">
            <input type="hidden" name="email" value="${email}" />
            
            <div class="mb-3">
                <label for="newPassword" class="form-label">Enter new password:</label>
                <input type="password" class="form-control" id="newPassword" name="newPassword" oninput="checkPassword()" required>
                <span id="togglePasswordIcon" class="toggle-password"
					onclick="togglePasswordVisibility('newPassword', 'togglePasswordIcon')">👁‍🗨</span>
                <span id="passerror" class="error"></span>
            </div>

            <div class="mb-3">
                <label for="confirmPassword" class="form-label">Confirm password:</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" oninput="checkConfirmPassword()"  required>
                 <span id="confirmPasswordError" class="error"></span>
            </div>
            

            <button type="submit" class="btn btn-primary">Change Password</button>
        </form>

        <c:if test="${not empty error}">
            <div class="alert alert-danger mt-3">
                ${error}
            </div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="alert alert-success mt-3">
                ${message}
            </div>
        </c:if>
    </div>
</body>
</html>
