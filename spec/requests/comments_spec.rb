require "rails_helper"
Warden.test_mode!

describe "Comments requests", type: :request do
  let(:movie) { FactoryGirl.create(:movie) }
  let(:user) { FactoryGirl.create(:user, id: 2) }

  before do
    login_as(user, scope: :user)
  end

  describe "#create" do
    context "first users's comment" do
      it "redirects to movie with newly created comment" do
        expect {
          post "/comments", params: { movie_id: movie.id,
            comment: FactoryGirl.attributes_for(:comment) }
        }.to change(Comment, :count).by(1)
        expect(response).to redirect_to(movie)
        follow_redirect!
        expect(response.body).to match /<h4>Comments:/
        expect(response.body).to match /#{user.email}/
      end
    end

    context "second users's comment" do
      before { FactoryGirl.create(:comment, user_id: user.id, movie_id: movie.id) }
      it "redirects to movie with flash error" do
        expect {
          post "/comments", params: { movie_id: movie.id,
            comment: FactoryGirl.attributes_for(:comment) }
        }.not_to change(Comment, :count)

        expect(response).to redirect_to(movie)
        follow_redirect!
        expect(flash[:error])
          .to eq "User is allowed to write only one comment under a movie."
      end
    end
  end

  describe "#destroy" do
    context "logged in user" do
      it "deletes his own comment" do
        comment = FactoryGirl.create(:comment, user_id: 2, movie: movie)
        expect { delete "/comments/#{comment.id}" }.to change(Comment, :count).by(-1)
        expect(response).to redirect_to(movie)
      end

      it "doesn't delete someone else's comment" do
        comment = FactoryGirl.create(:comment, user_id: 1, movie: movie)
        expect { delete "/comments/#{comment.id}" }.not_to change(Comment, :count)
        expect(response).to redirect_to(movie)
      end
    end
  end

  describe "#top_commenters" do
    let(:users) { create_list(:user, 11) }
    before { users.each { |user| create_list(:comment, user.id, user: user) } }
    it "displays only top ten commenters" do
      visit "/top_commenters"
      expect(page).to have_selector("table tr", count: 10)
    end
  end
end
