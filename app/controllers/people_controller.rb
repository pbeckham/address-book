class PeopleController < ApplicationController
  
  def index
    @people = Person.all
  end

  def new
    @person = Person.new
    @person.contact_details = ContactDetails.new
  end

  def create
    @person = Person.create(person_params)
    if @person.save
      redirect_to @person
    else
      render :new
    end
  end

  def show
    @person = Person.find_by(id: params[:id])
  end

  def edit
    @person = Person.find_by(id: params[:id])
  end

  def update
    @person = Person.find_by(id: params[:id])
    @person.update(person_params)
    if @person.save
      redirect_to @person
    else
      render :edit
    end
  end

  private

  def person_params
    params.require(:person).permit(:first_name, :second_name)
  end

end
