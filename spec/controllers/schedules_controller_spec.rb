require 'spec_helper'

describe SchedulesController do
  let(:schedule) { mock_model(Schedule, to_param: '1', people: people) }
  let(:user) { double('user', timezone: 'Fishbuckland') }
  let(:person) { mock_model(Person, name: 'Fishbuck') }
  let(:people) { double('people', build: person, first: person) }
  let(:people_at_indexes) { double('people at indexes') }

  before do
    controller.stub(user: user)
    Schedule.stub(:find_by_uuid).with('1').and_return(schedule)
    Schedule.stub(new: schedule)
    schedule.stub(:people_at_indexes).with(user.timezone).and_return(people_at_indexes)
  end

  describe '#show' do
    before do
      get :show, id: '1'
    end
    describe '@schedule, @people_at_indexes' do
      specify { assigns.values_at(:schedule, :people_at_indexes).should == [schedule, people_at_indexes] }
    end
  end

  describe '#new' do
    before do
      get :new
    end
    describe '@schedule, @person' do
      specify { assigns.values_at(:schedule, :person).should == [schedule, person] }
    end
  end

  describe '#create' do
    context 'with valid params' do
      before do
        schedule.stub(save: true)
        post :create, id: '1', schedule: {people_at_indexes: []}
      end
      describe 'flash.notice' do
        specify { flash.notice.should be_present }
      end
      describe 'response' do
        specify { response.should be_redirect }
      end
    end

    context 'with invalid params' do
      before do
        schedule.stub(save: false)
        schedule.errors.add(:name, 'cannot be blank')
        post :create, id: '1', schedule: {people_at_indexes: []}
      end
      describe 'flash.alert' do
        specify { flash.alert.should be_present }
      end
      describe '@schedule, @person' do
        specify { assigns.values_at(:schedule, :person).should == [schedule, person] }
      end
      describe 'response' do
        specify { response.should render_template('new') }
      end
    end
  end
end
