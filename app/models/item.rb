class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  validates :name, :description, :price, :image, presence: true
  validates :price, numericality: {
    :greater_than_or_equal_to => 300, 
    :less_than_or_equal_to => 9999999,
    message: 'out of setting price'
  }

  validates :price, numericality: { only_integer: true,
    message: 'is incorrect, must be rewritten'
  }


  validates :category_id,  numericality: { other_than: 1, message: 'should be selected' }
  validates :condition_id, numericality: { other_than: 1, message: 'should be selected' }
  validates :handling_time_id, numericality: { other_than: 1, message: 'should be selected' }
  validates :prefecture_id, numericality: { other_than: 1, message: 'should be selected' }
  validates :delivery_charge_id, numericality: { other_than: 1, message: 'should be selected' }
  belongs_to :user
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_charge
  belongs_to_active_hash :handling_time
  belongs_to_active_hash :prefecture
  has_one_attached :image
end
