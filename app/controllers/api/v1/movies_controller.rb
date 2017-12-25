module Api
  module V1
    class MoviesController < ApplicationController
      def show
        res = fetch_movie(params[:id])
        render json: res
      end

      def index
        res = { movies: {}, genres: {} }
        fetch_movies(res)
        fetch_genres(res)
        render json: res
      end

      private

      def fetch_movie(id)
        movie = Movie.find(id)
        genre = movie.genre
        {
          "id":    movie.id.to_s,
          "title": movie.title,
          "genre": {
            "id":            genre.id.to_s,
            "title":         genre.name,
            "movies_number": genre.movies.size.to_s
          }
        }
      end

      def fetch_movies(res)
        Movie.all.each do |movie|
          res[:movies][movie.id.to_s] = movie.title
        end
      end

      def fetch_genres(res)
        Genre.includes(:movies).each do |genre|
          res[:genres][genre.id.to_s] = {
            "name": genre.name, "movies_number": genre.movies.size
          }
        end
      end
    end
  end
end