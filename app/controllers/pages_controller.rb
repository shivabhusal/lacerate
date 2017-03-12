class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  layout 'static'
  def home
  end
end
