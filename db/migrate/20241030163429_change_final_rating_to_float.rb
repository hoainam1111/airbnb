class ChangeFinalRatingToFloat < ActiveRecord::Migration[7.2]
  def change
    change_column :reviews, :final_rating, :float
  end
end
