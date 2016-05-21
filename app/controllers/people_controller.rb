class PeopleController < ApplicationController
  
  def index
    @people = Person.all
  end

  def new
    @person = Person.new
    @person.build_contact_details
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
    if @person.contact_details.nil?
      @person.build_contact_details
    end
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

  def destroy
    person = Person.find_by(id: params[:id])
    if person.destroy
      flash[:success] = "Person successfully deleted"
    else
      flash[:error] = "Cannot delete person"
    end
    redirect_to action: :index
  end

  private

  def person_params
    params.require(:person).permit(:first_name, :last_name, contact_details_attributes: ContactDetails::ALLOWED_ATTRIBUTES)
  end

end
