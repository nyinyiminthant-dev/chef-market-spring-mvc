<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ingredient Search Results</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/css/bootstrap.min.css">
    <style>
          body {
        background: url('${pageContext.request.contextPath}/resources/img/p10bg.jpg') no-repeat center center fixed;
        background-size: cover;
      
        font-family: 'Arial', sans-serif;
        animation: fadeInBackground 2s ease-in-out;
    }

      body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 200%;
            background: inherit;
            filter: blur(8px); /* Adjust the blur intensity */
            z-index: -1;
        }
        .card {
            transition: transform 0.3s ease;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        .card:hover {
            transform: scale(1.05);
        }
        .card-img-top {
            height: 200px;
            object-fit: cover;
        }
        .alert {
            margin: 20px 0;
        }
    </style>
</head>
<body>




<nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="goowner">Ingredients And Instructions</a>
        
        
        <ul class="navbar-nav ms-auto">
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/">

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


    <div class="container my-5">
        <h1 class="text-center mb-4">Ingredient Search Results</h1>

        <c:if test="${not empty message}">
            <div class="alert alert-warning text-center">${message}</div>
        </c:if>

        <c:if test="${not empty ingredients}">
            <div class="row">
                <c:forEach var="ingredient" items="${ingredients}">
                    <div class="col-lg-4 col-md-6 mb-4">
                        <div class="card h-100">
                            <img src="${pageContext.request.contextPath}/upload/${ingredient.photoPath}" class="card-img-top" alt="${ingredient.in_name}">
                            <div class="card-body">
                                <h3 class="card-title">${ingredient.item_name}</h3>
                                <hr>
                                <p class="card-title"><h4>Ingredient </h4>${ingredient.in_name}</p>
                               <hr>
                                <a href="${pageContext.request.contextPath}/ingredientDetail?id=${ingredient.id}" class="btn btn-primary">View Detail</a>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:if>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.1.3/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const cards = document.querySelectorAll('.card');
            cards.forEach(card => {
                card.addEventListener('mouseover', function () {
                    card.classList.add('shadow-lg');
                });
                card.addEventListener('mouseout', function () {
                    card.classList.remove('shadow-lg');
                });
            });
        });
    </script>
</body>
</html>
