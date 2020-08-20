class HomeController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  layout 'layout'
  def index
  end
end
