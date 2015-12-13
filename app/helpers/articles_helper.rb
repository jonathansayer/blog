module ArticlesHelper

  def check_if_signed_in
    if !admin_signed_in?
      redirect_to root_path
      flash[:error] = "You are not signed in as an administrator"
    end
  end

  def any_published_articles?
    if Article.where(published?: true).count == 0
      flash[:notice] = "No Blog Articles Available"
      return true
    end
    false
  end

end
