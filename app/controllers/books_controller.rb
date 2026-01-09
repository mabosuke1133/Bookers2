class BooksController < ApplicationController
  def index
   @book = Book.new
   @books = Book.all 
   @user = current_user 
  end

  def show
  end

  def edit
  end

  def create
   # 1. フォームから送られてきたデータ(title, body)を箱に入れる
   @book = Book.new(book_params)
    
    # 2. 【重要】「誰の投稿か」を特定するため、ログインユーザーのIDを代入
   @book.user_id = current_user.id
    
   # 3. データベースに保存（セーブ）を実行
   if @book.save
     # 4. 【showへのリンク】保存成功したら「本の詳細ページ」へ飛ばす
     flash[:notice] = "You have created book successfully."
     redirect_to book_path(@book.id)
   else
     # 5. 保存失敗（タイトルが空など）した時の処理
     @books = Book.all
     @user = current_user
     render :index # 一覧ページを再表示
   end
end

private

  # 6. 【book_paramsの定義】セキュリティのための許可リスト
  def book_params
    params.require(:book).permit(:title, :body)
  end
end