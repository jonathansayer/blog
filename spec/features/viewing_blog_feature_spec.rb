require 'rails_helper'

feature 'viewing blog entries' do
  context 'no entries made' do
    scenario 'should display a message saying there are no entries' do
      visit '/'
      expect(page).to have_content "No Blog Articles Available"
    end
  end

  context 'an entry cannot be made unless signed in' do
    scenario 'not signed in' do
      visit '/'
      expect(page).to_not have_button "Create New Article"
    end

    scenario 'signing in' do
      sign_up
      expect(page).to have_button "Create New Article"
    end
  end

  context "when articles are published" do

    before(:each) do
      sign_up
      create_test_article
    end

    scenario "when an article are published, the error message should not appear" do
      click_button "Test"
      expect(page).to_not have_content "No Blog Articles Available"
    end

    scenario "publishing individual articles" do
      visit '/'
      create_second_test_article
      click_button "Test2"
      expect(page).to have_content "This is another Article"
      expect(page).to_not have_content "This is an Article"
    end

    scenario "can remove article once published" do
      click_button "Test"
      click_button "remove_Test"
      expect(page).to_not have_content "Test"
    end

    scenario "when an article in published, the no article not on the index page disappears" do
      click_button "Test"
      visit '/'
      expect(page).to_not have_content "No Blog Articles Available"
    end
  end
end


def sign_up
  visit '/admins/sign_up'
  fill_in('Email',with: "test@test.com")
  fill_in('Password',with: 'testtest')
  fill_in('Password confirmation', with:'testtest')
  click_button "Sign up"
end

def create_test_article
  click_button "Create New Article"
  fill_in('article_title', with: 'Test')
  fill_in('article_body', with: 'This is an Article')
  click_button 'Save Article'
end

def create_second_test_article
  click_button "Create New Article"
  fill_in('article_title', with: 'Test2')
  fill_in('article_body', with: 'This is another Article')
  click_button 'Save Article'
end
