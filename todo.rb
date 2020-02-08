require "date"

class Todo
  def initialize(descripiton, due_date, completed)
    @descripiton = descripiton
    @due_date = due_date
    @completed = completed
  end

  def overdue?
    return true if @due_date < Date.today
    false
  end

  def due_today?
    return true if @due_date == Date.today
    false
  end

  def due_later?
    return true if @due_date > Date.today
    false
  end

  def to_displayable_string
    [@descripiton, @due_date.to_s, @completed]
  end
end

class TodosList
  def initialize(todos)
    @todos = todos
  end

  def add(todo)
    @todos << todo
  end

  def overdue
    TodosList.new(@todos.filter { |todo| todo.overdue? })
  end

  def due_later
    TodosList.new(@todos.filter { |todo| todo.due_later? })
  end

  def due_today
    TodosList.new(@todos.filter { |todo| todo.due_today? })
  end

  def to_displayable_list
    todo_text = []
    @todos.each do |todo|
      todo_tmp = todo.to_displayable_string

      if (Date.parse(todo_tmp[1]) == Date.today)
        todo_text.push "[x] " + todo_tmp[0] if todo_tmp[2]
        todo_text.push "[ ] " + todo_tmp[0] if !todo_tmp[2]
      else
        todo_text.push "[x] " + todo_tmp[0] + " " + todo_tmp[1].to_s if todo_tmp[2]
        todo_text.push "[ ] " + todo_tmp[0] + " " + todo_tmp[1].to_s if !todo_tmp[2]
      end
    end
    todo_text
  end
end

date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

todos_list = TodosList.new(todos)

todos_list.add(Todo.new("Service vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"
