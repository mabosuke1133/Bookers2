class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :authentication_keys => [:name]

  has_many :post_images, dependent: :destroy

  # 名前：必須かつ2文字〜20文字
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  # 自己紹介：50文字以内
  validates :introduction, length: { maximum: 50 }
end
