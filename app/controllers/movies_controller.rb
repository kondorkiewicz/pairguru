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
    MovieInfoMailer.send_info(current_user, @movie).deliver_later
    redirect_back fallback_location: root_path, notice: "Email sent with movie info"
  end

  def export
    system "rake export_movies USER_ID=#{current_user.id} &"
    redirect_to root_path, notice: "Exporting movies"
  end

  private

  def load_movie
    @movie = Movie.find(params[:id])
  end
end
