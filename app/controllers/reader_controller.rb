class ReaderController < ApplicationController
  before_action :check_valid_user
  def index
  	@post=Post.all
  end
  def show
  	@@id=params[:id]
  	@post=Post.find(params[:id])
  	@comment=Comment.new
      @like=Like.new
      # byebug
  	@com=@post.comments.all
    # byebug
  end
  def create
    
  	 # @res=Post.find(@@id).comments.new(comments_params)
  	 d=params[:description]
  	 @res=Post.find(@@id).comments.new(user_id: current_user.id, description:d )
  		# @res.save
  		# flash[:notice]="comment submitted successfully"
  		# redirect_to reader_path(@@id)
       
        respond_to do |format|
            if @res.save
                @user_name= current_user
                @description= @res.description
                
                format.json { render json: { name: current_user.name ,
                 description: @description

                 } }
                
            else
                
                format.json { render json: "Error" }
            end
        end
  	# byebug
  end

  # def like_post
     
  #   @like=Like.new(post_id: @@id ,user_id: current_user.id )
    
  #   respond_to do |format|
  #     if @like.save
  #       @post=Post.find(@@id)
  #       @likes = @post.likes.count
  #       flash[:notice]="Post liked" 
  #       format.json{ render json: { like: @likes } } 

  #       else
  #         format.json{ render json: "false"}
  #         render 'show'
  #     end
  #   end 
    
  #   # byebug
  # end


  def like_post
   @post = Post.find(params[:id])
   @like = @post.likes.where(user_id: current_user.id).first_or_initialize
   if @like.persisted?
     @like.delete
   else
     @like.save
   end
 end

  def dislike_post
    @like= Like.where("user_id=? AND post_id=?",current_user.id,@@id)
    
    respond_to do |format|

      if @like.destroy_all
         @post=Post.find(@@id)
        @likes = @post.likes.count
        flash[:notice]="Post liked" 
          format.json{ render json: { like: @likes } }
      else
        format.json{ render json: "false"}
          render 'show'
      end
    end
  
  end

  def destroy
    # byebug
    @post_id=Comment.find(params[:id]).post_id
    @post=Post.find(@post_id)
     @data=Comment.find(params[:id])
     @data.delete
    
     @com=@post.comments.all
    
      
  end

  private
  def comments_params
  	params.require(:comment).permit(:description , :user_id)
  end
 def check_valid_user

      if current_user.has_role? :Admin
        redirect_to admin_index_path
      end
      if current_user.has_role? :Author
        redirect_to author_index_path
      end
      if current_user.has_role? :Editor
        redirect_to editor_index_path
      end
    end    
     
  
end 
