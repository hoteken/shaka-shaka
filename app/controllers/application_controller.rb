class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def after_sign_in_path_for(resource)
        if current_user.admin?
            admin_top_path
        else
            user_session_path
        end
    end
  
    def after_sign_out_path_for(resource)
      new_user_session_path # ログアウト後に遷移するpathを設定
    end
    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name_kana]) 
        devise_parameter_sanitizer.permit(:sign_up, keys: [:postcode])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:address])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number])
    end
    def admin_user
        redirect_to(products_path) unless current_user.admin?
    end
end
