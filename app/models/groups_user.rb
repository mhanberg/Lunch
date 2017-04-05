class GroupsUser < ApplicationRecord
  belongs_to :user
  belongs_to :group
  enum role: [ :Standard, :Admin ]
end
