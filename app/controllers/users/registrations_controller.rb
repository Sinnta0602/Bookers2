class Users::RegistrationsController < Devise::RegistrationsController
 before_action :configure_sign_up_params, only: [:create]

 def create
#ActionController::UnknownFormat in Users::RegistrationsController#create
   super
 end

 protected

 # MEMO: deviseのコードを上書きしてる。オーバーライドという。
 def configure_sign_up_params
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
 end

 def after_sign_in_path_for(resource)
   flash[:sign_in] = "Welcome! You have signed up successfully."
   user_path(resource)
 end

 def after_sign_out_path_for(resource)
   flash[:sign_out] = "signed out successfully."
   root_path
 end
end