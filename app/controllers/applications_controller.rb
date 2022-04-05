class ApplicationsController < ApplicationController
  def index
  end

  def new;end

  def create
    app = Application.new(applications_params)
    if app.save
      redirect_to "/applications/#{app.id}"
    else
      flash[:alert] = "Error: #{error_message(app.errors)}"
      render :new
    end
  end

  def show
    @applicant = Application.find(params[:id])
      if params[:pet_name]
        @pets = Pet.search(params[:pet_name])
      else
        @pets =[]
      end
      if params[:pet]!= nil
        pet = Pet.find(params[:pet])
        PetApplication.create!(pet_id: pet.id, application_id: @applicant.id)
      end
  end

  def update
    @applicant = Application.find(params[:id])
    @applicant.update(description: params[:description], status: "Pending")
    redirect_to "/applications/#{@applicant.id}"
  end

  private
    def applications_params
      params.permit(:name, :street_address, :city, :state, :zipcode, :description, :status)
    end
end
