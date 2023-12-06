require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  describe '商品購入記録の保存' do
    before do
       user = FactoryBot.create(:user)
       item = FactoryBot.create(:item)
       @order_shipping = FactoryBot.build(:order_shipping,user_id: user.id, item_id: item.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば購入できること' do
        expect(@order_shipping).to be_valid
      end
      
      it '建物名が空でも購入できること' do
        @order_shipping.building_name = ''
        expect(@order_shipping).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it '郵便番号は空では保存できないこと' do
        @order_shipping.post_code = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("郵便番号を入力してください", "郵便番号は(-)を使用してください")
      end
      
      it '郵便番号は『３桁ハイフン４桁』半角英数字でないと保存できないこと' do
        @order_shipping.post_code = '123-123４'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("郵便番号は(-)を使用してください")
      end
      
      it '都道府県は空では購入できないこと' do
        @order_shipping.prefecture_id = ' '
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("都道府県を入力してください")
      end

      it '都道府県に「---」が選択されている場合は購入できないこと' do
        @order_shipping.prefecture_id = '---'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("都道府県は予約されています")
      end
      
      it '市区町村が空だと購入できないこと' do
        @order_shipping.municipalities = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("市区町村を入力してください")
      end
      
      it '番地が空だと購入できないこと' do
        @order_shipping.street_address = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("番地を入力してください")
      end
      
      it '電話番号が空だと購入できないこと' do
        @order_shipping.telephone_number = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("電話番号を入力してください", "電話番号は半角数字のみを使用してください", "電話番号は10文字以上で入力してください")
      end
      
      it '電話番号が9桁以下だと購入できないこと' do
        @order_shipping.telephone_number = '090123456'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("電話番号は10文字以上で入力してください")
      end
      
      it '電話番号が12桁以上だと購入できない' do
        @order_shipping.telephone_number = '090123456789'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("電話番号は11文字以内で入力してください")
      end
      
      it '電話番号が半角数値でないと購入できないこと' do
        @order_shipping.telephone_number = '０9012341234'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("電話番号は半角数字のみを使用してください")
      end
      
      it 'tokenが空では購入できないこと' do
        @order_shipping.token = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      
      it 'userが紐づいていなければ購入できないこと' do
        @order_shipping.user_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Userを入力してください")
      end
      
      it 'itemが紐づいていなければ購入できないこと' do
        @order_shipping.item_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end