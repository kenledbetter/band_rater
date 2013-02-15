class PostsController < ApplicationController
  def new
    # Only allowed logged in reviewers to create posts
    if current_user && current_user.is_reviewer?
      @post = Post.new(:user_id => current_user.id)
    else
      redirect_to posts_path, :notice => "Must be a reviewer to create a post"
    end
  end

  def create
    # Only allowed logged in reviewers to create posts
    if current_user && current_user.is_reviewer?
      @post = Post.new(params[:post])
  
      if @post.save
        redirect_to @post, :notice => "Post created"
      else
        render "new"
      end
    else
      redirect_to posts_path, :notice => "Must be a reviewer to create a post"
    end
  end

  def edit
    if @post = Post.find_by_id(params[:id])
      # Only allow a logged in user or admin to modify a post
      if check_permission(@post.user)
        render "edit"
      else
        redirect_to @post, :notice => "Cannot edit another user's post"
      end
    else
      redirect_to posts_path, :notice => "Post does not exist"
    end
  end

  def update
    if @post = Post.find_by_id(params[:id])
      # Only allow a logged in user or admin to modify a post
      if check_permission(@post.user)
        if @post.update_attributes(params[:post])
          redirect_to @post, :notice => "Post updated"
        else
          render "edit"
        end
      else
        redirect_to @post, :notice => "Cannot edit another user's post"
      end
    else
      redirect_to posts_path, :notice => "Post does not exist"
    end
  end

  def index
    if current_user && current_user.is_reviewer?
      # Show all posts
      @posts = Post.includes(:user, :festival).order("created_at desc").limit(5)
    else
      # Show only published posts
      @posts = Post.includes(:user, :festival).where(:publish => true).order("created_at desc").limit(5)
    end
  end

  def show
    if @post = Post.includes(:user, :festival).where(:id => params[:id], :publish => true).first
      render "show"
    else
      redirect_to posts_path, :notice => "Post does not exist"
    end
  end
end
