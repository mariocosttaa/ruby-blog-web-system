class Panel::DashboardController < ApplicationController
  before_action :authenticate_user!  # protege todas as actions
  layout "panel/panel_layout"
  def index
  end
end
