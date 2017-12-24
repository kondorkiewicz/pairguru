require "rails_helper"

describe Comment do

  describe "database columns" do
    it { should have_db_column(:id) }
    it { should have_db_column(:title) }
    it { should have_db_column(:body) }
    it { should have_db_column(:user_id) }
    it { should have_db_column(:movie_id) }
    it { should have_db_column(:created_at) }
    it { should have_db_column(:updated_at) }
  end

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:movie_id) }
    it {
      should validate_uniqueness_of(:user_id).scoped_to(:movie_id)
        .with_message("is allowed to write only one comment under a movie.")
    }
  end

  describe ".top_commenters" do
    let(:users) { create_list(:user, 11) }
    before { users.each { |user| create_list(:comment, user.id, user: user) } }
    it {
      top_commenters = Comment.top_commenters
      expect(top_commenters.length).to eq(10)
      expect(top_commenters.first.email).to eq(users.last.email)
    }

  end

end