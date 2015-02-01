class InitSchema < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :email, null: false, unique: true
      t.timestamps     null: false
    end

    create_table :images do |t|
      t.references :user,   null: false
      t.string     :file,   null: false
      t.integer    :width,  null: false
      t.integer    :height, null: false
      t.timestamps          null: false
    end

    add_foreign_key :images, :users
  end

  def down
    raise 'Can not revert initial migration'
  end
end
