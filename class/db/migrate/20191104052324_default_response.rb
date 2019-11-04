class DefaultResponse < ActiveRecord::Migration[6.0]
  def change
    change_column_default :invitations, :response, 0
  end
end
