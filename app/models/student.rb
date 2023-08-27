class Student < ActiveRecord::Base
  has_one :project

  validates_presence_of :name, :email, :github
end
