require "rails_helper"
Warden.test_mode!

describe "Comments requests", type: :request do
  let(:movie) { FactoryGirl.create(:movie) }
  let(:user) { FactoryGirl.build(:user) }

  before do
    login_as(user, scope: :user)
  end

  describe "#create" do
    context "first users's comment" do
      it "redirects to movie with newly created comment" do
        post "/comments", params: { movie_id: movie.id,
          comment: FactoryGirl.attributes_for(:comment) }
        expect(response).to redirect_to(movie)
        follow_redirect!
        expect(response.body).to match /<h4>Comments:/
        expect(response.body).to match /#{user.email}/
      end
    end

    context "second users's comment" do
      before { FactoryGirl.create(:comment, user: user, movie: movie) }
      it "redirects to movie with flash error" do
        post "/comments", params: { movie_id: movie.id,
          comment: FactoryGirl.attributes_for(:comment) }
        expect(response).to redirect_to(movie)
        follow_redirect!
        expect(flash[:error]).to eq "You've already wrote a comment!"
      end
    end
  end
end