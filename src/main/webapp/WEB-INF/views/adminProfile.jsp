<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<%
    if (session.getAttribute("adminEmail") == null) {
        response.sendRedirect(request.getContextPath() + "/productadmin");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Styling */
        body {
            font-family: Arial, sans-serif;
            background: url('${pageContext.request.contextPath}/resources/img/p3bg.jpg') no-repeat center center fixed;
            background-size: cover;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .blurred-bg, .overlay { position: absolute; width: 100%; height: 150%; }
        .blurred-bg { filter: blur(8px); z-index: 1; }
        .overlay { background-color: rgba(0, 0, 0, 0.5); z-index: 2; border-radius: 8px; }
        .container { position: relative; max-width: 800px; z-index: 3; }
        .profile-header { margin-top: 30px; padding: 30px; background-color: rgba(50, 50, 50, 0.8); color: white; border-radius: 8px; text-align: center; }
        .profile-photo { width: 120px; height: 120px; border-radius: 50%; border: 3px solid white; margin: 20px 0; }
        .btn-custom { padding: 12px 20px; font-size: 16px; background-color: #6c757d; transition: background-color 0.3s ease; }
        .btn-custom:hover { background-color: #5a6268; }
        .form-control { border-radius: 10px; background-color: rgba(255, 255, 255, 0.8); color: #333; }
        .error { color: red; font-size: 0.9em; }
        .d-grid { margin-top: 20px; }
    </style>

    <!-- JavaScript Validation -->
    <script>
        function validateForm() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirm_password").value;
            
            // Check if password and confirm password match
            if (password !== confirmPassword) {
                document.getElementById("confirmPasswordError").innerHTML = "Passwords do not match.";
                return false; // Prevent form submission
            }
            document.getElementById("confirmPasswordError").innerHTML = ""; // Clear error
            return true; // Allow form submission
        }
    </script>
</head>
<body>

<div class="blurred-bg"></div>
<div class="overlay"></div>

<div class="container">
    <div class="profile-header">
        <form:form modelAttribute="admin" action="${pageContext.request.contextPath}/updateProfile" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
            <h1>Admin Profile</h1>
            <img src="${pageContext.request.contextPath}/upload/${admin.a_photo}" alt="Profile Photo" class="profile-photo rounded-circle mb-3" width="100">
            <p>Admin ID: ${sessionScope.adID}</p>

            <!-- Email Field with Label -->
            <div class="form-group">
                <label for="email">Email</label>
                <form:input path="email" class="form-control" placeholder="Enter Email" type="email"/>
                <form:errors path="email" cssClass="error" />
            </div>

            <!-- First Name Field with Label -->
            <div class="form-group">
                <label for="first_name">First Name</label>
                <form:input path="first_name" class="form-control" placeholder="Enter First Name" type="text"/>
                <form:errors path="first_name" cssClass="error" />
            </div>

            <!-- Password Field with Label -->
            <div class="form-group">
                <label for="password">Password</label>
                <form:input path="password" class="form-control" placeholder="Enter Password" type="password" id="password"/>
                <form:errors path="password" cssClass="error" />
            </div>

            <!-- Confirm Password Field with Label -->
            <div class="form-group">
                <label for="confirm_password">Confirm Password</label>
                <input id="confirm_password" name="confirm_password" class="form-control" placeholder="Confirm Password" type="password"/>
                <div id="confirmPasswordError" class="error"></div>
            </div>

            <!-- Profile Image Upload Field with Label -->
            <div class="form-group">
                <label for="profileImage">Update Profile Photo</label>
                <form:input path="photo" type="file" class="form-control"/>
                <form:errors path="photo" cssClass="error" />
            </div>

            <!-- Submit Button -->
            <div class="d-grid">
                <input type="submit" value="Update Profile" class="btn btn-custom btn-primary w-100">
            </div>
        </form:form>
    </div>
    <a href="${pageContext.request.contextPath}/productAdmin" class="btn btn-danger mt-3 w-100">Back</a>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.4.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
