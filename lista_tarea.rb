class Tasklist
  attr_accessor :tasks

  def initialize
    @tasks = []  # Inicializa la lista de tareas como un arreglo vacío
  end

  def new_task
    puts "What's the new task?"
    add = gets.chomp
    date = Time.now
    @tasks << { description: add, date: date, completed: false, completion_date: nil }
    puts "Task added: '#{add}' (Created on: #{date})"
  end

  def list
    puts "Your tasks:"
    @tasks.each_with_index do |task, index|
      status = task[:completed] ? "Completed" : "Pending"
      puts "#{index + 1}. #{task[:description]} - Status: #{status} (Created on: #{task[:date]})"
    end
  end

  def delete_task(index)
    if index < @tasks.length && index >= 0  # Validar índice
      task = @tasks[index]
      puts "Are you sure you want to delete the task: '#{task[:description]}'? (yes/no)"
      confirmation = gets.chomp.downcase

      if confirmation == "yes"
        @tasks.delete_at(index)
        puts "Task '#{task[:description]}' has been deleted."
      else
        puts "Deletion cancelled."
      end
    else
      puts "Invalid index! Please provide a valid task number."
    end
  end
end


tasklist = Tasklist.new
tasklist.new_task
tasklist.list
puts "Enter the task number you want to delete:"
task_index = gets.chomp.to_i - 1  # Restamos 1 porque los índices empiezan en 0
tasklist.delete_task(task_index)
tasklist.list
