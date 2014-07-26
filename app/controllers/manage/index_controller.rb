class Manage::IndexController < ApplicationController
  layout "manage_layout"

  def index
  end

  protected
  def secure_manage?
    ["index"].include?(action_name)
  end

end
