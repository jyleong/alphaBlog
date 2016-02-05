class AddUserIdToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :user_id, :integer
    ## column, then model you add to, type name, then type
  end
end
