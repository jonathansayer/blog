require 'rails_helper'

feature 'viewing blog entries' do
  context 'no entries made' do
    scenario 'should display a message saying there are no entries' do
      visit '/'
      expect(page).to have_content "No Blog Articles Available"
    end
  end

  scenario 'an entry cannot be made unless singed in' do
    visit '/articles_new'
    fill_in('Email',with: "test@test.com")
    fill_in('Password',with: 'testtest')
    expect(page).to have_button "Create New Article"
  end
end
