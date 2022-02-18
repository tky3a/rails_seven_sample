class ApplicationController < ActionController::Base
  helper TailwindHelper
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # サインアップ後に遷移するやつ？
  # def after_sign_up_path_for(resource)
  #   new_company_session_path
  # end

  # こっちか？
  # def after_inactive_sign_up_path_for(resource)
  #   new_company_session_path
  # end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:uid, :name, :email])
  end
end
