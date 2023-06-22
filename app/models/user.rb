class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # validates :encrypted_password, presence: true, length: { minimum: 6 }
  validates :nickname, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :first_name_kana, presence: true
  validates :last_name_kana, presence: true
  validates :birthday, presence: true
  # validates :email, presence: true
  # validates :password, presence: true, length: { minimum: 6 }

end

 # emailとpasswordはデフォルトでバリデーションがかかっている。
 # デフォルトで用意されているカラムにはデフォルトでバリデーションがかかっている。
