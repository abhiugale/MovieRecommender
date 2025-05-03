<%@page import="java.net.URI"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.servlet.http.*, jakarta.servlet.*" %>
<%@ page import="org.json.*" %>
<%
    try {
        int movieId = Integer.parseInt(request.getParameter("id"));
        String apiKey = "bc9d6c9e05d6a8bf2e7c801e657445ba";
        String movieUrl = "https://api.themoviedb.org/3/movie/" + movieId + "?api_key=" + apiKey;
        String videoUrl = "https://api.themoviedb.org/3/movie/" + movieId + "/videos?api_key=" + apiKey;
        String similarMoviesUrl = "https://api.themoviedb.org/3/movie/" + movieId + "/similar?api_key=" + apiKey;
        String watchProvidersUrl = "https://api.themoviedb.org/3/movie/" + movieId + "/watch/providers?api_key=" + apiKey;

        // Fetch movie details
       	java.net.URI uri = URI.create(movieUrl);
       	java.net.URL url = uri.toURL();
        java.net.HttpURLConnection conn = (java.net.HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        java.io.BufferedReader reader = new java.io.BufferedReader(new java.io.InputStreamReader(conn.getInputStream()));
        StringBuilder content = new StringBuilder();
        String inputLine;
        while ((inputLine = reader.readLine()) != null) {
            content.append(inputLine);
        }
        reader.close();

        JSONObject movieDetails = new JSONObject(content.toString());
        String title = movieDetails.getString("title");
        String overview = movieDetails.optString("overview", "No overview available.");
        String posterPath = "https://image.tmdb.org/t/p/w500" + movieDetails.optString("poster_path", "");
        String releaseDate = movieDetails.optString("release_date", "N/A");
        double rating = movieDetails.optDouble("vote_average", 0.0);
        int runtime = movieDetails.optInt("runtime", 0);
        JSONArray genres = movieDetails.getJSONArray("genres");

        // Fetch watch providers
        java.net.URI watchUri = URI.create(watchProvidersUrl);
       	java.net.URL watchUrl = watchUri.toURL();
        java.net.HttpURLConnection watchConn = (java.net.HttpURLConnection) watchUrl.openConnection();
        watchConn.setRequestMethod("GET");

        java.io.BufferedReader watchReader = new java.io.BufferedReader(new java.io.InputStreamReader(watchConn.getInputStream()));
        StringBuilder watchContent = new StringBuilder();
        while ((inputLine = watchReader.readLine()) != null) {
            watchContent.append(inputLine);
        }
        watchReader.close();

        JSONObject watchProviders = new JSONObject(watchContent.toString());
        JSONObject providers = watchProviders.optJSONObject("results");
        JSONObject indiaProviders = (providers != null) ? providers.optJSONObject("IN") : null;

        // Fetch movie trailers
        java.net.URI videoApiUri = URI.create(videoUrl);
       	java.net.URL videoApiUrl = videoApiUri.toURL();
        java.net.HttpURLConnection videoConn = (java.net.HttpURLConnection) videoApiUrl.openConnection();
        videoConn.setRequestMethod("GET");

        java.io.BufferedReader videoReader = new java.io.BufferedReader(new java.io.InputStreamReader(videoConn.getInputStream()));
        StringBuilder videoContent = new StringBuilder();
        while ((inputLine = videoReader.readLine()) != null) {
            videoContent.append(inputLine);
        }
        videoReader.close();

        JSONObject videoJson = new JSONObject(videoContent.toString());
        JSONArray videos = videoJson.getJSONArray("results");
        String trailerKey = "";
        
        for (int i = 0; i < videos.length(); i++) {
            JSONObject video = videos.getJSONObject(i);
            if ("Trailer".equals(video.optString("type"))) {
                trailerKey = video.getString("key");
                break;
            }
        }

        // Fetch similar movies
        java.net.URI similarUri = URI.create(similarMoviesUrl);
       	java.net.URL similarUrl = similarUri.toURL();
        java.net.HttpURLConnection similarConn = (java.net.HttpURLConnection) similarUrl.openConnection();
        similarConn.setRequestMethod("GET");

        java.io.BufferedReader similarReader = new java.io.BufferedReader(new java.io.InputStreamReader(similarConn.getInputStream()));
        StringBuilder similarContent = new StringBuilder();
        while ((inputLine = similarReader.readLine()) != null) {
            similarContent.append(inputLine);
        }
        similarReader.close();

        JSONObject similarMoviesJson = new JSONObject(similarContent.toString());
        JSONArray similarMovies = similarMoviesJson.getJSONArray("results");
%>
<!DOCTYPE html>
<html>
<head>
    <title><%= title %></title>
     <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
   
    <link rel="stylesheet" type="text/css" href="css/movieDetails.css">
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
                <a class="nav-link" href="FetchMoviesServlet">Home</a>
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
    <div class="container">
    	<div class="details d-flex m-5">
    	<div class="poster">
    		<img src="<%= posterPath %>" alt="<%= title %>" class="poster-img">
    	</div>
    	<div class="movie-info">
        <h2><%= title %></h2>
        <p><b>Overview:</b> <%= overview %></p>
        <p><b>Release Date:</b> <%= releaseDate %></p>
        <p><b>Rating:</b> <%= rating %>/10</p>
        <p><b>Runtime:</b> <%= runtime %> minutes</p>
        <p><b>Genres:</b> 
            <%
                for (int i = 0; i < genres.length(); i++) {
                    out.print(genres.getJSONObject(i).getString("name"));
                    if (i < genres.length() - 1) out.print(", ");
                }
            %>
        </p>
<h3>Watch on</h3>
<div class="streaming-platforms">
    <% if (indiaProviders != null && indiaProviders.has("flatrate")) { 
        JSONArray flatrate = indiaProviders.getJSONArray("flatrate");
        String providerLink = indiaProviders.optString("link", "https://www.google.com/search?q=" + title.replace(" ", "+") + "+watch+online"); // Get TMDB's link
        for (int i = 0; i < flatrate.length(); i++) {
            JSONObject platform = flatrate.getJSONObject(i);
            String providerName = platform.getString("provider_name");
            String logoPath = "https://image.tmdb.org/t/p/w45" + platform.optString("logo_path", "");
    %>
            <div class="platform">
                <img src="<%= logoPath %>" alt="<%= providerName %>">
                <p><%= providerName %></p>
                <a href="<%= providerLink %>" target="_blank">Watch Now</a> <!-- Use TMDB's link -->
            </div>
    <%
        }
    } else {
    %>
        <p>No streaming platforms found for this movie.</p>
    <% } %>
</div>
</div>
	</div>

        <% if (!trailerKey.isEmpty()) { %>
        <h3>Movie Trailer</h3>
        <div class="trailer">
            <iframe width="560" height="315" src="https://www.youtube.com/embed/<%= trailerKey %>"></iframe>
        </div>
        <% } %>
        <!-- Streaming Platforms -->
         <!-- Streaming Platforms -->
         

          
      
     

        <h3>Similar Movies</h3>
        <div class="row g-4">
            <%
                for (int i = 0; i < Math.min(similarMovies.length(), 6); i++) {
                    JSONObject similarMovie = similarMovies.getJSONObject(i);
                    int similarMovieId = similarMovie.getInt("id");
                    String similarTitle = similarMovie.getString("title");
                    String similarPosterPath = "https://image.tmdb.org/t/p/w500" + similarMovie.optString("poster_path", "");
            %>
				<div class="col-md-6 col-lg-3">
                    <div class="card h-100 movie-card shadow-sm rounded-4">
                        <img src="<%= similarPosterPath %>" alt="<%= similarTitle %>" class="card-img-top">
                        <div class="card-body text-center">
                        	<p class="card-title"><%= similarTitle %></p>
                        <a href="movieDetails.jsp?id=<%= similarMovieId %>" class="btn btn-primary btn-sm mt-2">View Details</a>
                    	</div>
					</div>
				</div>                    
            <%
                }
            %>
        </div>
        
        <a href="FetchMoviesServlet" class="back">Back to Dashboard</a>
    </div>
	<%
    } catch (Exception e) {
	%>
    	<p>Error fetching movie details. Please try again.</p>
    	<a href="dashboard.jsp" class="back">Back to Dashboard</a>
	<%
    	}
	%>
	
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	
</body>
</html>

