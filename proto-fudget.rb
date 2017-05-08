
require 'yaml'

class Fudget
  # right now, we'll just work on a monthly basis, but perhaps a future feature
  # can be setting things for different time scales

  def initialize
    @income = [] 
    @expenses = []
    @envelopes = {}
  end
  
  def add_income(source, amount, perMonth)
    income = { name: source, amount: amount }
    perMonth.times { @income << income }
  end

  def add_expense(amount)
    @expenses << amount
  end

  def add_envelope(name)
    @envelopes[name] = []
  end

  def deduct_from_envelope(env, amt)
    @envelopes[env] << amt
  end

  def total_income
    credits = []
    @income.each { |credit| credits << credit[:amount] }
    return credits.reduce(:+)
  end

  def total_expenses
    @expenses.reduce(:+)
  end

  def net_income
    return total_income - total_expenses
  end

  def load_expenses(file)
    expenses = YAML.load_file(file)

    expenses.keys.each do |key|
      debits = expenses[key] ||= [0]
      debits.each { |debit| self.deduct_from_envelope(key, debit) }
    end
  end

  def save(path)
    budget = { income: @income, 
               expenses: @expenses, 
               envelopes: @envelopes
             }

    file = File.open(path , 'w') 
    file.write(YAML.dump(budget))
    file.close
  end

end
