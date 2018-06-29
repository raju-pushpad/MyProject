class WelcomeController < ApplicationController
	skip_before_action :authenticate_user!, only: [:index]
  def index
     @post=Post.where("verify=?", true).all
     @like=Like.new
    # byebug
  	if user_signed_in?
  		if current_user.has_role? :Admin
  			redirect_to admin_index_path
  		end
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
  def like_post
    if user_signed_in?
      redirect_to root_path
    else
      redirect_to new_user_session_path
    end
  end
end
