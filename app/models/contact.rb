class Contact < ApplicationRecord
  belongs_to :list

  # validation
  validates_presence_of :name
end
