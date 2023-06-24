require 'rails_helper' # Rspecを用いてRailsの機能をテストするときに、共通の設定を書いておくファイルです。

RSpec.describe User, type: :model do
  before do
   @user = FactoryBot.build(:user) # FactoryBotを用いれば、毎回newメソッドで値を指定してインスタンスを生成する必要がなくなる
  end

  describe 'ユーザー新規登録' do # describeとは、テストコードのグループ分けを行うメソッドです。
    context '新規登録できるとき' do # contextは、特定の条件を指定して魏ループを分けます。
     it 'nicknameとemail、passwordとpassword_confirmationが存在すれば登録できる' do
       expect(@user).to be_valid # itメソッドは、より詳細にグループ分けを行うメソッドです。
       # binding.pry
      end                       # itメソッドで分けたグループを、exampleとも呼びます。
    end
          
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do  # nicknameが空では登録できないテストコードを記述します
        @user.nickname = ''       # userのnameが空だったらDBに保存されない が正常に起動するかを確認しています。
        @user.valid?              # もしDBに保存されない場合のエラーメッセージは、「Nickname can't be blank」となります。
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
              # full_messagesは、エラーの内容から、エラーメッセージを配列として取り出すメソッドです。
              # expectationとは、検証で得られた挙動が想定通りなのかを確認する構文
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'emailは@を含まないと登録できない' do
       @user.email = 'testmail'
       @user.valid?
       expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it 'passwordが空では登録できない' do
       @user.password = ''
       @user.valid?
       expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが6文字以上出ない場合は登録できない' do
       @user.password = '00000'
       @user.password_confirmation = '00000'
       @user.valid?
       expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it '英字のみのパスワードは登録できない' do
        @user.password = 'password'
        @user.password_confirmation = 'password'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it '数字のみのパスワードでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it '全角文字を含むパスワードでは登録できない' do
        @user.password = 'パスワード'
        @user.password_confirmation = 'パスワード'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'お名前(全角)は、苗字と名前がないと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'お名前(全角)は、苗字と名前がないと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'お名前(全角)は、全角(漢字・ひらがな・カタカナ)でないと登録できない' do
        @user.last_name = 'Smith'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it 'お名前(全角)は、全角(漢字・ひらがな・カタカナ)でないと登録できない' do
        @user.first_name = 'John'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it 'お名前カナ(全角)は、苗字と名前がないと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'お名前カナ(全角)は、苗字と名前がないと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'お名前カナ(全角)は、全角(カタカナ)でないと登録できない' do
        @user.last_name_kana = 'すみす'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it 'お名前カナ(全角)は、全角(カタカナ)でないと登録できない' do
        @user.first_name_kana = 'たまる'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it '生年月日が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end 
  end
end

# テストコードを実行
# % bundle exec rspec spec/models/user_spec.rb
# binding.pry
# @user.errors.full_messages