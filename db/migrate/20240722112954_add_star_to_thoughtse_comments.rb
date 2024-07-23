class AddStarToThoughtseComments < ActiveRecord::Migration[6.1]
  def change
    add_column :thoughtse_comments, :star, :string
  end
end
