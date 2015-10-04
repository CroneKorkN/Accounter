class AccountTemplate < ActiveRecord::Base
  self.primary_key = :number

  has_many :accounts,
           foreign_key: :number

  belongs_to :close_via,
             class_name:  "AccountTemplate",
             primary_key: :number,
             foreign_key: :close_via_number


  has_many   :closing_here,
             class_name:  "AccountTemplate",
             primary_key: :number,
             foreign_key: :close_via_number

  before_save do
    # check for circle dependency
    @_dep_check_numbers = [number]
    _dep_check close_via if close_via
  end

  after_save do
    accounts.each do |account|
      account.sync
    end
  end

  def self.collection(with_empty: false, id: :id)
    collection = {}
    collection[nil] =  "------" if with_empty
    AccountTemplate.all.each do |account_template|
      collection[account_template.send(id)] = account_template.name
    end
    return collection
  end

private
  def _dep_check acc_tpl
    puts @_dep_check_numbers
    if @_dep_check_numbers.include? acc_tpl.number
      raise "circle dependency error"
    else
      @_dep_check_numbers << acc_tpl.number
      _dep_check acc_tpl.close_via if acc_tpl.close_via
    end
  end
end
