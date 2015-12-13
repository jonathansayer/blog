module ArticlesHelper

  def check_if_signed_in
    if !admin_signed_in?
      redirect_to root_path
      flash[:error] = "You are not signed in as an administrator"
    end
  end
end
