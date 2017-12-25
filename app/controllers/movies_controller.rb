require 'open-uri'

class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]
  before_action :load_movie, only: [:show, :send_info]

  def index
    @movies = Movie.all.decorate
  end

  def show
    @info = MovieInfo.new.call(@movie.title)
  end

  def send_info
    MovieInfoMailer.send_info(current_user, @movie).deliver_now
    redirect_to :back, notice: "Email sent with movie info"
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end

  private

  def load_movie
    @movie = Movie.find(params[:id])
  end
end
