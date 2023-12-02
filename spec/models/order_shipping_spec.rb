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
        expect(@order_shipping.errors.full_messages).to include("Post code can't be blank")
      end
      
      it '郵便番号は『３桁ハイフン４桁』半角英数字でないと保存できないこと' do
        @order_shipping.post_code = '123-123４'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end
      
      it '都道府県に「---」が選択されている場合は購入できないこと' do
        @order_shipping.prefecture_id = ' '
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Prefecture can't be blank")
      end
      
      it '市区町村が空だと購入できないこと' do
        @order_shipping.municipalities = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Municipalities can't be blank")
      end
      
      it '番地が空だと購入できないこと' do
        @order_shipping.street_address = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Street address can't be blank")
      end
      
      it '電話番号が空だと購入できないこと' do
        @order_shipping.telephone_number = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Telephone number can't be blank")
      end
      
      it '電話番号が9桁以下だと購入できないこと' do
        @order_shipping.telephone_number = '090123456'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Telephone number is too short (minimum is 10 characters)")
      end
      
      it '電話番号が12桁以上だと購入できない' do
        @order_shipping.telephone_number = '090123456789'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Telephone number is too long (maximum is 11 characters)")
      end
      
      it '電話番号が半角数値でないと購入できないこと' do
        @order_shipping.telephone_number = '０9012341234'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Telephone number is invalid. Please enter numbers only")
      end
      
      it 'tokenが空では購入できないこと' do
        @order_shipping.token = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Token can't be blank")
      end
      
      it 'userが紐づいていなければ購入できないこと' do
        @order_shipping.user_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("User can't be blank")
      end
      
      it 'itemが紐づいていなければ購入できないこと' do
        @order_shipping.item_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end