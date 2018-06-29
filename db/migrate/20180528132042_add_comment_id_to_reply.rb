class AddCommentIdToReply < ActiveRecord::Migration[5.2]
  def change
    add_column :replies, :comment_id, :integer
    remove_column :replies, :post_id
    remove_column :replies, :user_id
  end
end
