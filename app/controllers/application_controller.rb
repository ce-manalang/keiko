class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :authenticate_user!

  private

  def require_scheduler!
    return if current_user&.scheduler?

    redirect_to root_path, alert: "Not authorized."
  end

  def require_employee!
    return if current_user&.employee?

    redirect_to root_path, alert: "Not authorized."
  end

  def after_sign_in_path_for(resource)
    dashboard_path
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end
