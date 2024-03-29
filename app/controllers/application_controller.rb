class ApplicationController < ActionController::Base
    include Pagy::Backend
    include ApplicationHelper
    protect_from_forgery with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_notifications, if: :current_user

    protected
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :phoneno, :address, :position, :profile_pic, :role, :public_id)}

        devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password, :phoneno, :address, :position, :profile_pic, :role, :public_id)}
    end

    def after_sign_in_path_for(resource)
        home_index_path
    end

    private
    def set_notifications
        @unread = Notification.where(recipient: current_user).newest_first.limit(9).unread
        @read = Notification.where(recipient: current_user).newest_first.limit(9).read
    end
end
