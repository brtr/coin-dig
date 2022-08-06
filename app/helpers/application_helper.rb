module ApplicationHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def date_format(datetime)
    datetime.strftime('%Y-%m-%d')
  end

  def address_format(address)
    address[-8..-1]
  end

  def decimal_format(data)
    data.to_f.round(3)
  end

  def home_path
    current_user ? user_coins_path : root_path
  end
end
