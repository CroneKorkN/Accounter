class User < ActiveRecord::Base
  has_secure_password validations: false
  after_initialize :initialize_task
  has_many :tasks
  belongs_to :current_task,
             class_name: "Task"
  
  def member?
    true if email
  end
  
  def initialize_task
    return if not self.new_record?
    save
    update current_task: tasks.create
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
