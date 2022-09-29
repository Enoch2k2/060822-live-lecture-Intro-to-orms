class Cli

  def start
    clear_input_by_seconds(0)
    puts "Welcome to Pet Shop!"
    puts "Loading..."
    clear_input_by_seconds(1)
    menu_options
  end

  def menu_options
    puts "Menu Options"
    puts "---"
    puts "type '1' to list pets"
    puts "type '2' to create pets"
    puts "type '3' to search for a pet by name"
    puts "type '4' to delete a pet"
    puts "type '5' to exit"
    puts "---"
    menu_choice
  end

  def menu_choice
    input = get_input("Please Choose (1-4): ")
    if input == "1"
      puts list_pets
    elsif input == "2"
      puts create_pet
    elsif input == "3"
      puts search_pet_by_name
    elsif input == "4"
      puts delete_pet
    elsif input == "5"
      puts "exiting..."
      exit
    else
      invalid
      menu_options
    end
  end

  def get_input(string)
    print string
    gets.strip
  end

  def clear_input_by_seconds(seconds)
    sleep(seconds)
    system('clear')
  end

  def invalid
    clear_input_by_seconds(0)
    puts "Incorrect Input, trying again..."
    clear_input_by_seconds(1)
  end

  def list_pets(pets = Pet.all)
    clear_input_by_seconds(1)
    puts "Pet List"
    puts "---"
    pets.each.with_index(1) do |pet, idx|
      puts "#{idx}. #{pet.name}"
    end
    puts "---"
    get_input("Hit enter to continue...")
    clear_input_by_seconds(0)
    menu_options
  end

  def create_pet
    clear_input_by_seconds(0)
    puts "Create Pet"
    puts "---"
    pet_name = get_input("Enter the name of your Pet: ")
    Pet.create(pet_name)
    puts "Creating pet..."
    sleep(1)
    puts "Pet Created"
    clear_input_by_seconds(1)
    menu_options
  end
  
  def search_pet_by_name
    clear_input_by_seconds(0)
    puts "Search Pet By Name"
    puts "---"
    term = get_input("Enter a search term: ")
    filtered_pets = Pet.search_by_name(term)
    puts "---"
    if filtered_pets.length > 0
      list_pets(filtered_pets)
    else
      puts "Pet not found"
      clear_input_by_seconds(1)
      menu_options
    end
  end

  def delete_pet
    clear_input_by_seconds(0)
    input = get_input("Type number associated to pet to delete the pet (If you forget the number, list out pets again): ")
    index = input.to_i - 1
    pet = Pet.all[index]
    if pet
      Pet.delete(pet.id)
      puts "Deleting Pet..."
      sleep(1)
      puts "Pet deleted..."
      clear_input_by_seconds(1)
      menu_options
    else
      puts "Pet does not exist, please try again"
      clear_input_by_seconds(1)
      menu_options
    end
  end
end