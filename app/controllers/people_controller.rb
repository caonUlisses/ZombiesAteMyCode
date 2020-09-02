# frozen_string_literal: true

# The controller for the people, be it infected or not
class PeopleController < ApplicationController
  before_action :set_person, only: %i[show location]

  api :GET, 'people', 'List healthy people'
  def index
    @people = Person.all

    render json: @people
  end

  api :GET, 'people/id', 'Show a healthy person'
  param :id, String, desc: 'Id of the healthy person'
  def show
    render json: @person
  end

  api :POST, 'people', 'Register a healthy person'
  param :name, String, desc: 'Person\'s name'
  param :age, :number, desc: 'Age in years'
  param :gender, :number, desc: '0 for male, 1 for female'
  param :last_location, Hash, desc: 'Locatoin with latitude and longitude'
  def create
    @person = Person.new(person_params)

    if @person.save
      render json: @person, status: :created, location: @person
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  api :PUT, 'person/id', 'Update someones location'
  param :last_location, Hash, desc: 'Locatoin with latitude and longitude'
  def location
    if @person.update(location_params)
      render json: @person
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end

  private

  def set_person
    @person = Person.find(params[:id])
  end

  def person_params
    params.require(:person).permit(:name, :age, :gender, :last_location)
  end

  def location_params
    params.require(:person).permit(:last_location)
  end
end
