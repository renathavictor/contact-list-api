class List < ApplicationRecord
  has_many :contacts, dependent: :destroy
  # belongs_to :user

  # validations
  validates_presence_of :title, :created_by
end
