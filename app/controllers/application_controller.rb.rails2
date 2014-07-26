# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '6819235b7f468965110573ed5d7ad14a'

  # See ActionController::Base for details
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password").
  filter_parameter_logging :password

  # Pick a unique cookie name to distinguish our session data from others'
  #session :session_key => '_getyourpicksin_session_id'
  before_filter :authorize
  before_filter :authorize_manage
  #before_filter :authorize_me

  rescue_from ActionController::InvalidAuthenticityToken, :with => :bad_token

  def bad_token
    flash[:notice] = "Your session has expired"
    redirect_to(:controller => "/index", :action => "index")
  end

  def image_upload_path
    if ENV['RAILS_ENV'] == "development" then
      return Rails.public_path + "/uploads/"
    elsif ENV['RAILS_ENV'] == "production" then
      return "/home/omicronp/public_html/images.vervue.com/uploads/"
    end
  end

  protected
    # Override in controller classes that should require authentication
    def secure?
      false
    end

    def secure_manage?
      false
    end

    def secure_me?
      false
    end

  private
    def authorize
      if secure? && session[:user_id].nil? then
        session[:return_to] = request.request_uri
        redirect_to :controller => "/session", :action => "index"
        return false
      end
    end

    def authorize_manage
      if secure_manage? && session[:user_id].nil? && session[:user_roles].nil? then
        session[:return_to] = request.request_uri
        redirect_to :controller => "/session", :action => "index"
        return false
      elsif secure_manage? && !session[:user_id].nil? && !session[:user_roles].nil? && !session[:user_roles].include?("ADMIN")
        redirect_to :controller => "/index", :action => "index"
        return false
      end
    end

    def authorize_me
      if secure_me? && session[:user_id].nil? ||
          !session[:user_id].nil? && !params.nil? && !params[:id].nil? && session[:user_id].to_s == params[:id].to_s then
        session[:return_to] = request.request_uri
        redirect_to :controller => "/session", :action => "index"
        return false
      end
    end

    def login_required
      if session[:user_id]
        return true
      end
      flash[:warning] = "Please login to continue"
      session[:return_to] = request.request_uri
      redirect_to :controller => "/session", :action => "login"
      return false
    end

    def current_user
      session[:user_id]
    end

    def redirect_to_stored
      if return_to = session[:return_to]
        session[:return_to] = nil
        redirect_to(return_to)
      else
        redirect_to :controller=> "/user", :action=> "welcome"
      end
    end

    def get_offset(params)
      if !params[:offset].nil? && params[:offset].to_s.match(/^\d+$/) then
        return params[:offset].to_i
      else
        return nil
      end
    end

    def get_limit
      return 10
  end

end
