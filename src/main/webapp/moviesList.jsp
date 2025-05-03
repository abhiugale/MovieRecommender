<%@ page import="org.json.*" %>
<%
    String moviesJson = request.getParameter("moviesJson");
    if (moviesJson != null) {
        try {
            JSONObject jsonObj = new JSONObject(moviesJson);
            JSONArray movies = jsonObj.getJSONArray("results");
%>
            
            <div class="row g-4">
            <% 
                for (int i = 0; i < movies.length(); i++) {
                    JSONObject movie = movies.getJSONObject(i);
                    String title = movie.getString("title");
                    String posterPath = "https://image.tmdb.org/t/p/w500" + movie.optString("poster_path", "");
                    int movieId = movie.getInt("id");
            %>
                <div class="col-md-6 col-lg-3">
                    <div class="card h-100 movie-card shadow-sm rounded-4">
                        <img src="<%= posterPath %>" class="card-img-top" alt="<%= title %>">
                        <div class="card-body text-center">
                            <h5 class="card-title"><%= title %></h5>
                            <a href="movieDetails.jsp?id=<%= movieId %>" class="btn btn-primary btn-sm mt-2">View Details</a>
                        </div>
                    </div>
                </div>
            <% } %>
        </div>
<%
        } catch (JSONException e) {
        	 %>
            <p>Error loading movies. Please try again.</p>
<%
        }
    } else {
%>
    <p>No movies available at the moment.</p>
<%
    }
%>
