class Patch < ActiveRecord::Base
  belongs_to :user

  belongs_to :observer

  belongs_to :patchable,
             polymorphic: true

  has_one    :task,
             through: :observer

  @@method_names = {1 => :create, 3 => :update,  4 => :delete}

  def self.method_names
    @@method_names
  end

  def method
    @@method_names[method_id]
  end

  def account
    task.accounts.where number: account_number
  end

  before_create do
    raise "unsupported patch method_id '#{method_id}'" if not @@method_names.include? method_id
  end
end
