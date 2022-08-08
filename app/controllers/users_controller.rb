class UsersController < ApplicationController
  def login
    user = User.where(address: params[:address]).first_or_create
    session[:user_id] = user.id
    SyncUserCoinsJob.perform_later(user.address)

    redirect_to user_coins_path, notice: "Sync data successfully, please reload page after 5 minutes"
  end

  def logout
    session[:user_id] = nil if session[:user_id]

    render json: {success: true}
  end

  def coins
    @records = current_user.coins.includes(:user_coins, :users).where(user_coins: {is_hold: true}).sort_by{|c| c.users.count}.reverse
  end
end
