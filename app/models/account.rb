class Account < ActiveRecord::Base

  belongs_to :task

  belongs_to :account_template,
             foreign_key: :number

  has_many :entries

  has_many :observers,
           through: :task

  delegate :name,
           :has_initial,
           :close_via_number,
           to: :account_template

  has_many :patches,
           as: :patchable

  default_scope -> {joins(:account_template).order("account_templates.order")}

  after_create do
    # ensure closing account exists
    # need to be that complicated, otherwise deligation error
    if AccountTemplate.find_by_number(close_via_number)
      Task.find(task_id).accounts.find_or_create_by(number: close_via_number)
    end
    # notify observers
    observers.each do |observer|
      observer.notify(self, :create)
    end
  end

  after_save do
    observers.each do |observer|
      observer.notify(self, :update)
    end
  end

  before_destroy do
    # notify observers
    observers.each do |observer|
      observer.notify(self, :delete)
    end
  end

  after_destroy do
    # cascading uselessnes check
    if Task.find(task_id).accounts.where(close_via_number).any?
      Task.find(task_id).accounts.find_by_number(close_via_number).useless?
    end
  end

  scope :in_opening_balance, -> {where("account_templates.has_initial = ?", true)}
  scope :opening_active,     -> {in_opening_balance.where("initial >= 0")}
  scope :opening_passive,    -> {in_opening_balance.where("initial < 0")}

  def sync
    # sync closing account
    old_close_via_id = close_via_id
    if account_template.close_via
      update(close_via_id: account_template.close_via
                                           .accounts
                                           .find_or_create_by(
                                             task_id: task_id,
                                           ).id)
    else
      update(close_via_id: nil)
    end

    Account.find(old_close_via_id).useless? if old_close_via_id
    puts "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH" if old_close_via_id
  end

  def useless?
    puts "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH"
    puts number
    destroy if not entries.any? and not closing_here.any?
  end

  # calc
  def closing_here
    templates_closing_here_ids = AccountTemplate.where(close_via_number: number).pluck(:number)
    task.accounts.where("accounts.number IN(?)", templates_closing_here_ids)
  end

  def close_via
    task.accounts.find_by(number: close_via_number)
  end

  def debit # always positive
    # initial
    debit = initial > 0 ? initial : 0
    # debits
    debit += entries.debit.sum(:value)
    # closing_here
    closing_here.each {|acc| debit += acc.balance if acc.balance > 0}
    # return
    debit
  end

  def credit # always negative
    # initial
    credit = initial < 0 ? initial : 0
    # debits
    credit -= entries.credit.sum(:value)
    # closing_here
    closing_here.each {|acc| credit += acc.balance if acc.balance < 0}
    # return
    credit
  end

  def balance
    debit + credit
  end

  def sum
    [debit.abs, credit.abs].max
  end

end
