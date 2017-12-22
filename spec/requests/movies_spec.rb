require "rails_helper"

describe "Movies requests", type: :request do

  describe "movies list" do
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end
  end

  describe "single movie" do
    context "without comments" do
      let(:movie) { FactoryGirl.create(:movie) }
      it "shows movie's title" do
        visit "movies/#{movie.id}"
        expect(page).to have_content("#{movie.title}")
        expect(page).to have_no_content("Comments:")
      end
    end

    context "with comments" do
      let(:movie) { FactoryGirl.create(:movie, :with_comments) }
      it "shows movie's comments" do
        visit "movies/#{movie.id}"
        expect(page).to have_content("Comments:")
        expect(page).not_to have_content("What do you think about this movie?")
      end
    end

    context "user logged_in" do
      let(:movie) { FactoryGirl.create(:movie) }
      let(:user) { FactoryGirl.create(:user) }
      before { login_as(user, scope: :user) }
      it "allows user to comment" do
        visit "/movies/#{movie.id}"
        expect(page).to have_content("What do you think about this movie?")
      end
    end
  end

end
