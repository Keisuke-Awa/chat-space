class ChangeColumnToMessages < ActiveRecord::Migration[5.0]
  def change
    change_column :messages, :body, :text
    change_column :messages, :image, :string, default: ''
  end
end
