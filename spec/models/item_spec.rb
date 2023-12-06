require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '新規商品出品ができるとき' do
      it 'product_nameとproduct_description、category_idとproduct_condition_id、delivery_charge_idとprefecture_id、shipping_day_idとprice、imageが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '新規商品出品ができないとき' do
      it 'product_nameが空では登録できない' do
        @item.product_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it 'product_descriptionが空では登録できない' do
        @item.product_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it 'category_idが空では登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end

      it 'product_condition_idが空では登録できない' do
        @item.product_condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end

      it 'delivery_charge_idが空では登録できない' do
        @item.delivery_charge_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end

      it 'prefecture_idが空では登録できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end

      it 'shipping_day_idが空では登録できない' do
        @item.shipping_day_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end

      it 'priceが空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください", "価格は半角数値のみを使用してください", "価格は¥300 から ¥9,999,999までの間の数字を入力してください")
      end

      it 'imageが空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end

      it '全角数字を含む販売価格では登録できない' do
        @item.price = '１１111'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は¥300 から ¥9,999,999までの間の数字を入力してください')
      end

      it '英数字を含む販売価格では登録できない' do
        @item.price = '111aa'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は¥300 から ¥9,999,999までの間の数字を入力してください')
      end

      it '全角文字を含む販売価格では登録できない' do
        @item.price = '111ああ'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は¥300 から ¥9,999,999までの間の数字を入力してください')
      end

      it '販売価格300円未満では登録できない' do
        @item.price = '299'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は¥300 から ¥9,999,999までの間の数字を入力してください')
      end

      it '販売価格9,999,999円を超える金額では登録できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は¥300 から ¥9,999,999までの間の数字を入力してください')
      end

      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
