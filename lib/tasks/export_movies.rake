desc "Export movies csv"
task export_movies: :environment do
  file_path = "tmp/movies.csv"
  MovieExporter.new.call(ENV["USER_ID"], file_path)
end