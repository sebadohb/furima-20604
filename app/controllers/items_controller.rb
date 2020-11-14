class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_params, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit]
  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.valid?
      @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :price, :category_id, :condition_id, :delivery_charge_id, :handling_time_id, :prefecture_id).merge(user_id: current_user.id)
  end

  def set_params
    @item = Item.find(params[:id])
  end

  def correct_user
    unless current_user.id == @item.user.id
      redirect_to root_path 
    end
  end
end
