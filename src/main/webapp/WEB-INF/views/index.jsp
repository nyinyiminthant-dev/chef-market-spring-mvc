 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 


<!DOCTYPE html>
<html>
<head>
<!-- Site made with Mobirise Website Builder v5.9.18, https://mobirise.com -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="generator" content="Mobirise v5.9.18, mobirise.com">
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1">
<link rel="shortcut icon"
	href="https://r.mobirisesite.com/870297/assets/images/photo-1635321593217-40050ad13c74.jpeg"
	type="${pageContext.request.contextPath}/resources/assets1/image/x-icon">
<meta name="description"
	content="Chef's Market offers a delightful range of cooking ingredients and products, perfect for culinary enthusiasts. Explore our selection and elevate your cooking experience!">


<title>Chef's Market</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets1/web/assets/mobirise-icons2/mobirise2.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets1/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets1/bootstrap/css/bootstrap-grid.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets1/bootstrap/css/bootstrap-reboot.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets1/parallax/jarallax.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets1/dropdown/css/style.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets1/socicon/css/styles.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets1/theme/css/style.css">
<link rel="preload"
	href="https://fonts.googleapis.com/css2?family=Onest:wght@400;700&display=swap&display=swap"
	as="style" onload="this.onload=null;this.rel='stylesheet'">
<noscript>
	<link rel="stylesheet"
		href="https://fonts.googleapis.com/css2?family=Onest:wght@400;700&display=swap&display=swap">
</noscript>
<link rel="preload" as="style"
	href="${pageContext.request.contextPath}/resources/assets1/mobirise/css/mbr-additional.css?v=9q2MUj">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/assets1/mobirise/css/mbr-additional.css?v=9q2MUj"
	type="text/css">
	
	    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<style>


*{
padding:none;
margin:none;
}
.custom-background {
    background-color: #e9ecef; /* Change to your preferred color */
}

.custom-background {
    background-color: #e9ecef; /* Change to your preferred color */
    border: 2px solid #ccc; /* Add border */
    padding: 20px; /* Add some padding if needed */
}



  /* Reduce the font size and padding for a smaller look */
    .custom-navbar .navbar-brand img {
        height: 2rem; /* Smaller logo size */
    }

    .custom-navbar-caption {
        font-size: 1rem;
    }

    .custom-nav .custom-link {
        font-size: 1rem;
        padding: 0.5rem 0.75rem; /* Less padding to make it smaller */
    }

    .custom-search-box {
        max-width: 150px;
        font-size: 0.9rem;
    }

    .btn-sm {
        font-size: 0.9rem;
    }

    /* Adjust spacing between navbar items */
    .navbar-nav .nav-item {
        margin: 0 0.5rem;
    }

    /* Smaller button padding */
    .btn {
    margin-right: 50px;
        padding: 0.4rem 0.8rem;
    }
    
    
   
</style>
</head>
<body>

<script>
    function confirmLogout(url) {
        Swal.fire({
            title: 'Are you sure?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Yes, Logout!'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.href = url;
            }
        });
    }
</script>


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


<section data-bs-version="5.1" class="menu menu2 cid-utk1ArDkoV" once="menu" id="menu-5-utk1ArDkoV">
    <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm fixed-top custom-navbar">
        <div class="container">
            <!-- Navbar Brand -->
            <div class="navbar-brand d-flex align-items-center">
                <a href="https://mobiri.se" class="navbar-logo">
                    <img src="${pageContext.request.contextPath}/resources/img/logo.jpg"
                         alt="Chef's Market Logo" style="height: 4rem; margin-left: 40px;">
                </a>
                <a class="navbar-caption text-black ms-3 display-4 custom-navbar-caption" href="https://mobiri.se">
                    Chef's Market
                </a>
            </div>

            <!-- Navbar Toggler for mobile view -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
                    aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Navbar Links and Search Form -->
            <div class="collapse navbar-collapse justify-content-between" id="navbarSupportedContent">
                <ul class="navbar-nav mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link text-dark custom-link " href="#">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-dark custom-link" href="addToCart" aria-expanded="false">Shop</a>
                    </li>
                    <li class="nav-item">
                        <form action="${pageContext.request.contextPath}/search" method="get" class="d-flex align-items-center">
                            <input class="form-control custom-search-box me-1" type="search" aria-label="Search" 
                                   name="query" placeholder="Search for Cook">
                            <button class="btn btn-outline-success btn-sm" type="submit">Search</button>
                        </form>
                    </li>
                </ul>

                <!-- User Authentication Links -->
                <c:choose>
                    <c:when test="${not empty sessionScope.loggedInUser}">
                        <div class="d-flex align-items-center">
                            <a href="${pageContext.request.contextPath}/" class="btn btn-primary btn-sm py-1 px-3 ms-1">
                                ${sessionScope.loggedInUser.email}
                            </a>
                           <a href="javascript:void(0);" onclick="confirmLogout('${pageContext.request.contextPath}/logout')" class="btn btn-danger">Logout</a>

                        </div>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-sm py-1 px-4 ms-1">
                            Sign-In
                        </a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </nav>
