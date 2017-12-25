require 'open-uri'

class MovieInfo
  def call(title)
    title = title.split(" ").join("%20")
    info = open("https://pairguru-api.herokuapp.com/api/v1/movies/#{title}").read
    info = JSON.parse(info)
    info["data"]["attributes"]
  end
end