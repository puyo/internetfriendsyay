require 'spec_helper'

describe Schedule do
  describe '#to_param' do
    it 'should return the uuid' do
      Schedule.new(uuid: '123').to_param.should == '123'
    end
  end

  describe '#uuid' do
    it 'should be blank by default' do
      Schedule.new.uuid.should be_blank
    end

    it 'should be set on creation' do
      Schedule.create!.uuid.should be_present
    end
  end

  describe '#day_indexes' do
    let(:schedule) { Schedule.new }
    subject { schedule.day_indexes(time_of_day_index) }
    context 'with time_of_day_index 20' do
      let(:time_of_day_index) { 47 }
      it { should == [47, 95, 143, 191, 239, 287, 335] }
    end
  end

  describe '#people_at_indexes' do
    let(:schedule) { Schedule.new }
    let(:people) { [] }
    subject { schedule.people_at_indexes(timezone) }
    before { schedule.stub(people: people) }

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
