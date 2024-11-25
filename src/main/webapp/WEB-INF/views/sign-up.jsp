<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<title>Register</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f0f2f5;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
}

.register-container {
	background-color: #fff;
	padding: 30px;
	border-radius: 8px;
	box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	width: 400px;
}

h2 {
	text-align: center;
	color: #333;
	margin-bottom: 20px;
}

label {
	font-weight: bold;
	color: #555;
	margin-top: 10px;
}

.input-container {
	position: relative;
}

input[type="text"], input[type="email"], input[type="password"] {
	width: 100%;
	padding: 12px;
	padding-right: 40px;
	margin: 5px 0 15px;
	box-sizing: border-box;
	border: 1px solid #ccc;
	border-radius: 4px;
	transition: border-color 0.3s;
}

input[type="text"]:focus, input[type="email"]:focus, input[type="password"]:focus
	{
	border-color: #4CAF50;
	box-shadow: 0 0 5px rgba(76, 175, 80, 0.5);
}

.toggle-password {
	position: relative;
	left: 370px;
	top: -50px;
	transform: translateY(-50%);
	cursor: pointer;
	font-size: 18px;
	color: #888;
}

input[type="submit"] {
	width: 100%;
	padding: 12px;
	background-color: #4CAF50;
	color: #fff;
	border: none;
	border-radius: 4px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s, transform 0.3s;
}

input[type="submit"]:hover {
	background-color: #45a049;
	transform: scale(1.02);
}

.error {
	color: red;
	font-size: 14px;
}

a {
	display: block;
	text-align: center;
	margin-top: 10px;
	color: #007BFF;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}
</style>

<script>
	function checkPassword() {
		const password = document.getElementById("password").value;
		const passwordError = document.getElementById("passwordError");

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

	function checkConfirmPassword() {
		const password = document.getElementById("password").value;
		const confirmPassword = document.getElementById("confirmPassword").value;
		const confirmPasswordError = document
				.getElementById("confirmPasswordError");

		if (password !== confirmPassword) {
			confirmPasswordError.innerHTML = "Passwords do not match.";
		} else {
			confirmPasswordError.innerHTML = "";
		}
	}

	function checkNameFields() {
		const firstName = document.getElementById("firstname").value.trim();
		const lastName = document.getElementById("lastname").value.trim();
		const firstNameError = document.getElementById("firstNameError");
		const lastNameError = document.getElementById("lastNameError");

		const nameRegex = /^[a-zA-Z\s]+$/;

		firstNameError.innerHTML = "";
		lastNameError.innerHTML = "";

		if (firstName === "") {
			firstNameError.innerHTML = "First Name is required.";
		} else if (!nameRegex.test(firstName)) {
			firstNameError.innerHTML = "First Name must contain only letters and spaces.";
		}

		if (lastName === "") {
			lastNameError.innerHTML = "Last Name is required.";
		} else if (!nameRegex.test(lastName)) {
			lastNameError.innerHTML = "Last Name must contain only letters and spaces.";
		}

		return firstName !== "" && nameRegex.test(firstName) && lastName !== ""
				&& nameRegex.test(lastName);
	}

	function checkEmailField() {
		const email = document.getElementById("email").value.trim();
		const emailError = document.getElementById("emailError");

		emailError.innerHTML = "";

		if (email === "") {
			emailError.innerHTML = "Email is required.";
		}

		return email !== "";
	}

	function validateForm() {
		const isPasswordValid = checkPassword();
		const areNamesValid = checkNameFields();
		const isEmailValid = checkEmailField();

		return isPasswordValid && areNamesValid && isEmailValid;
	}
	function togglePasswordVisibility() {
		const passwordField = document.getElementById("password");
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
</head>
<body>
	<div class="register-container">
		<h2>Register</h2>

		<form:form action="registerUser" method="post"
			modelAttribute="userObj" onsubmit="return validateForm()">
			<label for="firstname">First Name:</label>
			<form:input path="firstname" id="firstname"
				placeholder="Enter your first name" oninput="checkNameFields()" />
			<form:errors path="firstname" cssClass="error" />
			<span id="firstNameError" class="error"></span>
			<br>
			<br>
			<label for="lastname">Last Name:</label>
			<form:input path="lastname" id="lastname"
				placeholder="Enter your last name" oninput="checkNameFields()" />
			<form:errors path="lastname" cssClass="error" />
			<span id="lastNameError" class="error"></span>
			<br>
			<br>
			<label for="email">Email:</label>
			<form:input path="email" type="email" id="email"
				placeholder="Enter your email" oninput="checkEmailField()" />
			<form:errors path="email" cssClass="error" />
			<span id="emailError" class="error"></span>
			<br>
			<br>
			<label for="password">Password:</label>
			<div class="password-container">
				<form:password path="password" id="password"
					oninput="checkPassword()" />
				<span id="togglePasswordIcon" class="toggle-password"
					onclick="togglePasswordVisibility('password', 'togglePasswordIcon')">👁‍🗨</span>
			</div>
			<form:errors path="password" cssClass="error" />
			<span id="passwordError" class="error"></span>
			<br>
			<br>
			<label for="confirmPassword">Confirm Password:</label>
			<div class="password-container">
				<form:password path="confirmpassword" id="confirmPassword"
					oninput="checkConfirmPassword()" />
				
			</div>
			<form:errors path="confirmpassword" cssClass="error" />
			<span id="confirmPasswordError" class="error"></span>
			<br>
			<br>
			<input type="submit" value="Register" />
			<a href="/ChefsMarket/login">Already have an account? Login here</a>
		</form:form>
	</div>
</body>
</html>
