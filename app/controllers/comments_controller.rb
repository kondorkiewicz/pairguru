class CommentsController < ApplicationController

  def create
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to @movie
    else
      redirect_to @movie, flash: { error: @comment.errors.full_messages.first }
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.user_id != current_user.id
      redirect_to movie_path(@comment.movie)
    else
      c = @comment.destroy
      redirect_to movie_path(c.movie)
    end
  end

  def top_commenters
    @top_commenters = Comment.top_commenters
  end

  private

  def comment_params
    params.require(:comment).permit(:title, :body)
  end

end