
require 'yaml'

class Fudget

  def initialize (check, monthly, env)
    @paycheck = check
    @recurring = monthly
    @envelopes = env
  end
  
  def net_monthly_income
    return total_income(2) + monthly_expenses
  end

  def monthly_expenses
    return @recurring.values.reduce(:+)
  end

  def total_income(no_of_checks)
    net_check = @paycheck.values.reduce(:+)
    total = 0.00

    while no_of_checks > 0
      total += net_check
      no_of_checks -= 1
    end

    return total
  end

end
