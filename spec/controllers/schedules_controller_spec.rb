require 'rails_helper'

describe SchedulesController do
  let(:schedule) { mock_model(Schedule, to_param: '1', people: people) }
  let(:user) { double('user', timezone: 'Fishbuckland') }
  let(:person) { mock_model(Person, name: 'Fishbuck') }
  let(:people) { double('people', build: person, first: person) }
  let(:people_at_indexes) { double('people at indexes') }

  before do
    allow(controller).to receive_messages(user: user)
    allow(Schedule).to receive(:find_by_uuid).with('1').and_return(schedule)
    allow(Schedule).to receive_messages(new: schedule)
    allow(schedule).to receive(:people_at_indexes).with(user.timezone).and_return(people_at_indexes)
  end

  describe '#show' do
    before do
      get :show, id: '1'
    end
    describe '@schedule, @people_at_indexes' do
      specify { expect(assigns.values_at(:schedule, :people_at_indexes)).to eq([schedule, people_at_indexes]) }
    end
  end

  describe '#new' do
    before do
      get :new
    end
    describe '@schedule, @person' do
      specify { expect(assigns.values_at(:schedule, :person)).to eq([schedule, person]) }
    end
  end

  describe '#create' do
    context 'with valid params' do
      before do
        allow(schedule).to receive_messages(save: true)
        post :create, id: '1', schedule: {people_at_indexes: []}
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
        allow(schedule).to receive_messages(save: false)
        schedule.errors.add(:name, 'cannot be blank')
        post :create, id: '1', schedule: {people_at_indexes: []}
      end
      describe 'flash.alert' do
        specify { expect(flash.alert).to be_present }
      end
      describe '@schedule, @person' do
        specify { expect(assigns.values_at(:schedule, :person)).to eq([schedule, person]) }
      end
      describe 'response' do
        specify { expect(response).to render_template('new') }
      end
    end
  end
end
