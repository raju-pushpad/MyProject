class AdminController < ApplicationController
	before_action :check_valid_user
	def index
		@post=Post.all
	end
	def edit
		@post=Post.find(params[:id])
	end
	def update
		@data=Post.find(params[:id])
		if @data.update(post_params)
			flash[:notice]="Post Updated successfully"
			redirect_to admin_index_path
		end
		# byebug
	end


	def destroy
		@delete_post=Post.find(params[:id])
		@delete_post.destroy
		redirect_to admin_index_path
	end

	def verify
		 @verify=Post.find(params[:id])
		 if @verify.update(verify: true)
		 	flash[:notice]="Post verified successfully"
		 	redirect_to admin_index_path
		 end	
		
	end

	private

	def post_params
		params.require(:post).permit( :title, :description)
	end
	def check_valid_user
		
  		if current_user.has_role? :Author
  			redirect_to author_index_path
  		end
  		if current_user.has_role? :Editor
  			redirect_to editor_index_path
  		end
        if current_user.has_role? :reader
        redirect_to reader_index_path
      end
	end
	
end
 