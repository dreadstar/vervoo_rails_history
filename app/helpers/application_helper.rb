# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def page_title
    @page_title || controller.action_name
  end

  def page_type
    @page_type || controller.controller_name
  end

  def urlencode(str)
    str.gsub(/[^a-zA-Z0-9_\.\-]/n) {|s| sprintf('%%%02x', s[0]) }
  end

end
