require 'pry'
require 'sqlite3'

DB = SQLite3::Database.new "pets.db"

create_table_pets = <<-SQL
  CREATE TABLE IF NOT EXISTS pets (
    id INTEGER PRIMARY KEY,
    name TEXT
  );
SQL

DB.execute(create_table_pets)

require_relative "../lib/cli"
require_relative "../lib/pet"

# Pet.create("Bobo")
# Pet.create("Bob")
# Pet.create("Leah")
# Pet.create("Sarah")
# Pet.create("Jojo")
# Pet.create("Butch")
# Pet.create("Bubbles")
# Pet.create("Garfield")