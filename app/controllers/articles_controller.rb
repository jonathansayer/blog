class ArticlesController < ApplicationController

  def index
    @published = Article.where(published?: true)
    flash[:notice] = "No Blog Articles Available"
    render 'show'
  end

  def new
    redirect_to articles_create_path
  end

  def create
    redirect_to root_path if !admin_signed_in?
  end

  def save
    article = params[:article]
    Article.create(title:article[:title], body: article[:body])
    redirect_to articles_publish_path
  end

  def publish
    redirect_to root_path if !admin_signed_in?
    @published = Article.where(published?: true)
    @articles = Article.all
  end

  def show
    if params[:title] != nil and params[:body] != nil
      article = Article.find_by(title: params[:title], body: params[:body])
      article.update_attribute(:published?, true)
    end
    @published = Article.where(published?: true)
  end

  def remove
    title, body = params[:title], params[:body]
    article = Article.find_by(title: params[:title], body: params[:body])
    article.update_attribute(:published?, false)
    redirect_to articles_show_path
  end

  def delete
    title, body = params[:title], params[:body]
    article_id = Article.find_by(title: title, body: body).id
    Article.delete(article_id)
    flash[:notice] = "No Blog Articles Available"
    redirect_to articles_publish_path
  end

  def display
    @article = Article.find_by(title: params[:title], body: params[:body])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    article = Article.find_by(id:params[:id])
    article.update_attribute(:title, params[:title])
    article.update_attribute(:body, params[:article][:body])
    redirect_to articles_publish_path
  end

end
