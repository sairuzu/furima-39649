require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it 'nicknameとemail、passwordとpassword_confirmation、お名前(全角)とお名前カナ(全角)、生年年月日が存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '123aa'
        @user.password_confirmation = '123aa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123aaa'
        @user.password_confirmation = '123aaa7'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it '英字のみのパスワードでは登録できない' do
        @user.password = 'aaabbb'
        @user.password_confirmation = 'aaabbb'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it '数字のみのパスワードでは登録できない' do
        @user.password = '000111'
        @user.password_confirmation = '000111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'ｔｔｔ111'
        @user.password_confirmation = 'ｔｔｔ111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字を入力してください", "名字は全角（漢字・ひらがな・カタカナ）を使用してください")
      end

      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前を入力してください", "名前は全角（漢字・ひらがな・カタカナ）を使用してください")
      end

      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名字（カナ）を入力してください", "名字（カナ）は全角カタカナを使用してください")
      end

      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("名前（カナ）を入力してください", "名前（カナ）は全角カタカナを使用してください")
      end

      it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.last_name = 'Smith'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字は全角（漢字・ひらがな・カタカナ）を使用してください')
      end

      it 'お名前(全角)は、全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.first_name = 'John'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前は全角（漢字・ひらがな・カタカナ）を使用してください')
      end

      it 'お名前カナ(全角)は、全角（カタカナ）でないと登録できない' do
        @user.last_name_kana = 'Smith'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字（カナ）は全角カタカナを使用してください')
      end

      it 'お名前カナ(全角)は、全角（カタカナ）でないと登録できない' do
        @user.first_name_kana = 'John'
        @user.valid?
        expect(@user.errors.full_messages).to include('名前（カナ）は全角カタカナを使用してください')
      end

      it 'パスワードは、半角英数字混合でないと登録できない' do
        @user.password = '000000'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません", "パスワードは不正な値です")
      end

      it '生年月日が空だと登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
