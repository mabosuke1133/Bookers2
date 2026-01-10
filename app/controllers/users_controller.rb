class UsersController < ApplicationController
  def index
   @users = User.all       # 全ユーザーを取得して一覧に出す
   @book = Book.new        # サイドバーの「New book」用
   @user = current_user    # サイドバーの「User info」用
  end

  def show
  @user = User.find(params[:id])    # URLのIDから「誰のページか」を特定する
  @books = @user.books      # そのユーザー（@user）に紐付いた本だけをすべて取得する
  @book = Book.new       # サイドバーの「New book」用
  end

  def edit
  end
end
