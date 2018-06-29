class AddVerifyToPost < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :verify, :boolean
  end
end
