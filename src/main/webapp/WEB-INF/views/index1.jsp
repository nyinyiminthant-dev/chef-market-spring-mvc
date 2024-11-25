<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product List</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/cart_style.css">

</head>
<body>
    
    <div class="container">
    
     <!-- Success Message -->
        <c:if test="${not empty loginSuccessMessage}">
            <div class="success-message" id="successMessage">
                ${loginSuccessMessage}
            </div>
        </c:if>
    
        <header>
            <div class="title">PRODUCT LIST</div>
            <div class="icon-cart">
                <svg aria-hidden="true" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 18 20">
                    <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 15a2 2 0 1 0 0 4 2 2 0 0 0 0-4Zm0 0h8m-8 0-1-4m9 4a2 2 0 1 0 0 4 2 2 0 0 0 0-4Zm-9-4h10l2-7H3m2 7L3 4m0 0-.792-3H1"/>
                </svg>
                <span>0</span> <!-- Dynamic cart item count -->
            </div>
        </header>

        
        <div class="listProduct">
            <!-- Products will be dynamically injected here -->
        </div>
    </div>
    
    <div class="cartTab">
        <h1>Shopping Cart</h1>
        <div class="listCart">
            <!-- Cart items will be dynamically injected here -->
        </div>
        <div class="btn">
            <button class="close">CLOSE</button>
            <button class="checkOut">Check Out</button>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/resources/js/app.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
</body>
</html>
 