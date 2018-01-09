class AddContentToComment < ActiveRecord::Migration[5.1]
  def change
    add_column :comments, :content, :text
  end
end
