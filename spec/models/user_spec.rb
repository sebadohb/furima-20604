require 'rails_helper'
describe User do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録がうまくいくとき' do
      it 'nicknameとemail、passwordとpassword_confirmation, first_nameとlast_name, first_name_kanaとlast_name_kana、birth_dateが存在すれば登録できること' do
        expect(@user).to be_valid
      end

      it 'passwordが6文字以上であれば登録できること' do
        @user.password = 'abc123'
        @user.password_confirmation = 'abc123'
        expect(@user).to be_valid
      end

      it 'first_nameが全角（漢字・ひらがな・カタカナ)であれば登録できること' do
        @user.first_name = '隆'
        expect(@user).to be_valid
        @user.first_name = 'たかし'
        expect(@user).to be_valid
        @user.first_name = 'タカシ'
        expect(@user).to be_valid
      end

      it 'last_nameが全角（漢字・ひらがな・カタカナ)であれば登録できること' do
        @user.last_name = '後藤'
        expect(@user).to be_valid
        @user.last_name = 'ごとう'
        expect(@user).to be_valid
        @user.last_name = 'ゴトウ'
        expect(@user).to be_valid
      end

      it 'first_name_kanaが全角カナであれば登録できること' do
        @user.first_name_kana = 'タカシ'
        expect(@user).to be_valid
      end

      it 'last_name_kanaが全角カナであれば登録できること' do
        @user.last_name_kana = 'ヤマダ'
        expect(@user).to be_valid
      end
    end

    context '新規登録がうまくいかないとき' do
      it 'nicknameが空では登録できないこと' do
        @user.nickname = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できないこと' do
        @user.email = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'passwordが空では登録できないこと' do
        @user.password = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank",
                                                      'Password Password Include both letters and numbers', "Password confirmation doesn't match Password")
      end

      it 'passwordが存在してもpassword_confirmationが空だと登録できないこと' do
        @user.password = 'hm12345'
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordとpassword_confirmationが不一致では登録できないこと' do
        @user.password = 'hm12345'
        @user.password_confirmation = 'tm12345'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが5文字以下であれば登録できないこと' do
        @user.password = 'hm12'
        @user.password_confirmation = 'hm12'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'first_nameが空では登録できないこと' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", 'First name Full-width characters')
      end

      it 'last_nameが空では登録できないこと' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank", 'Last name Full-width characters')
      end

      it 'first_name_kanaが空では登録できないこと' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank", 'First name kana Full-width katakana characters')
      end

      it 'last_name_kanaが空では登録できないこと' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank", 'Last name kana Full-width katakana characters')
      end

      it 'birth_dateが空では登録できないこと' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birth date can't be blank")
      end

      it 'passwordは半角英数字混合でなければ登録できないこと' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Password Include both letters and numbers')
      end

      it '重複したemailが存在する場合登録できないこと' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'first_nameが全角（漢字・ひらがな・カタカナ)でなけれな登録できないこと' do
        @user.first_name = 'ﾀｶｼ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name Full-width characters')
      end

      it 'last_nameが全角（漢字・ひらがな・カタカナ)でなけれな登録できないこと' do
        @user.last_name = 'goto'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name Full-width characters')
      end

      it 'first_name_kanaが全角カナでなければ登録できないこと' do
        @user.first_name_kana = 'ﾀｶｼ'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana Full-width katakana characters')
      end

      it 'last_name_kanaが全角カナでなければ登録できないこと' do
        @user.last_name_kana = '後藤'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana Full-width katakana characters')
      end
      it 'emailに@がないと登録できないこと' do
        @user.email = 'abcd1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
    end
  end
end
