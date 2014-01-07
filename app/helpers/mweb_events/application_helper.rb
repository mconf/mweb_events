module MwebEvents
  module ApplicationHelper
    # Returns the name of the current controller to be used in view
    # (for js and css names). Used to convert names with slashes
    # such as 'devise/sessions'.
    def controller_name_for_view
      params[:controller].parameterize
    end

    def bootstrap_class_for flash_type
      types = {
        :success => 'alert-success',
        :error => 'alert-error',
        :alert => 'alert-block',
        :notice => 'alert-info'
      }
      flash_type ? types[flash_type] : flash_type.to_s
    end
  end
end
