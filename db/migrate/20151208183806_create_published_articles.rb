class CreatePublishedArticles < ActiveRecord::Migration
  def change
    create_table :published_articles do |t|
      t.string :title
      t.string :body

      t.timestamps null: false
    end
  end
end
