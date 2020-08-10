class ChangeColumnDefault < ActiveRecord::Migration[5.2]
  def change
    change_column_default :submissions, :accepted, false
    change_column_default :submissions, :reproved, false
    change_column_default :submissions, :submitted, false
  end
end
