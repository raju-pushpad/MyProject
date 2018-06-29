class AuthorController < ApplicationController
	before_action :check_valid_user

	def index

	end
	def new
		@post=Post.new
	end
	def create
		@res= current_user.posts.new(post_params)
		@res.save
		if @res.save==true
			flash[:notice]="Post submitted successfully"
		redirect_to author_path(@res)
	
		else
			render 'new'
		end
 
		# byebug
	end

	def reply
		@@comment_id=params[:id]
		@com=Comment.find(params[:id])
		@reply=Reply.new
	end

	def submit_reply
		@data=Comment.find(@@comment_id).replys.new(message: params[:reply][:message])
		@data.save
		flash[:notice]="Reply submitted"
		redirect_to author_path(@@post_id)

		# byebug
	end

	def edit
		@edit_post=Post.find(params[:id])
		# byebug
	end

	def show
		@@post_id=params[:id]
		@post=Post.find(params[:id])
		 @com=@post.comments
		 
		 # byebug
		# byebug
	end
	def update
		@update_data=Post.find(params[:id])
		if @update_data.update(post_params)
			flash[:notice]="Post Updated successfully"
			redirect_to author_all_post_path
		end
	end 
	def all_post
		@post=current_user.posts.all
	end

	def destroy
		@post_id=Comment.find(params[:id]).post_id
    @post=Post.find(@post_id)
     @data=Comment.find(params[:id])
     @data.delete
    
     @com=@post.comments.all
	end

	private
	def post_params
		params.require(:post).permit(:title, :description)
	end

	def check_valid_user
		if current_user.has_role? :Admin
  			redirect_to admin_index_path
  		end
  		
  		if current_user.has_role? :Editor
  			redirect_to editor_index_path
  		end
        if current_user.has_role? :reader
        redirect_to reader_index_path
      end
	end
end
 