
require 'yaml'

expenses = YAML.load_file('./test.yml')

puts expenses.inspect
