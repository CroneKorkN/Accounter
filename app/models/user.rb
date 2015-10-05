class User < ActiveRecord::Base
  has_secure_password validations: false
  after_initialize :initialize_task
  has_many :tasks
  
  def member?
    true if email
  end
  
  def initialize_task
    current_task = tasks.create.id
  end
  
  def validations
    validates :name,
              presence: true
    validates :email,
              presence: true,
              uniqueness: true,
              format: {
                with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
              }
  end
end
