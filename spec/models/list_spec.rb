require 'rails_helper'

RSpec.describe List, type: :model do
  it { should have_many(:contacts).dependent(:destroy) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:created_by) }
end
