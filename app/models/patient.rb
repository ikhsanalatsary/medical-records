class Patient
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  include Mongoid::Timestamps::Updated

  field :medical_record_number, type: String
  field :name, type: String
  field :date_of_birth, type: String
  field :sex, type: String
  field :phone, type: String
  field :blood_type, type: String
  field :address, type: Array
  field :person_in_charge, type: String
  belongs_to :user, class_name: 'User', foreign_key: 'created_by'
  belongs_to :user, class_name: 'User', foreign_key: 'updated_by', optional: true
  belongs_to :user, class_name: 'User'

  validates_presence_of :name, message: 'Please fill in patient name'
  validates_uniqueness_of :medical_record_number, message: 'medical record number already exists'
end
