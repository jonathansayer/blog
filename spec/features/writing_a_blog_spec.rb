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

  context 'editing an article' do

    scenario 'there is option to veiw and articel' do
      sign_up
      create_test_article
      expect(current_path).to eq '/articles_publish'
      expect(page).to have_link 'view_Test'
    end
  end

end
