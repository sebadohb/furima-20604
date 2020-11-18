class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create, :move_to_index]
  before_action :move_to_index, only: [:index]
  def index
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.valid?
      pay_item
      @customer.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:post_code, :city, :prefecture_id, :house_number, :building_name, :phone_number).merge(item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: customer_params[:token],
      currency: 'jpy'
    )
  end

  def move_to_index
    if current_user.id == @item.user_id || @item.purchase.present?
       redirect_to root_path
    end
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
