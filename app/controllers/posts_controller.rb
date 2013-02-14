class PostsController < ApplicationController
  def new
    # Only allowed logged in reviewers to create posts
    if current_user && current_user.is_reviewer?
      @post = Post.new
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
    # Only allowed logged in reviewers to modify posts
    if current_user && current_user.is_reviewer?
      if @post = Post.find_by_id(params[:id])
        render "edit"
      else
        redirect_to @post, :notice => "Post does not exist"
      end
    else
      redirect_to posts_path, :notice => "Must be a reviewer to modify a post"
    end
  end

  def update
    # Only allowed logged in reviewers to modify posts
    if current_user && current_user.is_reviewer?
      if @post = Post.find_by_id(params[:id])
        if @post.update_attributes(params[:post])
          redirect_to @post, :notice => "Post updated"
        else
          render "edit"
        end
      else
        redirect_to @post, :notice => "Post does not exist"
      end
    else
      redirect_to posts_path, :notice => "Must be a reviewer to modify a post"
    end
  end

  def index
    @posts = Post.order("average_rating desc").find(:all)
  end

  def show
    # Get post and prefetch ratings
    if @post = Post.find_by_id(params[:id])
      render "show"
    else
      redirect_to posts_path, :notice => "Must be a reviewer to create a post"
    end
  end
end
