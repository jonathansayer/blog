require 'rails_helper'

feature 'viewing blog entries' do
  context 'no entries made' do
    scenario 'should display a message saying there are no entries' do
      visit '/'
      expect(page).to have_content "No Blog Articles Available"
    end
  end
end
