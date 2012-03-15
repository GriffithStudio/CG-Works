class ChangeTwitterIdToBigint < ActiveRecord::Migration
  def change
    change_column :tweets, :twitter_id, :bigint
  end
end
