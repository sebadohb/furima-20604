require 'rails_helper'

RSpec.describe Customer, type: :model do
  before do
    @customer = FactoryBot.build(:customer)
  end

  describe '商品購入' do
    context '商品購入がうまく行く時' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@customer).to be_valid
      end
      it 'building_nameが空でも購入できる' do
        @customer.building_name = nil
        expect(@customer).to be_valid
      end
    end
    context '商品購入が失敗する時' do
      it 'tokenが空と保存できない' do
        @customer.token = nil
        @customer.valid?
        expect(@customer.errors.full_messages).to include("Token can't be blank")
      end
      it 'cityが空だと保存できない' do
        @customer.city = nil
        @customer.valid?
        expect(@customer.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空だと保存できない' do
        @customer.house_number = nil
        @customer.valid?
        expect(@customer.errors.full_messages).to include("House number can't be blank")
      end
      it 'post_codeが空だと保存できない' do
        @customer.post_code = nil
        @customer.valid?
        expect(@customer.errors.full_messages).to include("Post code can't be blank")
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと(ハイフン抜き)' do
        @customer.post_code = '12345678'
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Post code is invalid. Include hyphen(-) or correct style')
      end
      it 'post_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと(全角)' do
        @customer.post_code = '１２３４-７８９'
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Post code is invalid. Include hyphen(-) or correct style')
      end

      it 'prefectureを選択していないと保存できないこと' do
        @customer.prefecture_id = 1
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Prefecture should be selected')
      end
      it 'phone_numberが空だと保存できないこと' do
        @customer.phone_number = nil
        @customer.valid?
        expect(@customer.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberはハイフンは不要で、11桁以内でないと保存できない（11桁以上）' do
        @customer.phone_number = '111111111111'
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Phone number is invalid. Type correct digts or Exclude hyphen(-)')
      end
      it 'phone_numberはハイフンは不要で、11桁以内でないと保存できない（ハイフン込み）' do
        @customer.phone_number = '090-1111-1111'
        @customer.valid?
        expect(@customer.errors.full_messages).to include('Phone number is invalid. Type correct digts or Exclude hyphen(-)')
      end
    end
  end
end
