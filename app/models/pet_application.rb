class PetApplication < ApplicationRecord
  after_initialize :set_default

  validates_presence_of :status
  belongs_to :pet
  belongs_to :application

  def set_default
    self.status ||= "Pending"
  end

  def self.all_approved?
    !any? { |pet_app| pet_app.status != "Approved" }
  end

  def self.all_inspected?
    !any? { |pet_app| pet_app.status == "Pending" }
  end

  def self.pending
    where(status: "Pending")
  end
end
