<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.io.*, java.net.*, org.json.*" %>

<%
    String typeMoviesJson = (String) request.getAttribute("typeMovies");
%>

<h3>Selected Type Movies</h3>
<div class="movie-list">
    <%
        if (typeMoviesJson != null) {
            try {
                JSONObject jsonObj = new JSONObject(typeMoviesJson);
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
                <p>Error loading movies by type. Please try again.</p>
    <%
            }
        } else {
    %>
        <p>No movies available for the selected type at the moment.</p>
    <%
        }
    %>
</div>
