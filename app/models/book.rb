class Book < ApplicationRecord
  belongs_to :user

  # Titleは空ではない（必須）
  validates :title, presence: true
  # Opinion（body）は空ではなく、かつ200文字以内
  validates :body, presence: true, length: { maximum: 200 }
end
