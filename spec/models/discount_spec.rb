require 'rails_helper'

RSpec.describe Discount, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:discountable_from) }
    it { is_expected.to belong_to(:discountable_to) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
  end
end
