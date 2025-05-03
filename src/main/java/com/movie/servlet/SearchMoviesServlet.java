package com.movie.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.io.BufferedReader;
import java.io.InputStreamReader;

//@WebServlet("/SearchMoviesServlet")
public class SearchMoviesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");

        if (query == null || query.trim().isEmpty()) {
            response.sendRedirect("dashboard.jsp?error=Please enter a movie name");
            return;
        }

        String apiKey = "bc9d6c9e05d6a8bf2e7c801e657445ba";
        String apiUrl = "https://api.themoviedb.org/3/search/movie?api_key=" + apiKey + "&query=" + query.replace(" ", "%20");

        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        StringBuilder content = new StringBuilder();
        String inputLine;
        while ((inputLine = reader.readLine()) != null) {
            content.append(inputLine);
        }
        reader.close();

        request.setAttribute("movies", content.toString());
        RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard.jsp");
        dispatcher.forward(request, response);
    }
}
