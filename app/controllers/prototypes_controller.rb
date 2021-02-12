class PrototypesController < ApplicationController
  # ログインしていない場合はログインページにあらかじめ強制的に遷移させる
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  # ログインユーザーとprototypeの投稿者が異なれば編集ページにアクセスできずリダイレクトされる
  before_action :move_to_index, only: :edit

  def index
    @prototypes = Prototype.all.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    prototype = Prototype.new(prototype_params)
    if prototype.save
      # 正しく保存されればルートパスに遷移
      redirect_to root_path
    else
      # 保存に失敗すればindexアクションを実行
      render :index
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    # コメント投稿フォーム用に空のコメントインスタンスを定義
    @comment = Comment.new
    @comments= @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
      # 正しく保存されればプロトタイプの詳細画面にリダイレクト
      redirect_to prototype_path(prototype)
    else
      # 更新に失敗すればeditアクションを実行
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  private

    def prototype_params
      params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
    end

    def move_to_index
      # アクセスしようとしているprototypeの情報を取得
      prototype = Prototype.find(params[:id])
      # ログインしているユーザーのidと、アクセスしようとしているprototypeを投稿したユーザーのidが一致しているか比較
      unless current_user.id == prototype.user.id
        # indexアクションへリダイレクト
        redirect_to action: :index
      end
    end

end
