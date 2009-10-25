class AddVoterToVote < ActiveRecord::Migration
  def self.up
    add_column :votes, :voter_id, :integer
  end

  def self.down
    remove_column :votes, :voter_id
  end
end
