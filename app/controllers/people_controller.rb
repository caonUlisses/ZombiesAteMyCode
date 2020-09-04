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
  param :inventories_attributes, Array,
    desc: 'A list of json objects containing resource id and quantity. Must be grouped by resource_id'
  example '
    http POST :3000/people
    {
      "name": "Suppa Mahrio",
      "age": 40,
      "gender": 1,
      "inventories_attributes": [
        {
          "resource_id": "59a73cb2-7b3b-486a-864f-a9d58b6d26e8",
          "quantity": 1
        },
        {
          "resource_id": "59a73cb2-7b3b-486a-864f-a9d58b6d26e8",
          "quantity": 1
        },
        {
          "resource_id": "59a73cb2-7b3b-486a-864f-a9d58b6d26e8",
          "quantity": 1
        },
        {
          "resource_id": "b6132864-8f71-413a-83c3-cb377147f955",
          "quantity": 2
        }
      ]
    }
  '
  def create
    @person = Person.new(person_params)
    validate_params

    if @person.save
      render json: @person, status: :created, location: @person
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  rescue StandardError => e
    render json: e, status: :unprocessable_entity
  end

  api :PUT, 'person/id', 'Update someones location'
  param :last_location, Hash, desc: 'Location with latitude and longitude'
  example '
    http PUT :3000/person/id last_location[latitude]=0 last_location[longitude]=0
  '
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

  def validate_params
    return if params[:inventories_attributes].empty?
    if negative
      raise 'Invalid inventory quantity'
    end

    if !duplicates.empty?
      raise 'Group the inventory before sending, we are not robots over here!'
    end
  end

  def negative
    params[:inventories_attributes].each do |item| 
      return true if item[:quantity] <= 0
    end
    false
  end

  def duplicates
    inventories = params[:inventories_attributes]
    ids = inventories.map { |i| i[:resource_id] }
    ids.select { |id| ids.count(id) > 1 }
  end

  def person_params
    params
      .require(:person)
      .permit(:name, :age, :gender, :last_location, inventories_attributes: %i[resource_id quantity])
  end

  def location_params
    params.require(:person).permit(:last_location)
  end
end
