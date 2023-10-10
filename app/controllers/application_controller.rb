class ApplicationController < ActionController::Base
  helper_method :current_uri
  def after_sign_in_path_for(resource)
    backroom_path
  end
  
  def after_sign_out_path_for(resource)
    backroom_path
  end

  def current_uri
    uri = request.path.split('/')
  end
end
