class AddMovieToComments < ActiveRecord::Migration[5.1]
  def change
    add_reference :comments, :movie, foreign_key: true
  end
end