</section>






	<section data-bs-version="5.1"
    class="header18 cid-utk1ArD5NX mbr-fullscreen"
    id="hero-15-utk1ArD5NX" style="background-image: url('${pageContext.request.contextPath}/resources/img/p10bg.jpg'); background-size: cover; background-position: center;">
	


		<div class="mbr-overlay"
			style="opacity: 0.5; background-color: rgb(0, 0, 0);"></div>
		<div class="container-fluid">
			<div class="row">
				<div class="content-wrap col-12 col-md-12">
					<h1
						class="mbr-section-title mbr-fonts-style mbr-white mb-4 display-1">
						<strong>Cook Like A Pro</strong>
					</h1>

					<p class="mbr-fonts-style mbr-text mbr-white mb-4 display-7">Unleash
						your inner chef with our top-notch products and ingredients!</p>
					<div class="mbr-section-btn">
						<a class="btn btn-white-outline display-7"
							href="${pageContext.request.contextPath}/login">Get Started</a>
					</div>
				</div>
			</div>
		</div>
	</section>


	

<!-- Ingredients Section -->
<section class="container-xxl py-5 custom-background">
    <div class="container">
        <h2 class="text-center mb-4">How to cook</h2>
        <div class="row row-cols-1 row-cols-md-3 g-4">
            <c:forEach var="ingredient" items="${ingredientList}" varStatus="status">
                <c:if test="${status.index < 3}">
                    <div class="col">
                        <div class="card h-100">
                            <img src="${pageContext.request.contextPath}/upload/${ingredient.photoPath}" class="card-img-top" alt="${ingredient.in_name}">
                            <div class="card-body">
                                <h5 class="card-title"> ${ingredient.item_name}</h5>
                                <br>
                                <p class="card-title"><h5> Ingredients</h5> <br>: ${ingredient.in_name}</p>
                                <br>
                                <p class="card-text"><h5>Instructions </h5> <br> :${fn:substring(ingredient.instruction, 0, 100)}...</p>
                            </div>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
        </div>
        <div class="text-center mt-4">
            <form action="${pageContext.request.contextPath}/search" method="get" class="d-flex align-items-center">
                            <input class="form-control custom-search-box me-1" type="hidden" aria-label="Search" 
                                   name="query" placeholder="View all ingredients">
                            <button class="btn btn-outline-success btn-sm" type="submit">View all ingredients</button>
                        </form>
        </div>
    </div>
</section>

	
	
	
	<!-- Product List -->
<section class="container my-5">
    <h2 class="text-center mb-4">Sizzling Hot Products</h2>
    <div class="row">
        <c:forEach var="product" items="${productList}" varStatus="status">
            <c:if test="${status.index < 8}">
                <div class="col-12 col-sm-6 col-md-4 col-lg-3 mb-4">
                    <div class="card product-card h-100">
                        <img src="${pageContext.request.contextPath}/upload/${product.p_photo}" alt="${product.p_name}">
                        <div class="card-body text-center">
                            <h5 class="item-title">${product.p_name}</h5>
                            <p class="item-subtitle">${product.p_price} Kyats</p>
                            
                        </div>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>
    <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/addToCart" class="btn btn-outline-primary">View All Products</a>
    </div>
