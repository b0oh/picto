class AddCachedUrlToImages < ActiveRecord::Migration
  def up
    add_column :images, :cached_url, :string, default: nil
  end

  def down
    remove_column :images, :cached_url
  end
end
