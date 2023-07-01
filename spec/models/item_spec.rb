require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品登録' do
    context '出品登録できるとき' do
      it 'imageとproduct_nameとdescriptionとcategoryとconditionとshipping_feeとdelivery_prefectureとshipping_durationとpriceが存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end
  end

  context '出品登録できないとき' do
    it 'ユーザーが紐づいていなければ登録できない' do
      @item.user = nil
      @item.valid?
      expect(@item.errors.full_messages).to include('User must exist')
    end
    it 'imageが空では登録できない' do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end
    it 'product_nameが空では登録できない' do
      @item.product_name = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Product name can't be blank")
    end
    it 'descriptionが空では登録できない' do
      @item.description = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end
    it 'categoryが空では登録できない' do
      @item.category = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end
    it 'conditionが空では登録できない' do
      @item.condition = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Condition can't be blank")
    end
    it 'shipping_feeが空では登録できない' do
      @item.shipping_fee = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping fee can't be blank")
    end
    it 'delivery_prefectureが空では登録できない' do
      @item.delivery_prefecture = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Delivery prefecture can't be blank")
    end
    it 'shipping_durationが空では登録できない' do
      @item.shipping_duration = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Shipping duration can't be blank")
    end
    it 'priceが空では登録できない' do
      @item.price = ''
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end
    it 'priceが300未満だと登録できない' do
      @item.price = 299
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be greater than or equal to 300')
    end
    it 'priceが10000000だと登録できない' do
      @item.price = 10_000_000
      @item.valid?
      expect(@item.errors.full_messages).to include('Price must be less than or equal to 9999999')
    end
    it '価格に半角数字以外が含まれている場合は出品できない' do
      @item.price = '６６６６'
      @item.valid?
      expect(@item.errors.full_messages).to include('Price is not a number')
    end
  end
end