</section>
	
		
	
	
<section data-bs-version="5.1" class="article2 cid-utk1ArFMyH" id="about-us-2-utk1ArFMyH">
    <div class="container py-5">
        <div class="row justify-content-center align-items-center">
            <!-- Image Section -->
            <div class="col-12 col-md-6">
                <div class="image-wrapper">
                    <img class="img-fluid rounded shadow" 
                         src="${pageContext.request.contextPath}/resources/img/p2bg.jpg" 
                         alt="Chef's Market - Culinary Tools and Ingredients">
                </div>
            </div>

            <!-- Text Section -->
            <div class="col-12 col-md-6">
                <div class="text-wrapper">
                    <h1 class="mbr-section-title mbr-fonts-style mb-4 display-3 text-primary font-weight-bold">
                       About Us
                    </h1>
                    <p class="mbr-text mbr-fonts-style mb-3 display-7 text-dark">
                        At Chef's Market, we believe that cooking should be an adventure, not a chore!
                    </p>

                    <p class="mbr-text mbr-fonts-style mb-3 display-7 text-dark">
                        Our mission? To equip you with the best tools and ingredients to make your culinary dreams come true!
                    </p>

                    <p class="mbr-text mbr-fonts-style mb-3 display-7 text-dark">
                        Join us on this delicious journey and transform your kitchen into a gourmet paradise!
                    </p>
                </div>
            </div>
        </div>
    </div>
