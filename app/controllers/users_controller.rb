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
  @user = User.find(params[:id])
  end

  def update
  @user = User.find(params[:id])
  if @user.update(user_params)
    redirect_to user_path(@user.id), notice: "You have updated user successfully."
  else
    render :edit
  end
end

private

def user_params
  params.require(:user).permit(:name, :introduction, :profile_image)
end
