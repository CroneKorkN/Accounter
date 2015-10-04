class OpeningBalance
  def initialize(task)
    @task = task
  end

  def debit
    @task.accounts.opening_active
  end
  
  def credit
    @task.accounts.opening_passive
  end
  
  def debit_sum
    @task.accounts.opening_active.sum(:initial)
  end

  def credit_sum
    @task.accounts.opening_passive.sum(:initial)
  end
  
  def to_partial_path
    "accounts/opening_balance"
  end
end
