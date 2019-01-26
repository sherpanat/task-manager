require "sqlite3"
DB = SQLite3::Database.new("tasks.db")
DB.results_as_hash = true
require_relative "task"

# TO REFRESH DATA
DB.execute('DROP TABLE IF EXISTS `tasks`;')
create_statement = "
    CREATE TABLE tasks(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT,
      done INTEGER DEFAULT (0)
    );"
DB.execute(create_statement)
DB.execute(
  "INSERT INTO tasks (title, description)
  VALUES ('Complete Livecode', 'Implement CRUD on Task');"
)

# TODO: CRUD some tasks
# Implement the READ logic to find a given task (by its id)
puts 'READ - find'
task = Task.find(1)
p task
puts '*' * 20
# Implement the CREATE logic in a save instance method
puts 'CREATE - save'
task = Task.new(
  title: 'Drink beers',
  description: 'Drink beers with my buddies at Onyrik'
)
puts task.id == nil
task.save
p task.id
puts '*' * 20
# Implement the UPDATE logic in the same method
puts 'UPDATE - save'
task = Task.find(2)
task.title = 'Drink lots of beers and watch game'
task.done = true
task.save
puts task.title
puts task.done
puts '*' * 20
# Implement the READ logic to retrieve all tasks (what type of method is it?)
puts 'READ - all'
tasks = Task.all
tasks.each do |task|
  puts "[#{task.done ? 'X' : ' '}] #{task.title}: #{task.description}"
end
puts '*' * 20
# Implement the DESTROY logic on a task
puts 'DELETE - destroy'
task = Task.find(2)
task.destroy
p Task.find(2)