require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe 'アイテム出品時' do
    context '商品出品がうまく行く時' do
      it '全てのカラムに情報が入っている時' do
        expect(@item).to be_valid
      end
    end

    context '商品出品が失敗する時' do
      it '商品画像がない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it '商品名がない' do
        @item.name = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it '商品の説明がない' do
        @item.description = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end

      it 'カテゴリーの情報がない' do
        @item.category_id = nil
        @item.valid?
        @item.category_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include 'Category should be selected'
      end

      it '商品の状態についての情報がない' do
        @item.condition_id = nil
        @item.valid?
        @item.condition_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include 'Condition should be selected'
      end

      it '配送料の負担についての情報がない' do
        @item.delivery_charge_id = nil
        @item.valid?
        @item.delivery_charge_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include 'Delivery charge should be selected'
      end

      it '発送までの日数についての情報がない' do
        @item.handling_time_id = nil
        @item.valid?
        @item.handling_time_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include 'Handling time should be selected'
      end

      it '発送元についての情報がない' do
        @item.prefecture_id = nil
        @item.valid?
        @item.prefecture_id = "1"
        @item.valid?
        expect(@item.errors.full_messages).to include 'Prefecture should be selected'
      end

      it '価格についての情報がない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include "Price can't be blank"
      end

      it '価格の範囲が¥300以下の時' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price out of setting price'
      end

      it '価格の範囲が¥9,999,999以上のとき' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price out of setting price'
      end

      it '販売価格が半角数字以外の時(全角)' do
        @item.price = '３０００'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is incorrect, must be rewritten'
      end

      it '販売価格が半角数字以外の時(英語)' do
        @item.price = 'abcd'
        @item.valid?
        expect(@item.errors.full_messages).to include 'Price is incorrect, must be rewritten'
      end

      it 'userが紐付いていないと保存できないこと' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include 'User must exist'
      end
    end
  end
end
