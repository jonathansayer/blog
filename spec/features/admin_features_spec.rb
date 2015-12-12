require 'rails_helper'

feature 'admin rights' do

  context "cannot write an article unless admin" do
    scenario "visiting create page redirects to index" do
      visit 'articles_create'
      expect(current_path).to eq '/'
    end

    scenario 'visiting publish page redirects to index' do
      visit 'articles_publish'
      expect(current_path).to eq '/'
    end
  end
end
