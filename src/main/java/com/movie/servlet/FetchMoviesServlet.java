package com.movie.servlet;

import jakarta.servlet.*;
import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

//@WebServlet("/FetchMoviesServlet")
public class FetchMoviesServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String apiKey = "bc9d6c9e05d6a8bf2e7c801e657445ba";
        String popularMoviesApi = "https://api.themoviedb.org/3/movie/popular?api_key=" + apiKey;
        String trendingMoviesApi = "https://api.themoviedb.org/3/trending/movie/day?api_key=" + apiKey;
        String bollywoodMoviesApi = "https://api.themoviedb.org/3/discover/movie?api_key=" + apiKey + "&region=IN&with_original_language=hi";
        String marathiMoviesApi = "https://api.themoviedb.org/3/discover/movie?api_key=" + apiKey + "&region=IN&with_original_language=mr";

        // Fetch Movies
        request.setAttribute("movies", fetchMoviesFromApi(popularMoviesApi));
        request.setAttribute("trendingMovies", fetchMoviesFromApi(trendingMoviesApi));
        request.setAttribute("bollywoodMovies", fetchMoviesFromApi(bollywoodMoviesApi));
        request.setAttribute("marathiMovies", fetchMoviesFromApi(marathiMoviesApi));

        RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard.jsp");
        dispatcher.forward(request, response);
    }

    private String fetchMoviesFromApi(String apiUrl) throws IOException {
        URL url = new URL(apiUrl);
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");

        BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        String inputLine;
        StringBuilder content = new StringBuilder();
        while ((inputLine = reader.readLine()) != null) {
            content.append(inputLine);
        }
        reader.close();

        return content.toString();
    }
}
