# Lista-de-tareas
Este trabajo consta de una lista de taras normal


El proyecto se estructuro con una sola clase aunque se penso hacer multiples pero se opto por una para más simplicidad.
con esto hicimos multiples funciones que son lo que establece el main para la funcionalidad de crear, escribir, eliminar, ver la lista,
actualizar lista y cambiar archivo. 

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


  En esta parte del código, el ususario puede escoger que hacer en el código, para guardarlo en el file
  tiene que darle al 4 siempre para que se guarde, de lo contrario no se guarda.


2

    def initialize
    @tasks = [] # Save task
  end


En esta parte la tengo para que las tareas se guarden ahí y poder manejarlo con mayor facilidad por todo el código



3.


  def new_task
    puts "What's the new task?"
    add = gets.chomp
    date = Time.now  # Current time
    @tasks << { description: add, date: date, completed: false, completion_date: nil }
    puts "Task added: '#{add}' (Created on: #{date})"
  end



En esta parte del código, tengo la función para que haga las nuevas tareas y la fecha en la que lo creo,
pongo la descripcion al añadir, la fecha y si fue completado.


4.

 def list
    puts "Your tasks:"
    @tasks.each_with_index do |task, index|
      status = task[:completed] ? "Completed" : "Pending"
      puts "#{index + 1}. #{task[:description]} - Status: #{status} (Created on: #{task[:date]})"
    end
  end


En esta parte como pueden ver, aquí pueden ver la lista de las tareas por ahcer con su respectivo indice para poder
eliminarlas luego y saber que tarea es primera y tal. Te dice si esta pendiente o no


5.


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


Esta sección es para poder eliminar las tareas junto a la lista, porque con el índice de la tarea puedo saber si eliminarla o no
una vez este eso, hago la pregunta si esta seguro de eliminarla y si marca que sí pues se elimina, de lo contrario seguirá ahí



6.


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


Para esta parte, hice una para guardar el archivo con la sección de si fue completada, la fecha de completación
y en dondé se alojo



7.


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


En esta parte de cargar el archivo, es para guardar los datos de la tarea y así subirlo
directamente al .txt. Tiene validaciones por si se esta creado el file lo cree o no y manejo la excepción por si existe o no también


8.

 def load_different_file
    puts "Enter the filename to load tasks from:"
    filename = gets.chomp
    load_tasks(filename)
  end
end


Este es para hacer una carga de un diferente archivo 


9.



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


Ya este es el final del código con el main de las funciones completas. Escoger uno es para crear el archivo
escoger el 2 es para a listar las tareas, el 3ro es para elimianar alguna tarea, 4to es para guardar la tarea
, 5to es para cargar la tarea al file y el 6to es para el nuevo file. El 6to obviamente es para salir, tiene sus begin y rescue que
consideré necesarios.