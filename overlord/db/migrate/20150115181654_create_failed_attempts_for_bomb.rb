class CreateFailedAttemptsForBomb < ActiveRecord::Migration
  def change
    add_column(:bombs, :failed_attempts, :integer)
  end
end
