class Book < ApplicationRecord
  # 1. 誰のものか（ユーザーに属する）という設定
  belongs_to :user

  # 2. 空欄を許さない設定（タイトルと感想）
  validates :title, presence: true
  validates :body, presence: true
  
  # 3. 感想（body）の文字数を制限する設定
  validates :body, length: { maximum: 200 }
end