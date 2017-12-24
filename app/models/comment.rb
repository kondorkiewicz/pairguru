# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  movie_id   :integer
#  title      :string
#  body       :text
#  created_at :datetime
#  updated_at :datetime
#

class Comment < ApplicationRecord
  validates_presence_of :title, :body, :user_id, :movie_id
  validates_uniqueness_of :user_id, scope: :movie_id,
    message: "is allowed to write only one comment under a movie."
  belongs_to :movie
  belongs_to :user

  def self.top_commenters
    # top ten commenters who have at least one comment
    User.joins(:comments)
      .where('comments.created_at >= ?', 1.week.ago.utc)
      .select('users.email, COUNT(comments.id) AS comments_count')
      .group('users.id')
      .order('comments_count desc')
      .limit(10)
  end
end