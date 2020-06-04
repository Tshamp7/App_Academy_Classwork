class AddTimestamps < ActiveRecord::Migration[6.0]
  def change
    add_timestamps(:answerchoices)
    add_timestamps(:polls)
    add_timestamps(:questions)
    add_timestamps(:responses)
  end
end
