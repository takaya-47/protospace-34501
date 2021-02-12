class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      # コメントの投稿に成功したらリダイレクトでprototype詳細ページに戻る
      redirect_to prototype_path(@comment.prototype)
    else
      # # エラー防止のためprototype詳細ページに必要なインスタンス変数をここでも定義しておく
      @prototype = @comment.prototype
      # # すでに投稿済みのコメントがある前提
      @comments= @prototype.comments.includes(:user)
      # # renderメソッドはインスタンス変数が再定義されないので、上２行で手動で定義しておく
      render "prototypes/show"
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
    end

end
