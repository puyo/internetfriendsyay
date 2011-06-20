require 'spec_helper'

describe Schedule do
  describe '#people_at_indexes' do
    subject { schedule.people_at_indexes(timezone) }
    let(:schedule) { Schedule.new }
    let(:people) { [] }
    before { schedule.stub(:people => people) }

    context 'with a person at time index 0 Sydney time, and a person at time indexes 0 and 1 Sydney time' do
      before do
        people << mock('person1', timezone: 'Sydney', available_indexes: [0])
        people << mock('person2', timezone: 'Sydney', available_indexes: [0, 1])
      end

      context 'in Sydney time' do
        let(:timezone) { 'Sydney' }
        it 'should be the same as the inputs' do
          subject.should == { 0 => people, 1 => [people.last] }
        end
      end

      context 'in Adelaide time' do
        let(:timezone) { 'Adelaide' }
        it 'should be offset by -1 index and wrap around' do
          subject.should == { 335 => people, 0 => [people.last] }
        end
      end
    end
  end
end
