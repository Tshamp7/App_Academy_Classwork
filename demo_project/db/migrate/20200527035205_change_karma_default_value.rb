class ChangeKarmaDefaultValue < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:users, :karma, 0)
  end
end
