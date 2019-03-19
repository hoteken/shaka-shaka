class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :configure_permitted_parameters
    def after_sign_in_path_for(resource)
      products_path # ログイン後に遷移するpathを設定
    end
  
    def after_sign_out_path_for(resource)
      new_user_session_path # ログアウト後に遷移するpathを設定
    end
    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:name_kana]) 
        devise_parameter_sanitizer.permit(:sign_up, keys: [:postcode])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:address])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number])
    end
end
