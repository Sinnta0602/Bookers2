class Users::RegistrationsController < Devise::RegistrationsController
 before_action :configure_sign_up_params, only: [:create]

 def create
#ActionController::UnknownFormat in Users::RegistrationsController#create
   super
 end

 protected

 def configure_sign_up_params
   devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
 end
end