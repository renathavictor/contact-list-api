require 'rails_helper'

RSpec.describe List, type: :model do
  # ensure Todo model has a 1:m relationship with the Item model
  it { should have_many(:contacts).dependent(:destroy) }

  # ensure columns title and created_by are present before saving
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
