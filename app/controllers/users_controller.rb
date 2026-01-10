class UsersController < ApplicationController
  def index
   @users = User.all       # 全ユーザーを取得して一覧に出す
   @book = Book.new        # サイドバーの「New book」用
   @user = current_user    # サイドバーの「User info」用
  end

  def show
  end

  def edit
  end
end
