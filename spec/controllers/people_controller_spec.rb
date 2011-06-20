require 'spec_helper'

describe PeopleController do
  let(:person) { mock_model(Person, name: 'Fishbuck') }
  let(:people) { mock('people') }
  let(:schedule) { mock_model(Schedule, people: people) }
  let(:user) { mock('user', timezone: 'Fishbuckland') }

  before do
    Schedule.stub(:find_by_uuid).with('1').and_return(schedule)
    controller.stub(user: user)
    people.stub(:find).with('1').and_return(person)
    people.stub(new: person)
  end

  describe '#new' do
    before do
      people.stub(:build).with(timezone: user.timezone).and_return(person)
      get :new, schedule_id: '1'
    end
    describe '@person' do
      specify { assigns[:person].should be_present }
    end
  end

  describe '#create' do
    context 'with valid params' do
      before do
        person.stub(save: true)
        post :create, schedule_id: '1', person: {}
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
        person.stub(save: false)
        person.errors.add(:name, 'cannot be blank')
        post :create, schedule_id: '1', person: {}
      end
      describe 'flash.alert' do
        specify { flash.alert.should be_present }
      end
      describe 'response' do
        specify { response.should_not be_redirect }
      end
      describe '@person' do
        specify { assigns[:person].should be_present }
      end
    end
  end

  describe '#update' do
    context 'with valid params' do
      before do
        person.stub(update_attributes: true)
        put :update, schedule_id: '1', id: '1', person: {}
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
        person.stub(update_attributes: false)
        person.errors.add(:name, 'cannot be blank')
        put :update, schedule_id: '1', id: '1', person: {}
      end
      describe 'flash.alert' do
        specify { flash.alert.should be_present }
      end
      describe '@person' do
        specify { assigns[:person].should be_present }
      end
    end
  end

  describe '#destroy' do
    before do
      person.should_receive(:destroy)
      delete :destroy, schedule_id: '1', id: '1'
    end
    describe 'flash.notice' do
      specify{ flash.notice.should be_present }
    end
    describe 'response' do
      specify{ response.should be_redirect }
    end
  end
end
