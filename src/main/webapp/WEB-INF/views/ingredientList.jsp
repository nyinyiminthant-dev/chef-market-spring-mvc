<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ingredient List</title>
    <!-- Add Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
        }

        .card {
            opacity: 0;
            transform: translateY(20px);
            transition: opacity 0.5s ease, transform 0.5s ease;
        }

        .card.show {
            opacity: 1;
            transform: translateY(0);
        }

        .card-img-top {
            transition: transform 0.3s ease;
            cursor: pointer; 
        }

        .card-img-top:hover {
            transform: scale(1.05); 
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1050;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.8); 
            overflow: auto;
            opacity: 0;
            transition: opacity 0.5s ease; 
        }

        .modal.show {
            display: block;
            opacity: 1;
        }

        .modal-content {
            margin: 10% auto;
            padding: 20px;
            max-width: 80%;
            background-color: white;
            border-radius: 10px;
            text-align: center;
            transform: scale(0.8);
            animation: scaleUp 0.5s ease forwards;
        }

        @keyframes scaleUp {
            from {
                transform: scale(0.8);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        .close {
            position: absolute;
            top: 20px;
            right: 30px;
            font-size: 30px;
            color: white;
            cursor: pointer;
        }
    </style>
</head>
<body>
   <div class="container mt-5">
        <h1 class="text-center mb-4">Ingredient List</h1>
        <div class="row row-cols-1 row-cols-md-2 g-4">
            <c:forEach var="ingredient" items="${ingredientList}">
                <div class="col">
                    <div class="card h-60">
                        <img src="${pageContext.request.contextPath}/upload/${ingredient.photoPath}" class="card-img-top" alt="${ingredient.in_name}" onclick="openModal('${ingredient.in_name}', '${ingredient.instruction}', '${pageContext.request.contextPath}/${ingredient.photoPath}')">
                        <div class="card-body">
                            <h5 class="card-title">${ingredient.in_name}</h5>
                            <p class="card-text" data-length="${fn:length(ingredient.instruction)}">
                                <span class="short-instruction">
                                    ${fn:substring(ingredient.instruction, 0, 100)}...
                                </span>
                                <span class="full-instruction" style="display:none;">
                                    ${ingredient.instruction}	
                                </span>
                            </p>
                           
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        // Function to open modal
        function openModal(name, instruction, photoPath) {
            const modal = document.getElementById('myModal');
            document.getElementById('modalTitle').innerText = name;
            document.getElementById('modalText').innerText = instruction;
            document.getElementById('modalImage').src = photoPath;

            modal.classList.add('show'); // Add 'show' class for fade-in effect
        }

        // Function to close modal
        function closeModal() {
            const modal = document.getElementById('myModal');
            modal.classList.remove('show'); // Remove 'show' class for fade-out effect
        }

        // Function to toggle instruction visibility
        function toggleInstruction(button) {
            const shortInstruction = button.previousElementSibling.querySelector('.short-instruction');
            const fullInstruction = button.previousElementSibling.querySelector('.full-instruction');

            if (fullInstruction.style.display === 'none') {
                shortInstruction.style.display = 'none';
                fullInstruction.style.display = 'inline';
                button.innerText = 'See less';
            } else {
                shortInstruction.style.display = 'inline';
                fullInstruction.style.display = 'none';
                button.innerText = 'See more';
            }
        }

        // Initial hiding for long instructions and card animations
        document.addEventListener("DOMContentLoaded", function() {
            const allCards = document.querySelectorAll('.card');
            
            allCards.forEach(function(card, index) {
                setTimeout(() => {
                    card.classList.add('show'); // Add show class for animation
                }, index * 100); // Staggered appearance
            });

            const allInstructions = document.querySelectorAll('.card-text');
            allInstructions.forEach(function(instruction) {
                const length = instruction.dataset.length;
                if (length > 100) { // Hiding long instructions initially
                    instruction.querySelector('.short-instruction').style.display = 'inline';
                    instruction.querySelector('.full-instruction').style.display = 'none';
                } else {
                    instruction.style.display = 'block';
                }
            });
        });
    </script>
</body>
</html>
