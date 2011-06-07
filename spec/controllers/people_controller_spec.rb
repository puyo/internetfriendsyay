require 'spec_helper'

describe PeopleController do
  describe '#new' do
    it 'should create a person'
  end

  describe '#create' do
    context 'with valid params' do
      it 'should create a person'
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
