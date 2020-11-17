class Order < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # with_options presence: true do
  #   validates :post_code
  #   validates :city
  #   validates :house_number
  #   validates :phone_number
  # end
  # validates :prefecture_id,  numericality: { other_than: 1, message: 'should be selected' }
  # validates :post_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: 'を入力してください' }
  # validates :phone_number, format: { with: /\A\d{10}\z/, message: 'を入力してください' }
  belongs_to :purchase
  belongs_to_active_hash :prefecture
end
