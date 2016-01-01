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

  scenario "should be able to remove the article" do
    create_second_test_article
    click_button "Test"
    expect(current_path).to eq '/articles_show'
    expect(page).to_not have_content "Test2"
    click_button "remove_Test"
    expect(current_path).to eq '/articles_show'
    expect(page).to_not have_content "Test"
  end

  scenario 'articles that have been removed from the show page are not deleted' do
    click_button "Test"
    click_button "remove_Test"
    articles = Article.all
    published = Article.where(published?:true)
    expect(published.count).to eq 0
    expect(articles.count).to eq 1
  end

  scenario 'published articles have a created at value' do
    click_button "Test"
    expect(current_path).to eq '/articles_show'
    time = Time.now.to_s(:long)
    expect(page).to have_content "Created: " + time
  end

  scenario 'if publshed articles have been edited, an updated time is shown' do
    click_link "view_Test"
    click_link "edit_Test"
    fill_in "article_body", with: "This is a edited article"
    time = Time.now.to_s(:long)
    click_button "Save Article"
    click_button "Test"
    expect(current_path).to eq "/articles_show"
    expect(page).to have_content "Updated: " + time
  end

end
