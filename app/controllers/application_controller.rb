class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    
    def after_sign_in_path_for(resource)
        if current_user.admin?
            admin_top_path
        else
            products_path
        end
    end
  
    def after_sign_out_path_for(resource)
      new_user_session_path # ログアウト後に遷移するpathを設定
    end

    #管理者であるかを判定
    def authenticate_admin
      unless user_signed_in?
        redirect_to products_path
      else
        unless current_user.admin?
          redirect_to products_path
        end
      end
    end

    #自ユーザー以外の干渉を防ぐ
    def authenticate_correct_user
      cart = Cart.find(params[:id])
      user = cart.user
      if current_user.id != user.id
        redirect_to products_path
      end
    end

    #自ユーザー以外でも管理者は許可
    def authenticate_adm_or_correct
      order = Order.find(params[:id])
      if current_user.admin?
      elsif current_user.id != order.user.id
        redirect_to products_path
      end
    end

    def authenticate_adm_or_correct_user
      if params[:user_id]
        user = User.find(params[:user_id])
      else
        user ||= User.find(params[:id])
      end
      if current_user.admin?
      elsif current_user.id != user.id
        redirect_to products_path
      end
    end

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name_kana]) 
        devise_parameter_sanitizer.permit(:sign_up, keys: [:postcode])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:address])
        devise_parameter_sanitizer.permit(:sign_up, keys: [:phone_number])
    end
end
