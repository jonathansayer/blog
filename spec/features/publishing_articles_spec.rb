require 'rails_helper'

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
