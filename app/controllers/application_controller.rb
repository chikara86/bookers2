class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top,:about]
  before_action :configure_permitted_parameters, if: :devise_controller?

def autheniticate_user
  if @current_user==nil
    flash[:notice]="ログインが必要です"
    redirect_to("/login")
  end
end

def fobid_login_user
  if @current_user
    flash[:notice]="ログインしています"
    redirect_to("/books/index")
  end
end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
