class IndexController < ApplicationController
  layout "application-old"

  def index
  end

  def floater
    render :partial => "index/floater"
  end

  def floater_empty
    render :partial => "index/floater_empty"
  end

end
