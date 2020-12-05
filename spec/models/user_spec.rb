require 'rails_helper'

RSpec.describe User, type: :model do
  # ensure User model has a relationship with the List model
  it { should have_many(:lists) }

  # ensure name, email and password_digest are present before save
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password_digest) }

end
