# Joel H. Maisonet Ayala
# Prof Hector Concepción
# Comp 323
# 23 de marzo de 2025

# This job consists of creating a tasklist for 
# people who require a list for their studies or home.

# --------------------------------------------------------------------------------------------------
# Create the class
class Tasklist
  attr_accessor :tasks

  # Function Initialize
  # -------------------------------------------------------------------------------------------------
  def initialize
    @tasks = [] # Save task
  end

  # Function New Task
  # -------------------------------------------------------------------------------------------------
  def new_task
    puts "What's the new task?"
    add = gets.chomp
    date = Time.now  # Current time
    @tasks << { description: add, date: date, completed: false, completion_date: nil }
    puts "Task added: '#{add}' (Created on: #{date})"
  end

  # Function List
  # -------------------------------------------------------------------------------------------------
  def list
    puts "Your tasks:"
    @tasks.each_with_index do |task, index|
      status = task[:completed] ? "Completed" : "Pending"
      puts "#{index + 1}. #{task[:description]} - Status: #{status} (Created on: #{task[:date]})"
    end
  end

  # Function for deleting tasks
  # -------------------------------------------------------------------------------------------------
  def delete_task(index)
    if index < @tasks.length && index >= 0 
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

  # Function Save tasks
  # -------------------------------------------------------------------------------------------------
  def save_tasks(filename = "tasks.txt")
    File.open(filename, "w") do |file|
      @tasks.each do |task|
        completed = task[:completed] ? "1" : "0"
        completion_date = task[:completion_date] || "nil"
        file.puts "#{task[:description]}|#{task[:date]}|#{completed}|#{completion_date}"
      end
    end
    puts "Tasks saved to '#{filename}'."
  end

  # Function Load tasks
  # -------------------------------------------------------------------------------------------------
  def load_tasks(filename = "tasks.txt")
    if File.exist?(filename)
      @tasks.clear 
      File.readlines(filename).each do |line|
        description, date, completed, completion_date = line.chomp.split("|")
        @tasks << {
          description: description,
          date: Time.parse(date),
          completed: completed == "1",
          completion_date: (completion_date == "nil" ? nil : Time.parse(completion_date))
        }
      end
      puts "Tasks loaded from '#{filename}'."
    else
      puts "File '#{filename}' does not exist!"
    end
  rescue IOError => e
    puts "IO Error: #{e.message}"
  end

  # Function for loading a different file
  # -------------------------------------------------------------------------------------------------
  def load_different_file
    puts "Enter the filename to load tasks from:"
    filename = gets.chomp
    load_tasks(filename)
  end
end

# -------------------------------------------------------------------------------------------------
# Instance and Menu
tasklist = Tasklist.new

loop do
  puts "\n----- Task Manager Menu -----"
  puts "1. Add a new task"
  puts "2. List all tasks"
  puts "3. Delete a task"
  puts "4. Save tasks to file"
  puts "5. Load tasks from file"
  puts "6. Exit"
  print "Choose an option: "

  choice = gets.chomp.to_i

  # Start Case
  begin
    case choice
    when 1  # New task
      tasklist.new_task

    when 2 # List tasks
      tasklist.list

    when 3 # Delete task
      puts "Enter the task number you want to delete:"
      task_index = gets.chomp.to_i - 1
      tasklist.delete_task(task_index)

    when 4 # Save tasks
      tasklist.save_tasks

    when 5 # Load tasks from file
      puts "Would you like to load from the default file? (yes/no)"
      if gets.chomp.downcase == "yes"
        tasklist.load_tasks
      else
        tasklist.load_different_file
      end

    when 6 # Exit
      puts "Well, thanks... see you later with more tasks!"
      break
      
    else # Validation
      puts "Invalid option! Please choose a valid number."
    end
  rescue ArgumentError
    puts "Error: Invalid input. Please try again."
  rescue StandardError => e
    puts "An unexpected error occurred: #{e.message}"
  end
end

# -------------------------------------------------------------------------------------------------
# End of Code