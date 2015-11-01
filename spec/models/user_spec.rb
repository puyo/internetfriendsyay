require 'rails_helper'

describe User do
  it { is_expected.not_to be_persisted }

  describe '#timezone' do
    it 'should default to "Sydney"' do
      expect(User.new.timezone).to eq('Sydney')
    end
    it 'should return timezone passed to constructor' do
      expect(User.new(timezone: 'foo').timezone).to eq('foo')
    end
  end
end
