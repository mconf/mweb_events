class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!

  skip_before_filter :authenticate_user!, :if => Proc.new {
    # Just so we can only test what matters in the spec files
    ENV["RAILS_ENV"] == 'test' ||
    # Don't ask for login on event show and register
    controller_name == 'events' && params[:action] == 'index' ||
    controller_name == 'events' && params[:action] == 'show' ||
    controller_name == 'participants' && params[:action] == 'new' ||
    controller_name == 'participants' && params[:action] == 'create'
  }


  # Get engine authorizations
  before_filter do
    current_ability.merge(MwebEvents::Ability.new(current_user))
  end

  rescue_from CanCan::AccessDenied do |exception|
    if current_user.nil?
      redirect_to main_app.new_user_session_path, :alert => exception.message
    else
      redirect_to main_app.root_path, :alert => exception.message
    end
  end

  around_filter :user_time_zone, :if => :current_user

  def user_time_zone(&block)
    Time.use_zone(current_user.time_zone, &block)
  end
end
