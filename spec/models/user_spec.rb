require 'rails_helper'

describe User do
  subject { User.new(timezone: 'Sydney') }

  it { is_expected.not_to be_persisted }

  describe '#timezone' do
    it 'should return timezone passed to constructor' do
      expect(User.new(timezone: 'foo').timezone).to eq('foo')
    end
  end
end
