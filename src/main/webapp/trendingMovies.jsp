<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*, java.net.*, org.json.*" %>
<%
    String trendingMoviesJson = (String) request.getAttribute("trendingMovies");
%>
<!--  <h3>Trending Movies</h3> -->
<div class="movie-list">
    <%
        if (trendingMoviesJson != null) {
            try {
                JSONObject jsonObj = new JSONObject(trendingMoviesJson);
                JSONArray movies = jsonObj.getJSONArray("results");

                for (int i = 0; i < movies.length(); i++) {
                    JSONObject movie = movies.getJSONObject(i);
                    int movieId = movie.getInt("id");
                    String title = movie.getString("title");
                    String posterPath = "https://image.tmdb.org/t/p/w500" + movie.optString("poster_path", "");
    %>
                    <div class="movie">
                        <img src="<%= posterPath %>" alt="<%= title %>">
                        <p><%= title %></p>
                        <a href="movieDetails.jsp?id=<%= movieId %>">View Details</a>
                    </div>
    <%
                }
            } catch (JSONException e) {
    %>
                <p>Error loading trending movies. Please try again.</p>
    <%
            }
        } else {
    %>
        <p>No trending movies available at the moment.</p>
    <%
        }
    %>
</div>
