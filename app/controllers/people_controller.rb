# frozen_string_literal: true

# The controller for the people, be it infected or not
class PeopleController < ApplicationController
  before_action :set_person, only: %i[show update destroy]

  def index
    @people = Person.all

    render json: @people
  end

  def show
    render json: @person
  end

  def create
    @person = Person.new(person_params)

    if @person.save
      render json: @person, status: :created, location: @person
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
end
