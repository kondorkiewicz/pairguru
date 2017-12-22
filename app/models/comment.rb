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
  validates_uniqueness_of :user_id, scope: :movie_id
  belongs_to :movie
  belongs_to :user
end