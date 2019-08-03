class PagesController < ApplicationController
  def home
    redirect_to reports_path if logged_in?
  end
end
