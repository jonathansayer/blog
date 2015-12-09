require 'rails_helper'

feature 'writing a blog' do
  context 'when making an entry' do

    before(:each) do
      sign_up
    end

    scenario 'writing an entry' do
      expect(current_path).to eq '/'
      expect(page).to_not have_css("textarea")
      click_button "Create New Article"
      expect(current_path).to eq '/articles_create'
      expect(page).to have_css("textarea")
    end

    scenario 'entering a title' do
      click_button "Create New Article"
      expect(page).to have_css("input#article_title")
    end

    scenario 'saving an entry' do
      create_test_article
      articles = Article.all
      expect(articles.count).to eq 1
    end

    # scenario 'when writing an article, the button to write and article should not appear' do
    #   visit '/admins/sign_up'
    #   fill_in('Email',with: "test@test.com")
    #   fill_in('Password',with: 'testtest')
    #   fill_in('Password confirmation', with:'testtest')
    #   click_button "Sign up"
    #   visit '/articles_create'
    #   expect(page).to_not have_button "Create New Article"
    # end
  end

  context 'when publishing an article' do

    before(:each) do
      sign_up
      create_test_article
    end

    scenario 'viewing unpublished articles' do
      expect(page).to have_content 'Test'
    end

    scenario 'publishing a saved article' do
      click_button "Publish Article"
      expect(page).to have_content "Test"
      expect(page).to have_content "This is an Article"
    end
  end
end
