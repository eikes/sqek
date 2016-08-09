class CommentsController < ApplicationController

  before_action :set_new_comment_and_commentable, only: [:new, :create]
  before_action :set_comment_and_commentable, only: [:show, :edit, :update, :destroy]

  authorize_resource

  def index
    @comments = Comment.all
  end

  def bulk_delete
    Comment.where(id: params['comment_ids']).destroy_all
    redirect_to comments_path
  end

  def show
  end

  def new
    @form = CommentNewForm.new(@comment)
  end

  def create
    @form = CommentNewForm.new(@comment)
    if @form.validate(params[:comment])
      @form.save
      recipients = @form.model.city.users.pluck(:email)
      NotificationsMailer.comment_notification(recipients, @form.model).deliver_now
      redirect_to @form.model
    else
      render action: :new
    end
  end

  def edit
    @form = CommentUpdateForm.new(@comment)
  end

  def update
    @form = CommentUpdateForm.new(@comment)
    if @form.validate(params[:comment])
      @form.save
      redirect_to @form.model
    else
      render action: :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to comments_path
  end

  private

  def set_new_comment_and_commentable
    type = params[:comment][:commentable_type]
    id   = params[:comment][:commentable_id]
    @commentable = type.constantize.find(id)
    @comment = Comment.new(commentable: @commentable)
  end

  def set_comment_and_commentable
    @comment = Comment.find(params[:id])
    @commentable = @comment.commentable
  end

end
