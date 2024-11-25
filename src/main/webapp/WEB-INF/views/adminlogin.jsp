<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Login</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom CSS for background, blur, and styling -->
    <style>
        body {
            background-image: url('${pageContext.request.contextPath}/resources/img/adbg.jpg'); /* Replace with your image URL */
            background-size: cover;
            background-position: center;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            position: relative;
            font-family: 'Roboto', sans-serif;
        }

        /* Apply the blur to the entire background */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: inherit;
            filter: blur(8px); /* Adjust the blur intensity */
            z-index: -1;
        }

        .form-container {
            background-color: rgba(255, 255, 255, 0.9); /* Semi-transparent white background */
            padding: 40px;
            border-radius: 15px;
            width: 100%;
            height: 400px;
            max-width: 400px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            position: relative;
            z-index: 1;
            animation: fadeIn 1s ease-in-out;
        }

        h1 {
            font-size: 2rem;
            color: #007bff;
            text-align: center;
            margin-bottom: 20px;
            font-weight: bold;
        }

        .form-control {
            border-radius: 30px;
            padding: 10px 20px;
            margin-bottom: 15px;
        }

        .btn-primary {
            width: 100%;
            padding: 10px;
            border-radius: 30px;
            background-color: #007bff;
            border: none;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            transform: scale(1.05);
        }

        .form-text {
            text-align: center;
            color: black;
        }

        /* Fade-in animation */
        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Error styling */
        .error {
            color: red;
            text-align: center;
        }

        /* Responsive design for smaller devices */
        @media screen and (max-width: 768px) {
            .form-container {
                padding: 20px;
                width: 90%;
            }

            h1 {
                font-size: 1.5rem;
            }

            .form-control {
                padding: 8px 15px;
            }

            .btn-primary {
                padding: 8px;
            }
        }
    </style>
</head>
<body>


    <div class="form-container">
    

        <form:form modelAttribute="admin" action="${pageContext.request.contextPath}/dologin" method="post">
            <h1>Admin Login</h1>
            
  
            <!-- Email Field -->
            <div class="mb-3">
                <form:input path="email" class="form-control" placeholder="Enter Email" type="email"/>
                <form:errors path="email" cssClass="error" />
                          <c:if test="${not empty emailError}">
    <div class="error-message" style="color: red;">
        ${emailError}
    </div>
</c:if>
            </div>

            <!-- Password Field -->
            <div class="mb-3">
                <form:input path="password" class="form-control" placeholder="Enter Password" type="password"/>
                <form:errors path="password" cssClass="error" />
                          <c:if test="${not empty passwordError}">
    <div class="error-message" style="color: red;">
        ${passwordError}
    </div>
</c:if>
            </div>
            <!-- Submit Button -->
            <div class="d-grid">
                <input type="submit" value="Login" class="btn btn-primary">

            </div>
            <br>
 <a href="logout" style="margin-left: 20px; text-decoration: none;">Back</a>
      <!--   <p>Don't forget your password. If you forget leave from job.</p> -->
        </form:form>
    </div>

    <!-- jQuery and Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 