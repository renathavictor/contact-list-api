require 'rails_helper'

RSpec.describe Contact, type: :model do
  # ensure an contact record  belongs to a single user record
  it { should belong_to(:list) }
  # ensure column name is present before saving
  it { should validate_presence_of(:name) }
end
