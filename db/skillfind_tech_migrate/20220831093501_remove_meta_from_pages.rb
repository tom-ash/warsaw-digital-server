class RemoveMetaFromPages < ActiveRecord::Migration[6.1]
  def change
    remove_column :pages, :meta
  end
end
