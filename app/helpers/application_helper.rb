module ApplicationHelper
  include TimeHelper

  # Returns `active_class` if the current controller (and optional action) matches
  # Usage: nav_active_class('public/home', nil, 'text-purple')
  #        nav_active_class('public/articles', 'show', 'font-bold')
  def nav_active_class(controller_name, action_name = nil, active_class = "active")
    if action_name
      params[:controller] == controller_name && params[:action] == action_name ? active_class : nil
    else
      params[:controller] == controller_name ? active_class : nil
    end
  end
end
