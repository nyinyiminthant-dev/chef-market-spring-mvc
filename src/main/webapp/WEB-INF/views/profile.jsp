<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User Profile</title>
    <!-- Bootstrap CSS -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
        }
        .profile-header {
            margin-top: 20px;
            padding: 20px;
            background-color: #007bff;
            color: white;
            border-radius: 8px;
            text-align: center;
            animation: fadeInDown 1s ease-in-out;
        }
        .profile-photo {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            border: 3px solid white;
            margin: 10px 0;
            animation: bounce 2s infinite;
        }
        .feedback-section {
            margin-top: 20px;
            animation: fadeInUp 1s ease-in-out;
        }
        .feedback-item {
            border: 1px solid #ccc;
            padding: 15px;
            border-radius: 8px;
            background-color: #ffffff;
            margin-bottom: 15px;
        }
        /* Keyframes for animations */
        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes bounce {
            0%, 20%, 50%, 80%, 100% { transform: translateY(0); }
            40% { transform: translateY(-10px); }
            60% { transform: translateY(-5px); }
        }
    </style>
</head>
<body>

<div class="container">
    <div class="profile-header">
        <img src="${pageContext.request.contextPath}/resources/img/default-profile.png" alt="Profile Photo" class="profile-photo">
        <h2>Welcome, ${user.firstname} ${user.lastname}</h2>
        <p>Email: ${user.email}</p>
    </div>

    <div class="feedback-section">
        <h4>Your Feedback</h4>
        <c:forEach var="feedback" items="${feedbackList}">
            <div class="feedback-item">
                <p><strong>Ingredient ID:</strong> ${feedback.in_id}</p>
                <p><strong>Review:</strong> ${feedback.review}</p>
            </div>
        </c:forEach>
    </div>
    
    <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger mt-3">Logout</a>
</div>

<!-- Bootstrap JS, Popper.js, and jQuery -->
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.4.4/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
