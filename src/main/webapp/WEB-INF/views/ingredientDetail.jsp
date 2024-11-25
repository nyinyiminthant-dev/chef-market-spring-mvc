<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${ingredient.in_name}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        .ingredient-card {
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }
        .ingredient-card:hover {
            transform: scale(1.03);
        }
        .feedback-section {
            background-color: #f1f1f1;
            border-radius: 8px;
            padding: 20px;
            margin-top: 40px;
        }
        .feedback-form {
            margin-top: 20px;
        }
        .feedback-item {
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }
        .feedback-item:hover {
            transform: scale(1.02);
        }
        .alert.show {
            opacity: 1;
            transition: opacity 0.5s;
        }
    </style>
</head>
<body>



<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="goowner">Learn How To Cook</a>
        
        
        <ul class="navbar-nav ms-auto">
            <li class="nav-item">
                 <form action="${pageContext.request.contextPath}/search" method="get" class="d-flex align-items-center">
                            <input class="form-control custom-search-box me-1" type="hidden" aria-label="Search" 
                                   name="query" placeholder="View all ingredients">
                            <button class="btn btn-outline-success btn-sm" type="submit">View all Ingredients</button>
                        </form>
            </li>
             
        </ul>
    </div>
</nav>

    <div class="container mt-5">
        <!-- Ingredient Details Section -->
        <div class="ingredient-card col-md-8 mx-auto p-4 shadow-sm animate__animated animate__fadeIn">
            <h1 class="text-center">${ingredient.item_name}</h1>
            <img src="${pageContext.request.contextPath}/upload/${ingredient.photoPath}" alt="${ingredient.in_name}" class="img-fluid mb-4 rounded">
            <p><strong>Ingredients :</strong>${ingredient.in_name}</p>
            <br>
            <p><strong>Instructions :</strong> ${ingredient.instruction}</p>
            <br>
            <p><strong>Remark:</strong> ${ingredient.remark}</p>
        </div>

        <!-- Feedback Section -->
        <div class="feedback-section animate__animated animate__fadeInUp">
            <h3 class="text-center">Feedback</h3>

            <!-- Feedback List -->
            <div class="feedback-list mt-4">
                <c:if test="${not empty feedbackList}">
                    <c:forEach var="feedback" items="${feedbackList}">
                        <div class="feedback-item shadow-sm p-3 mb-3 animate__animated animate__fadeIn">
                            <h5 class="mb-1">${feedback.firstname} ${feedback.lastname}</h5>
                            <p>${feedback.review}</p>
                        </div>
                    </c:forEach>
                </c:if>
                <c:if test="${empty feedbackList}">
                    <p class="text-center text-muted">No feedback available for this ingredient.</p>
                </c:if>
            </div>

            <!-- Feedback Form -->
            <div class="feedback-form mt-4">
                <c:if test="${not empty sessionScope.loggedInUser}">
                    <form id="feedbackForm" method="post">
                        <div class="form-group">
                            <textarea class="form-control" name="review" rows="4" placeholder="Write your feedback here..." required></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary mt-3">Submit Feedback</button>
                    </form>
                </c:if>
                <c:if test="${empty sessionScope.loggedInUser}">
                    <p class="text-center mt-3">Please <a href="${pageContext.request.contextPath}/login">log in</a> to leave feedback.</p>
                </c:if>
            </div>

            <!-- Success Message for Feedback Submission -->
            <c:if test="${not empty feedbackSuccess}">
                <div class="alert alert-success show mt-3 animate__animated animate__fadeIn" role="alert" id="feedbackResponse">
                    Thank you for your feedback!
                </div>
            </c:if>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <script>
    $(document).ready(function() {
        // Smooth fade-out for feedback messages
        setTimeout(function() {
            $('#feedbackResponse').fadeOut('slow');
        }, 3000);

        $('#feedbackForm').on('submit', function(event) {
            event.preventDefault();

            $.ajax({
                url: '${pageContext.request.contextPath}/ingredient/${ingredient.id}/submitFeedback',
                type: 'POST',
                data: $(this).serialize(),
                success: function(response) {
                    $('#feedbackResponse').html('<div class="alert alert-success show animate__animated animate__fadeIn" role="alert">Thank you for your feedback!</div>');
                    $('#feedbackForm')[0].reset();
                    setTimeout(function() {
                        $('#feedbackResponse').fadeOut('slow');
                    }, 3000);
                    // Append new feedback without refreshing
                    $('.feedback-list').append(
                        '<div class="feedback-item shadow-sm p-3 mb-3 animate__animated animate__fadeIn">' +
                        '<h5 class="mb-1">${sessionScope.loggedInUser.firstname} ${sessionScope.loggedInUser.lastname}</h5>' +
                        '<p>' + response.review + '</p>' +
                        '</div>'
                    );
                },
                error: function(xhr) {
                    $('#feedbackResponse').html('<div class="alert alert-danger show animate__animated animate__shakeX" role="alert">There was an error submitting your feedback.</div>');
                }
            });
        });
    });
    </script>
</body>
</html>
