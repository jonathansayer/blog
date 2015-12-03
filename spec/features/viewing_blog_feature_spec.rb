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
      expect(page).to_not have_css("input")
      click_button "Create New Article"
      expect(page).to have_css("input")
    end
  end 
end
