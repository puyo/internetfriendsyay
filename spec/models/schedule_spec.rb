require File.expand_path('../spec_helper', File.dirname(__FILE__))

describe Schedule do
  describe '#people_at_indexes' do
    subject { schedule.people_at_indexes(timezone) }
    let(:schedule) { Schedule.new }
    let(:people) { [] }
    before { schedule.stub(:people => people) }

    context 'with a person at time index 0, Sydney time and a person at time index 0 and 1, Sydney time' do
      before do
        people << mock('person1', timezone: 'Sydney', available_indexes: [0])
        people << mock('person2', timezone: 'Sydney', available_indexes: [0, 1])
      end

      context 'in Sydney time' do
        let(:timezone) { 'Sydney' }
        it { should == { 0 => people, 1 => [people.last] } }
      end

      context 'in Adelaide time' do
        let(:timezone) { 'Adelaide' }
        it { should == { 335 => people, 0 => [people.last] } }
      end
    end
  end
end
