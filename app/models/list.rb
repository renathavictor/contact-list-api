class List < ApplicationRecord
  has_many :contacts, dependent: :destroy

  # validations
  validates_presence_of :title, :created_by
end
