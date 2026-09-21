class ApplicationController < ActionController::Base
  include Authentication

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  delegate :user, :account, to: :Current, prefix: :current
  helper_method :current_user, :current_account

  layout :layout_by_resource

  private

  def layout_by_resource
    controller_name.in?(%w[registrations sessions passwords invitations]) ? "auth" : "application"
  end

  stale_when_importmap_changes
end
