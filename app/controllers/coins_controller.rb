class CoinsController < ApplicationController
  before_action :get_coin, except: :index

  def index
    @records = Coin.includes(:user_coins, :users).where(user_coins: {is_hold: true}).sort_by{|c| c.users.count}.reverse
  end

  def show
    @comments = @coin.user_comments.order(created_at: :desc).page(params[:page]).per(10)
  end

  def add_comment
    @coin.user_comments.create(body: params[:comment], user_id: current_user.id, rating: params[:rating])

    redirect_to coin_path(@coin), notice: 'Comment added'
  end

  private
  def get_coin
    @coin = Coin.find params[:id]
  end
end
