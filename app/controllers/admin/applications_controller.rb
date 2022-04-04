class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    if @application.pet_applications.all_approved?
      @application.update(status: "Approved")
    elsif @application.pet_applications.all_inspected?
      @application.update(status: "Rejected")
    end
  end
end
