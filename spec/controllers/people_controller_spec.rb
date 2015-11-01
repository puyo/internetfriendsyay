require 'rails_helper'

describe PeopleController do
  let(:person) { mock_model(Person, name: 'Fishbuck') }
  let(:people) { double('people') }
  let(:schedule) { mock_model(Schedule, people: people) }
  let(:user) { double('user', timezone: 'Fishbuckland') }

  before do
    allow(Schedule).to receive(:find_by_uuid).with('1').and_return(schedule)
    allow(controller).to receive_messages(user: user)
    allow(people).to receive(:find).with('1').and_return(person)
    allow(people).to receive_messages(new: person)
  end

  describe '#new' do
    before do
      allow(people).to receive(:build).with(timezone: user.timezone).and_return(person)
      get :new, schedule_id: '1'
    end
    describe '@person' do
      specify { expect(assigns[:person]).to be_present }
    end
  end

  describe '#create' do
    context 'with valid params' do
      before do
        allow(person).to receive_messages(save: true)
        post :create, schedule_id: '1', person: {timezone: 'hithere'}
      end
      describe 'flash.notice' do
        specify { expect(flash.notice).to be_present }
      end
      describe 'response' do
        specify { expect(response).to be_redirect }
      end
    end

    context 'with invalid params' do
      before do
        allow(person).to receive_messages(save: false)
        person.errors.add(:name, 'cannot be blank')
        post :create, schedule_id: '1', person: {timezone: 'hithere'}
      end
      describe 'flash.alert' do
        specify { expect(flash.alert).to be_present }
      end
      describe 'response' do
        specify { expect(response).to render_template('new') }
      end
      describe '@person' do
        specify { expect(assigns[:person]).to be_present }
      end
    end
  end

  describe '#update' do
    context 'with valid params' do
      before do
        allow(person).to receive_messages(update_attributes: true)
        put :update, schedule_id: '1', id: '1', person: {timezone: 'hithere'}
      end
      describe 'flash.notice' do
        specify { expect(flash.notice).to be_present }
      end
      describe 'response' do
        specify { expect(response).to be_redirect }
      end
    end

    context 'with invalid params' do
      before do
        allow(person).to receive_messages(update_attributes: false)
        person.errors.add(:name, 'cannot be blank')
        put :update, schedule_id: '1', id: '1', person: {timezone: 'hithere'}
      end
      describe 'flash.alert' do
        specify { expect(flash.alert).to be_present }
      end
      describe 'response' do
        specify { expect(response).to render_template('edit') }
      end
      describe '@person' do
        specify { expect(assigns[:person]).to be_present }
      end
    end
  end

  describe '#destroy' do
    before do
      expect(person).to receive(:destroy)
      delete :destroy, schedule_id: '1', id: '1'
    end
    describe 'flash.notice' do
      specify{ expect(flash.notice).to be_present }
    end
    describe 'response' do
      specify{ expect(response).to be_redirect }
    end
  end
end
