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
      visit '/admins/sign_up'
      fill_in('Email',with: "test@test.com")
      fill_in('Password',with: 'testtest')
      fill_in('Password confirmation', with:'testtest')
      click_button "Sign up"
      expect(page).to have_button "Create New Article"
    end
  end

  context 'when making an entry' do
    scenario 'writing an entry' do
      visit '/admins/sign_up'
      fill_in('Email',with: "test@test.com")
      fill_in('Password',with: 'testtest')
      fill_in('Password confirmation', with:'testtest')
      click_button "Sign up"
      expect(current_path).to eq '/'
      expect(page).to_not have_css("textarea")
      click_button "Create New Article"
      expect(current_path).to eq '/articles_create'
      expect(page).to have_css("textarea")
    end

    scenario 'saving an entry' do
      visit '/admins/sign_up'
      fill_in('Email',with: "test@test.com")
      fill_in('Password',with: 'testtest')
      fill_in('Password confirmation', with:'testtest')
      click_button "Sign up"
      click_button "Create New Article"
      fill_in('article', with: 'This is an Article')
      click_button 'Save Article'
      articles = Article.all
      expect(article.count).to eq 1
    end

  end
end
