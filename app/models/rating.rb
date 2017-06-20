class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :meal
  enum scores: [:Awful, :Bad, :Meh, :Good, :Amazing]
end
