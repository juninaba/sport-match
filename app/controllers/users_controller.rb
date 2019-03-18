class UsersController < ApplicationController
  def index
    @users = User.order("RAND()")
  end

  def show
    @user = User.find(params[:id])
    @detail = @user.detail
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

end
