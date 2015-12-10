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

    scenario 'should be able to delete saved articles' do
      create_test_article
      click_button 'delete_Test'
      expect(Article.find_by(title: 'Test')).to eq nil
    end

    scenario 'should show the date that the article was written' do
      create_test_article
      time = Time.now.to_s(:long)
      expect(page).to have_content time
    end
  end

  context 'viewing an article before publishing' do

    scenario 'there is option to veiw and articel' do
      sign_up
      create_test_article
      expect(current_path).to eq '/articles_publish'
      expect(page).to have_link 'view_Test'
    end

    scenario 'the article is shown in a text box ready for editing' do
      sign_up
      create_test_article
      click_link 'view_Test'
      article_body = page.find_by_id('article_body')
      expect(page).to have_css("textarea#article_body")
      expect(article_body.value).to eq 'This is an Article'
    end

    scenario "an article can be changed" do
      sign_up
      create_test_article
      click_link 'view_Test'
      fill_in "article_body", with: 'This is another Article'
      click_button 'Save Article'
      articles = Article.all
      expect(articles.count).to eq 1
      expect(articles.first.body).to eq 'This is another Article'
    end

  end

end