</section>

	<%-- <section data-bs-version="5.1" class="people04 cid-utk1ArFt23"
		id="testimonials-3-utk1ArFt23">


		<div class="container">
			<div class="row mb-5 justify-content-center">
				<div class="col-12 mb-0 content-head">
					<h3
						class="mbr-section-title mbr-fonts-style align-center mb-0 display-2">
						<strong>Feedback</strong>
					</h3>

				</div>
			</div>
			<div class="row mbr-masonry"
				data-masonry="{&quot;percentPosition&quot;: true }">
				<div
					class="item features-without-image col-12 col-md-6 col-lg-4 active">
					<div class="item-wrapper">
						<div class="card-box align-left">
							<p class="card-text mbr-fonts-style display-7">
								</p>
					
							
								 <h5 class="mb-1">${feedback.firstname} ${feedback.lastname}</h5>
                            
							
						</div>
					</div>
				</div>
				<div class="item features-without-image col-12 col-md-6 col-lg-4">
					<div class="item-wrapper">
						<div class="card-box align-left">
							<p class="card-text mbr-fonts-style display-7">The freshest
								ingredients ever used!</p>
							<div class="img-wrapper mt-4 mb-3">
								<img
									src="https://r.mobirisesite.com/870297/assets/images/photo-1509098681029-b45e9c845022.jpeg"
									data-slide-to="1" data-bs-slide-to="1" alt="">
							</div>
							<h5 class="card-title mbr-fonts-style display-7">
								<strong>Mark T.</strong>
							</h5>
						</div>
					</div>
				</div>
				<div class="item features-without-image col-12 col-md-6 col-lg-4">
					<div class="item-wrapper">
						<div class="card-box align-left">
							<p class="card-text mbr-fonts-style display-7">I can't
								believe how easy it is to find what I need!</p>
							<div class="img-wrapper mt-4 mb-3">
								<img
									src="https://r.mobirisesite.com/870297/assets/images/photo-1567468219153-4b1dea5227ea.jpeg"
									data-slide-to="2" data-bs-slide-to="2" alt="">
							</div>
							<h5 class="card-title mbr-fonts-style display-7">
								<strong>Sarah L.</strong>
							</h5>
						</div>
					</div>
				</div>
				<div class="item features-without-image col-12 col-md-6 col-lg-4">
					<div class="item-wrapper">
						<div class="card-box align-left">
							<p class="card-text mbr-fonts-style display-7">My secret
								ingredient? Chef's Market!</p>
							<div class="img-wrapper mt-4 mb-3">
								<img
									src="https://r.mobirisesite.com/870297/assets/images/photo-1569598409550-55537a83a662.jpeg"
									data-slide-to="3" data-bs-slide-to="3" alt="">
							</div>
							<h5 class="card-title mbr-fonts-style display-7">
								<strong>Tom H.</strong>
							</h5>
						</div>
					</div>
				</div>
			
				<div class="item features-without-image col-12 col-md-6 col-lg-4">
					<div class="item-wrapper">
						<div class="card-box align-left">
							<p class="card-text mbr-fonts-style display-7">Best online
								shopping experience ever!</p>
							<div class="img-wrapper mt-4 mb-3">
								<img
									src="${pageContext.request.contextPath}/resources/assets1/images/photo-1522091066250-665186289043.jpeg"
									data-slide-to="5" data-bs-slide-to="5" alt="">
							</div>
							<h5 class="card-title mbr-fonts-style display-7">
								<strong>David K.</strong>
							</h5>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
 --%>
	

	<section data-bs-version="5.1" class="contacts01 cid-utk1ArMkQY"
		id="contacts-1-utk1ArMkQY">




		<div class="container">
			<div class="row justify-content-center">
				<div class="col-12 content-head">
					<div class="mbr-section-head mb-5">
						<h3
							class="mbr-section-title mbr-fonts-style align-center mb-0 display-2">
							<strong>Contact Us</strong>
						</h3>

					</div>
				</div>
			</div>
			<div class="row">
				<div class="item features-without-image col-12 col-md-6 active">
					<div class="item-wrapper">
						<div class="text-wrapper">
							<h6 class="card-title mbr-fonts-style mb-3 display-5">
								<strong>Phone</strong>
							</h6>
							<p class="mbr-text mbr-fonts-style display-7">
								<a href="tel:1-800-CHEF-MKT" class="text-black">+959-123-456-789</a>
							</p>
						</div>
					</div>
				</div>
				<div class="item features-without-image col-12 col-md-6">
					<div class="item-wrapper">
						<div class="text-wrapper">
							<h6 class="card-title mbr-fonts-style mb-3 display-5">
								<strong>Email</strong>
							</h6>
							<p class="mbr-text mbr-fonts-style display-7">
								<a href="mailto:info@chefsmarket.com" class="text-black">chefmarketinfo@gmail.com</a>
							</p>
						</div>
					</div>
				</div>
				<div class="item features-without-image col-12 col-md-6">
					<div class="item-wrapper">
						<div class="text-wrapper">
							<h6 class="card-title mbr-fonts-style mb-3 display-5">
								<strong>Address</strong>
							</h6>
							<p class="mbr-text mbr-fonts-style display-7">ACE Inspiration
							</p>
						</div>
					</div>
				</div>
				<div class="item features-without-image col-12 col-md-6">
					<div class="item-wrapper">
						<div class="text-wrapper">
							<h6 class="card-title mbr-fonts-style mb-3 display-5">
								<strong>Working Hours</strong>
							</h6>
							<p class="mbr-text mbr-fonts-style display-7">Daily
								</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section data-bs-version="5.1" class="footer4 cid-utk1ArMsGv"
		once="footers" id="footer-4-utk1ArMsGv">





		<div class="container">
			<div class="media-container-row align-center mbr-white">
				<div class="col-12">
					<p class="mbr-text mb-0 mbr-fonts-style display-7">Chef's
						Market All rights reserved.</p>
				</div>
			</div>
		</div>
	</section>
	<section class="display-7"
		style="padding: 0; align-items: center; justify-content: center; flex-wrap: wrap; align-content: center; display: flex; position: relative; height: 4rem;">
		<a href="https://mobiri.se/3558839"
			style="flex: 1 1; height: 4rem; position: absolute; width: 100%; z-index: 1;"><img
			alt="" style="height: 4rem;"
			src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw=="></a>
		<p style="margin: 0; text-align: center;" class="display-7">&#8204;</p>
		
	</section>
	<script src="${pageContext.request.contextPath}/resources/assets1/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets1/parallax/jarallax.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets1/smoothscroll/smooth-scroll.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets1/ytplayer/index.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets1/dropdown/js/navbar-dropdown.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets1/vimeoplayer/player.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets1/masonry/masonry.pkgd.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets1/imagesloaded/imagesloaded.pkgd.min.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets1/scrollgallery/scroll-gallery.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets1/theme/js/script.js"></script>
	<script src="${pageContext.request.contextPath}/resources/assets1/formoid/formoid.min.js"></script>


</body>
</html>