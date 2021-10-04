require "active_record"
require "./connect_db.rb"

class Todo < ActiveRecord::Base
  def due_currentday?
    due_date == Date.today
  end
  def self.duedateexceeded
    where("due_date < ?", Date.today)
  end

  def self.due_currentday
    where("due_date = ?", Date.today)
    where(due_date: Date.today)
  end

  def self.due_upcoming
    where("due_date > ?", Date.today)
  end
  
  def self.show_list
    puts "My Todo-list\n\n"
    puts "duedateexceeded\n"
    puts duedateexceeded.map { |todo| todo.to_displayable_string }
    puts "\n\n"
    puts "Due Today\n"
    puts due_currentday.map { |todo| todo.to_displayable_string }
    puts "\n\n"
    puts "Due Later\n"
    puts due_upcoming.map { |todo| todo.to_displayable_string }
    puts "\n\n"
  end

  def self.add_task(todo_hash)
    Todo.create!(todo_text: todo_hash[:todo_text], due_date: Date.today + todo_hash[:due_in_days], completed: false)
  end

  def self.mark_as_complete!(todo_id)
    todo = Todo.find(todo_id)
    todo.completed = true
    todo.save
    todo
  end

  def to_displayable_string
    display_status = completed ? "[X]" : "[ ]"
    display_date = due_currentday? ? nil : payment_date
    "#{id}. #{display_status} #{todo_text} #{display_date}"
  def self.add_task(todo)
    todo_text = todo[:todo_text]
    payment_date = Date.today + todo[:due_in_days]
    create!(todo_text: todo_text, due_date: payment_date, completed: false)
  end

  def self.to_displayable_list
    @todos.map { |todo|  todo.to_displayable_string }
  end
  def self.mark_as_complete(todo_id)
    todo_for_completion = find(todo_id)
    todo_for_completion.completed = true
    todo_for_completion.save
    return todo_for_completion
  end
end
end 