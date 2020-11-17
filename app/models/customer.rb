class Customer
  include ActiveModel::Model
  attr_accessor :post_code, :city, :building_name, :house_number, :phone_number, :prefecture_id, :token, :user_id, :item_id

  with_options presence: true do
    validates :city
    validates :house_number
    validates :token
    validates :post_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :phone_number, format: {with: /\A\d{10,11}\z/, message: "is invalid. Type correct digts or Exclude hyphen(-)"}
  end

  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Order.create(post_code: post_code, prefecture_id: prefecture_id, city: city, building_name: building_name, house_number: house_number, phone_number: phone_number, purchase_id: purchase.id)
  end
end