class AddUserToAnswer < ActiveRecord::Migration
  def self.up
    add_column :answers, :author_id, :integer
  end

  def self.down
    remove_column :answers, :author_id
  end
end
