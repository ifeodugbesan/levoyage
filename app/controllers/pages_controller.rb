class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :toggle_dark_mode]

  def home
  end

  def toggle_dark_mode
    @dark_mode == true ? cookies.permanent[:dark_mode] = false : cookies.permanent[:dark_mode] = true
    redirect_to request.referrer
  end
end
