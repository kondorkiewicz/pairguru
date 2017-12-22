require "rails_helper"

describe Comment do
  before do
    @comment = Comment.create(movie_id: 1, user_id: 1)
  end

  it "is invalid when user already commented a movie" do
    duplicate_comment = @comment.dup
    expect(duplicate_comment).to be_invalid
  end

  it "is valid when user_id is unique in scope of a movie" do
    expect(Comment.new(movie_id:1, user_id: 2)).to be_valid
  end

  it "is valid when movie_id is unique in scope of a user" do
    expect(Comment.new(movie_id: 2, user_id: 1)).to be_valid
  end
end