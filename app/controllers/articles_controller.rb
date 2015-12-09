class ArticlesController < ApplicationController

  def index
    @published = PublishedArticle.all
    render 'show'
  end

  def new
    redirect_to articles_create_path
  end

  def create
  end

  def save
    article = params[:article]
    Article.create(title:article[:title], body: article[:body])
    redirect_to articles_publish_path
  end

  def publish
    @articles = Article.all
  end

  def show
    if params[:title] != nil and params[:body] != nil
      PublishedArticle.create(title: params[:title], body: params[:body])
    end
    @published = PublishedArticle.all
  end

  def remove
    title = params[:title]
    body = params[:body]
    article_id = PublishedArticle.find_by(title: title, body: body).id
    PublishedArticle.delete(article_id)
    redirect_to articles_show_path
  end

end
