module Eventplug
  module ApplicationHelper
    # Returns the name of the current controller to be used in view
    # (for js and css names). Used to convert names with slashes
    # such as 'devise/sessions'.
    def controller_name_for_view
      params[:controller].parameterize
    end
  end
end
