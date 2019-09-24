class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]
  before_action :set_commentable_from_params, only: [:new, :create]
  before_action :set_commentable, except: [:new, :create, :index, :bulk_delete]

  load_and_authorize_resource

  respond_to :html

  def index
    @comments = Comment.all
    respond_with(@comments)
  end

  def bulk_delete
    Comment.where(id: params['comment_ids']).destroy_all
    redirect_to comments_path
  end

  def show
    respond_with(@comment)
  end

  def new
    @comment = Comment.new
    @comment.commentable = @commentable
    respond_with(@comment)
  end

  def edit
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.email ||= current_user.email
    if @comment.save
      recipients = @comment.city.users.pluck(:email)
      NotificationsMailer.comment_notification(recipients, @comment).deliver_now
      respond_with(@comment)
    else
      render :edit
    end
  end

  def update
    @comment.update(comment_params)
    respond_with(@comment)
  end

  def destroy
    @comment.destroy
    respond_with(@comment)
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def set_commentable_from_params
      type = params[:comment][:commentable_type]
      id   = params[:comment][:commentable_id]
      @commentable = type.constantize.find(id)
    end

    def set_commentable
      @commentable = @comment.commentable
    end

    def comment_params
      params.require(:comment).permit(:title, :body, :email, :published, :commentable_id, :commentable_type)
    end
end
