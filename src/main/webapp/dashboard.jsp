<%@ page import="com.movie.model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*, java.net.*, org.json.*, jakarta.servlet.http.*, jakarta.servlet.*" %>
<%
    
	User user = (User) session.getAttribute("user");

    String moviesJson = (String) request.getAttribute("movies");
    String trendingMoviesJson = (String) request.getAttribute("trendingMovies");
    String bollywoodMoviesJson = (String) request.getAttribute("bollywoodMovies");
    String marathiMoviesJson = (String) request.getAttribute("marathiMovies");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="css/dashboard.css">
</head>
<body>
	<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg navbar-custom px-4 py-3">
    <a class="navbar-brand" href="#">MOVIEGO</a>
    <button class="navbar-toggler text-white" type="button" data-bs-toggle="collapse" data-bs-target="#flixNavbar">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="flixNavbar">
        <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-4">
            <li class="nav-item">
                <a class="nav-link" href="#">Home</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Catalog</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Pricing Plans</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="pagesDropdown" role="button" data-bs-toggle="dropdown">
                    Pages
                </a>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="#">About</a></li>
                    <li><a class="dropdown-item" href="#">Contact</a></li>
                </ul>
            </li>
        </ul>

		 <form class="d-flex me-3" role="search" action="SearchMoviesServlet" method="get">
            <input class="form-control me-2" name="query" placeholder="Search for movies...">
            <button class="btn btn-signin me-2" type="submit">Search</button>
        </form>

        <!-- Profile Icon Dropdown -->
        <div class="dropdown">
            <a href="#" class="d-flex align-items-center text-white text-decoration-none dropdown-toggle" id="profileDropdown" data-bs-toggle="dropdown">
                <i class="bi bi-person-circle fs-4"></i>
            </a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="profileDropdown">
                <li><a class="dropdown-item" href="#">My Profile</a></li>
                <li><a class="dropdown-item" href="#">My Watchlist</a></li>
                <li><hr class="dropdown-divider"></li>
                <li><a class="dropdown-item" href="LogoutServlet">Logout</a></li>
            </ul>
        </div>
    </div>
</nav>
<!-- Navbar End -->
	
    <div class="container text-white">
    <div class="search m-5">
        <h2 class="text-white">Welcome, <%= user.getFullname() %>!</h2>
    
        <!-- Movie Search Feature -->
       <div class="d-flex">
        <form action="SearchMoviesServlet" method="GET">
            <input type="text" name="query" placeholder="Search for movies..."  class="border border-success border-3 rounded-pill p-2" required>
            <button class="btn btn-signin m-3" type="submit">Search</button>
        </form>

        <!-- Genre Selection Feature -->
        <form action="GenreMoviesServlet" method="GET">
            <label><h6>Select Genre:</h6></label>
            <select name="genreId" class="border border-success border-3 rounded-pill p-2">
                <option value="28">Action</option>
                <option value="35">Comedy</option>
                <option value="18">Drama</option>
                <option value="27">Horror</option>
                <option value="878">Sci-Fi</option>
                <option value="53">Thriller</option>
            </select>
            <button class="btn btn-signin m-3" type="submit">Show Movies</button>
        </form>
        </div>
	</div>
<!-- Popular Movies Section -->
        <h3 class="heading m-3">Popular Movies</h3>
        <div class="movie-list">
            <jsp:include page="moviesList.jsp">
                <jsp:param name="moviesJson" value="<%= moviesJson %>" />
            </jsp:include>
        </div>
     <!-- Trending Movies Section -->
        <h3 class="heading m-3">Trending Movies</h3>
        <div class="movie-list">
            <jsp:include page="moviesList.jsp">
                <jsp:param name="moviesJson" value="<%= trendingMoviesJson %>" />
            </jsp:include>
        </div>

        <!-- Bollywood Movies Section -->
        <h3 class="heading m-3">Bollywood Movies</h3>
        <div class="movie-list">
            <jsp:include page="moviesList.jsp">
                <jsp:param name="moviesJson" value="<%= bollywoodMoviesJson %>" />
            </jsp:include>
        </div>

        <!-- Marathi Movies Section -->
        <h3 class="heading m-3">Marathi Movies</h3>
        <div class="movie-list">
            <jsp:include page="moviesList.jsp">
                <jsp:param name="moviesJson" value="<%= marathiMoviesJson %>" />
            </jsp:include>
        </div>
    </div>
    
    <!-- Bootstrap Bundle (includes Popper.js) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
</body>
</html>
