class User < ApplicationRecord
  has_secure_password

  has_many :lists, foreign_key: :created_by
  
  # validations
  validates_presence_of :name, :email, :password_digest
end
