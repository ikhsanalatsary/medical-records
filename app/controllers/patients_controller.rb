class PatientsController < ApplicationController
  before_action :set_patient_by_id, only: [
    :show,
    :update,
    :destroy
  ]

  def create
  end

  def index
    @patients = Patient.all
    json_response @patients
  end

  def show
    json_response(@patient)
  end

  def update
    @patient.update(patient_params)
    head :no_content
  end

  def destroy
    @patient.destroy
    head :no_content
  end

  private

  def patient_params
    # whitelist params
    params.permit(
      :name,
      :date_of_birth,
      :sex,
      :phone,
      :blood_type,
      { address: [] },
      :person_in_charge,
      :created_by,
      :updated_by
    )
  end

  def set_patient_by_id
    @patient = Patient.find(params[:id])
  end
end
