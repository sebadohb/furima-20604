class Item < ApplicationRecord
  belongs_to user
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :delivery_charge
  belongs_to :handling_time
  belongs_to :prefecture
end
