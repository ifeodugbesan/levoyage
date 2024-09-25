class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :toggle_dark_mode, :users]

  def home
    users_data = {}
    User.all.each { |user| users_data[user.id] = user.issues.count + user.resources.count }
    @top_users = users_data.sort_by { |k, v| v }.reverse.first(5).map { |user| User.find(user[0]) }
  end

  def users
    redirect_to root_path unless current_user.admin?
    @users = User.all
  end

  def toggle_dark_mode
    @dark_mode == true ? cookies.permanent[:dark_mode] = false : cookies.permanent[:dark_mode] = true
    redirect_to request.referrer
  end
end
