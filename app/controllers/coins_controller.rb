class CoinsController < ApplicationController
  before_action :get_coin

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
