	<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
<!DOCTYPE html>
<html lang="en">


<!-- Mirrored from themes.pixelstrap.net/zomo/landing/backend/login.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 10 Oct 2024 10:17:13 GMT -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description"
	content="Cuba admin is super flexible, powerful, clean &amp; modern responsive bootstrap 5 admin template with unlimited possibilities.">
<meta name="keywords"
	content="admin template, Cuba admin template, dashboard template, flat admin template, responsive admin template, web app">
<meta name="author" content="pixelstrap">
<link rel="icon" href="assets/images/favicon.png" type="image/x-icon">
<link rel="shortcut icon"
	href="${pageContext.request.contextPath}/resources/assets/images/favicon.png"
	type="image/x-icon">
<title>Chef's Market - log In</title>

<!-- Google font-->
<link rel="preconnect" href="https://fonts.googleapis.com/">
<link rel="preconnect" href="https://fonts.gstatic.com/" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&amp;display=swap"
	rel="stylesheet">
<!-- Bootstrap css -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/css/vendors/bootstrap.css">

<!-- remixicon css -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/css/remixicon.css">

<!-- App css -->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/assets/css/style.css">

<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>




        .error {
            color: red;
        }
        .password-container {
            position: relative;
            display: inline-block;
        }
        .toggle-password {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
        }
        
        
        .adminlogin {
        position: absolute;
        right: 10px;
        top: 10px;
        width: 160px;
        background-color: #eee;
        }
        
        .login{
        transition: .5s;
        }
        .login:hover {
        
          background-color: #ddd;
        }
        
    </style>
    <script>
        function checkEmailField() {
            const email = document.getElementById("email").value.trim();
            const emailError = document.getElementById("emailError");

            emailError.innerHTML = "";

            if (email === "") {
                emailError.innerHTML = "Email is required.";
                return false;
            }

            return true;
        }

        function checkPasswordField() {
            const password = document.getElementById("password").value.trim();
            const passwordError = document.getElementById("passwordError");

            passwordError.innerHTML = "";

            if (password === "") {
                passwordError.innerHTML = "Password is required.";
                return false;
            }

            return true;
        }

        function validateForm() {
            const isEmailValid = checkEmailField();
            const isPasswordValid = checkPasswordField();
            return isEmailValid && isPasswordValid;
        }

        function togglePasswordVisibility() {
            const passwordField = document.getElementById("password");
            const toggleIcon = document.getElementById("toggleIcon");

            if (passwordField.type === "password") {
                passwordField.type = "text";
                toggleIcon.textContent = "👁️"; // Icon for visibility
            } else {
                passwordField.type = "password";
                toggleIcon.textContent = "👁️‍🗨️"; // Icon for hidden
            }
        }
    </script>
</head>

<body>

<c:if test="${not empty successMessage}">
    <script>
        Swal.fire({
            icon: 'success',
            title: 'Success!',
            text: '${successMessage}',
            showConfirmButton: false,
            timer: 2000,
            timerProgressBar: true,
            
        });
    </script>
</c:if>



	<!-- login section start -->
	<section class="log-in-section section-b-space">
		<div class="adcontainer">
			<a href="productadmin"> <input type="submit" value="Admin Sign-In"class="adminlogin"></a> 
			
			
			
			
		</div>

		<div class="container w-100">
			<div class="row">

				<div class="col-xl-5 col-lg-6 me-auto">
					<div class="log-in-box">
						<div class="log-in-title">
							<h3>Welcome To Chef's Market</h3>
							<h5>Log In Your Account</h5>
						</div>

						<div class="input-box">
							
    <form:form action="doLogin" class="row g-3" method="post" modelAttribute="userObj" onsubmit="return validateForm()">
     <c:if test="${not empty error}">
        <div class="alert alert-danger" role="alert">
            ${error}
        </div>
    </c:if>
        <!-- Email field -->
        <div class="col-12">
            <label class="col-form-label pt-0">Your Email</label>
            <div class="form-floating theme-form-floating log-in-form">
                <form:input path="email" id="email" type="email"/>       
                <form:errors path="email" cssClass="error"/>
                <span id="emailError" class="error"></span> 
            </div>
        </div>
        <!-- Password field -->
        <div class="col-12">
            <label class="col-form-label pt-0">Your Password</label>
            <div class="form-floating theme-form-floating log-in-form">
                <form:password path="password" id="password"/>
                <span id="toggleIcon" class="toggle-password" onclick="togglePasswordVisibility()">👁️‍🗨️</span>
            </div>
            <form:errors path="password" cssClass="error"/>
            <span id="passwordError" class="error"></span> 
        </div>
        <div class="col-12">
            <input type="submit" class="login" value="Login"/>
        </div>
    </form:form>
						</div>


						<div>
							<!-- <h6 class="text-center mt-3">
								Don't have account? <a href="register.jsp"
									class="font-primary f-w-600">Create Account</a>
							</h6> -->
							<div class="col-12">
                  <div class="forgot-box">
                    <a href="forgot-password" class="forgot-password">Forgot
                      Password?</a>
                  </div>
                </div>
							
							<span>Don't have an account? <a href="/ChefsMarket/register">Register here</a></span>
							<br> <br>
							<a href="${pageContext.request.contextPath}/" style="margin-left: 20px; text-decoration: none;">Back</a>
										
						</div>

					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- login section end -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>






<!-- Error Alert -->
<c:if test="${not empty error}">
    <script>
        Swal.fire({
            icon: 'error',
            title: 'Error!',
            text: '${error}',
            showConfirmButton: true, 
            
        });
    </script>
</c:if>
</body>


<!-- Mirrored from themes.pixelstrap.net/zomo/landing/backend/login.html by HTTrack Website Copier/3.x [XR&CO'2014], Thu, 10 Oct 2024 10:17:14 GMT -->
</html>