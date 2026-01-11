class UsersController < ApplicationController
  # ログインしていない場合はログイン画面に送る
  before_action :authenticate_user!
  # 編集(edit)と更新(update)の前に、本人確認メソッドを動かす
  before_action :ensure_correct_user, only: [:edit, :update]
  
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
   @user = User.find(params[:id]) # ここで改めてチェックしなくても、before_actionが守ってくれる
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
  params.require(:user).permit(:name, :introduction, :profile_image_id)
 end

 def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      # もし本人じゃなければ、自分の詳細ページ(show)に強制送還！
      redirect_to user_path(current_user)
    end
  end
end