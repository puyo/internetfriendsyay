require 'spec_helper'

describe User do
  it { should_not be_persisted }

  describe '#timezone' do
    it 'should default to "Sydney"' do
      User.new.timezone.should == 'Sydney'
    end
    it 'should return timezone passed to constructor' do
      User.new(timezone: 'foo').timezone.should == 'foo'
    end
  end
end
