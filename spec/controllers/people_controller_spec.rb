require 'spec_helper'

describe PeopleController do
  let(:person) { mock('person', name: 'Fishbuck') }
  let(:people) { mock('people', find: person) }
  let(:schedule) { mock('schedule', people: people) }
  let(:user) { mock('user', timezone: 'Fishbuckland') }

  before do
    controller.stub(:user => user)
    Schedule.stub(:find_by_uuid => schedule)
  end

  describe '#new' do
    it 'should assign a new person with the user timezone' do
      people.should_receive(:build).with(timezone: user.timezone).and_return(person)
      get :new, schedule_id: 1
      assigns[:person].should == person
    end
  end

  describe '#create' do
    before do
      person.stub(save: true)
    end

    context 'with valid params' do
      after do
        people.stub(:new).and_return(person)
        post :create, schedule_id: 1, person: {}
      end

      it 'should assign a person'
      it 'should set a flash notice'
      it 'should redirect to the schedule'
    end

    context 'with invalid params' do
      it 'should not create a person'
      it 'should set a flash alert'
      it 'should rerender the new person form'
    end
  end

  describe '#edit' do
    it 'should render the edit person form'
  end

  describe '#update' do
    context 'with valid params' do
      it 'should update a person'
      it 'should set a flash notice'
      it 'should redirect to the schedule'
    end

    context 'with invalid params' do
      it 'should not update a person'
      it 'should set a flash alert'
      it 'should rerender the edit person form'
    end
  end

  describe '#destroy' do
    it 'should remove the person'
    it 'should set a flash notice'
  end
end
