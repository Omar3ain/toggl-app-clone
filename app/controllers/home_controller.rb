class HomeController < ApplicationController
  def index
    @user = current_user
    @projects =  @user.projects
  end
end
