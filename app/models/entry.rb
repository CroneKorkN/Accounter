class Entry < ActiveRecord::Base
  belongs_to :account
  has_one    :account_template,
             through: :account

  belongs_to :record

  has_one    :task,
             through: :record

  has_many   :observers,
             through: :task

  scope :debit,
        -> {where(debit_not_credit: true)}

  scope :credit,
        -> {where(debit_not_credit: false)}

  # controller moves :number to :new_number to not be overwritten by def number
  # this is neccessary for best_in_place to work with AccountTemplates
  attr_accessor :new_number
  before_save do |entry|
    if new_number
      entry.account_id = AccountTemplate.find_by_number(new_number).accounts
                                        .find_or_create_by(task_id: record.task_id).id
    end
  end

  after_save do
    # has an account become useless?
    Account.find(account_id_was).useless? if Account.find_by(id: account_id_was)

    # does an observer need to be notified about changes?
    observers.each do |observer|
      observer.notify(record, :update)
      if account = Account.find_by(id: account_id_was)
        observer.notify(account, :update) if account_id_was
      end
      if account = Account.find_by(id: account_id)
        observer.notify(account, :update) if account_id
      end
    end
  end

  before_destroy do
    observers.each do |observer|
      observer.notify(Account.find(account_id), :update) if account_id
    end
  end

  after_destroy do
    Account.find(account_id).useless? if account_id
  end

  def number
    account.number if account
  end
end
