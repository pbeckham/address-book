class PeopleController < ApplicationController
  
  def index
    @people = Person.all
  end

  def new
    @person = Person.new
    @person.membership.organisation_id = params[:organisation_id]
  end

  def create
    @person = Person.create(person_params)
    if @person.membership.organisation_id.nil?
      @person.membership = nil
    end
    if @person.save
      redirect_to @person
    else
      flash.now[:error] = @person.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    person_by_id
  end

  def edit
    person_by_id
  end

  def update
    person_by_id.update(person_params)
    if @person.membership.organisation_id.nil?
      @person.membership = nil
    end
    if @person.save
      redirect_to @person
    else
      flash.now[:error] = @person.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if person_by_id.destroy
      flash[:success] = "Person successfully deleted"
    else
      flash[:error] = "Cannot delete person"
    end
    redirect_to action: :index
  end

  def organisation_options
    Organisation.pluck(:name, :id)
  end
  helper_method :organisation_options

  private

  def person_by_id
    @person ||= Person.find(params[:id])
  end

  def person_params
    params.require(:person)
      .permit(
        :first_name,
        :last_name,
        contact_details_attributes: ContactDetails::ALLOWED_ATTRIBUTES,
        membership_attributes: [:organisation_id]
      )
  end

end
