require 'rails_helper'

RSpec.describe FormOrder, type: :model do
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @form_order = FactoryBot.build(:form_order, user_id: user.id, item_id: item.id)
  end

  describe '配送先情報の保存' do
    context '配送先情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@form_order).to be_valid
      end
      it 'user_idが空でなければ保存できる' do
        @form_order.user_id = 1
        expect(@form_order).to be_valid
      end
      it 'item_idが空でなければ保存できる' do
        @form_order.item_id = 1
        expect(@form_order).to be_valid
      end
      it '郵便番号が「3桁+ハイフン+4桁」の組み合わせであれば保存できる' do
        @form_order.delivery_zipcode = '123-4560'
        expect(@form_order).to be_valid
      end
      it '都道府県が「---」以外かつ空でなければ保存できる' do
        @form_order.delivery_prefecture_id = 2
        expect(@form_order).to be_valid
      end
      it '市区町村が空でなければ保存できる' do
        @form_order.delivery_city = '横浜市'
        expect(@form_order).to be_valid
      end
      it '番地が空でなければ保存できる' do
        @form_order.delivery_address = '旭区１２３'
        expect(@form_order).to be_valid
      end
      it '建物名が空でも保存できる' do
        @form_order.delivery_building = nil
        expect(@form_order).to be_valid
      end
      it '電話番号が11番桁以内かつハイフンなしであれば保存できる' do
        @form_order.delivery_phone = 12_345_678_910
        expect(@form_order).to be_valid
      end
    end

    context '配送先情報の保存ができないとき' do
      it 'user_idが空だと保存できない' do
        @form_order.user_id = nil
        @form_order.valid?
        expect(@form_order.errors.full_messages).to include
      end
      it 'item_idが空だと保存できない' do
        @form_order.item_id = nil
        @form_order.valid?
        expect(@form_order.errors.full_messages).to include
      end
      it '郵便番号が空だと保存できないこと' do
        @form_order.delivery_zipcode = nil
        @form_order.valid?
        expect(@form_order.errors.full_messages).to include("Delivery zipcode can't be blank",
                                                            'Delivery zipcode Postal code is invalid.Enter it as follows (e.g. 123-4567)')
      end
      it '郵便番号にハイフンがないと保存できないこと' do
        @form_order.delivery_zipcode = 1_234_567
        @form_order.valid?
        expect(@form_order.errors.full_messages).to include('Delivery zipcode Postal code is invalid.Enter it as follows (e.g. 123-4567)')
      end
      it '都道府県が「---」だと保存できないこと' do
        @form_order.delivery_prefecture_id = 0
        @form_order.valid?
        expect(@form_order.errors.full_messages).to include
      end
      it '都道府県が空だと保存できないこと' do
        @form_order.delivery_prefecture_id = nil
        @form_order.valid?
        expect(@form_order.errors.full_messages).to include("Delivery prefecture can't be blank")
      end
      it '市区町村が空だと保存できないこと' do
        @form_order.delivery_city = nil
        @form_order.valid?
        expect(@form_order.errors.full_messages).to include("Delivery city can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @form_order.delivery_address = nil
        @form_order.valid?
        expect(@form_order.errors.full_messages).to include("Delivery address can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @form_order.delivery_phone = nil
        @form_order.valid?
        expect(@form_order.errors.full_messages).to include("Delivery phone can't be blank")
      end
      it '電話番号にハイフンがあると保存できないこと' do
        @form_order.delivery_phone = '123 - 1234 - 1234'
        @form_order.valid?
        expect(@form_order.errors.full_messages).to include
      end
      it '電話番号が9桁以下では保存できないこと' do
        @form_order.delivery_phone = 12_345_67
        @form_order.valid?
        expect(@form_order.errors.full_messages).to include
      end
      it '電話番号が12桁以上あると保存できないこと' do
        @form_order.delivery_phone = 12_345_678_910_123_111
        @form_order.valid?
        expect(@form_order.errors.full_messages).to include
      end
      it 'トークンが空だと保存できないこと' do
        @form_order.token = nil
        @form_order.valid?
        expect(@form_order.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
