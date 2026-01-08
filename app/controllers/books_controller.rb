class BooksController < ApplicationController
  def index
   @book = Book.new      # 新規投稿用の空のモデル（New book用）
   @books = Book.all     # 全ての投稿を取得
   @user = current_user   # ログイン中のユーザー（User info用）
  end

  def show
  end

  def edit
  end
end
