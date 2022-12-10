class Shift < ApplicationRecord
  belongs_to :user

  validates_presence_of :role, :start_at, :end_at
  
end
