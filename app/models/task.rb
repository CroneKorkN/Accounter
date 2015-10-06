class Task < ActiveRecord::Base
  has_many :records,
           dependent: :destroy

  has_many :entries,
           through: :records

  has_many :accounts,
           dependent: :destroy

  has_many :observers
  
  belongs_to :taskable,
             polymorphic: true

  def show_opening_balance?
    accounts.opening_active.length > 0 || accounts.opening_passive.length > 0
  end

  def opening_balance
    OpeningBalance.new self
  end
end
