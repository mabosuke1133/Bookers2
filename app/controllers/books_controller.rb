class BooksController < ApplicationController
  # ログインしていない場合はログイン画面に送る
  before_action :authenticate_user!
  # editアクションの前に「本人確認」を実行する
  before_action :is_matching_login_user, only: [:edit, :update]
  
  def index
   @book = Book.new
   @books = Book.all 
   @user = current_user 
  end

  def show
   @book = Book.find(params[:id]) # URLの番号から、表示したい本を1件見つける
   @user = @book.user             # その本を投稿したユーザーの情報を取得
   @new_book = Book.new           # 左側のサイドバーにある「New book」用
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
   @book = Book.find(params[:id])
   
   if @book.update(book_params) # 編集内容を保存
    redirect_to book_path(@book.id), notice: "You have updated book successfully."
   else
    render :edit # 失敗したら編集ページを再表示
   end
  end

  def create
   # フォームから送られてきたデータ(title, body)を箱に入れる
   @book = Book.new(book_params)
    
   #【重要】「誰の投稿か」を特定するため、ログインユーザーのIDを代入
   @book.user_id = current_user.id
    
   # データベースに保存（セーブ）を実行
   if @book.save
     #【showへのリンク】保存成功したら「本の詳細ページ」へ飛ばす
     flash[:notice] = "You have created book successfully."
     redirect_to book_path(@book.id)
   else
     # 保存失敗（タイトルが空など）した時の処理
     @books = Book.all
     @user = current_user
     render :index # 一覧ページを再表示
   end
  end

 def destroy
  book = Book.find(params[:id])
  book.destroy
  redirect_to books_path
 end

 private

 # セキュリティのための許可リスト
 def book_params
   params.require(:book).permit(:title, :body)
 end

 # 本の投稿者が自分かどうかをチェックするメソッド
 def is_matching_login_user
  @book = Book.find(params[:id])
   # その本のユーザーIDと、今ログインしているユーザーのIDが一致しなければ
  unless @book.user.id == current_user.id
     # 本の一覧画面に強制送還！
     redirect_to books_path
  end
 end
end