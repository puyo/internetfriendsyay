require 'spec_helper'

describe Person do
  let(:person) { Person.new(available_at: available_at_input) }

  describe '#available_at' do
    subject { person.available_at }
    context 'when set to {"3" => "1"}' do
      let(:available_at_input) { {'3' => '1'} }
      it { should == {3 => true} }
    end
  end

  describe '#available_at?' do
    subject { person.available_at?(index) }
    context 'when set to {"3" => "1"}' do
      let(:available_at_input) { {'3' => '1'} }
      context 'when inquiring about index 0' do
        let(:index) { 0 }
        it { should be_false }
      end
      context 'when inquiring about index 3' do
        let(:index) { 3 }
        it { should be_true }
      end
    end
  end

  describe '#available_indexes' do
    subject { person.available_indexes }
    context 'when set to {"3" => "1", "4" => "1"}' do
      let(:available_at_input) { {'3' => '1', '4' => '1'} }
      it { should == [3, 4] }
    end
  end
end
