class Pet
  attr_accessor :name, :id

  def initialize(name, id=nil)
    @name = name
    @id = id
  end

  def save
    # add the record into the database based on the instances attributes
    sql = <<-SQL
      INSERT INTO pets (name) VALUES (?)
    SQL
    DB.execute(sql, self.name)
    get_last_id_sql = <<-SQL
      SELECT pets.id FROM pets ORDER BY pets.id DESC LIMIT 1
    SQL

    self.id = DB.execute(get_last_id_sql).flatten[0]
    # our instance will also be assigned the id according to what the database gives it
  end

  def self.create(name)
    self.new(name).tap{ |p| p.save }
  end

  def self.delete(id)
   sql = <<-SQL
    DELETE FROM pets WHERE pets.id = ?
   SQL

   DB.execute(sql, id)
  end

  def self.search_by_name(term)
    # Pet.all.find_all { |pet| pet.name.downcase.include?(term.downcase)}
    sql = <<-SQL
      SELECT * FROM pets WHERE LOWER(pets.name) LIKE (?)
    SQL

    records = DB.execute(sql, "%#{term.downcase}%")
    records.map do |record|
      name = record[1]
      id = record[0]
      Pet.new(name, id)
    end
  end

  def self.all
    # this will access and create instances out of all of the pet records in the database
    sql = <<-SQL
      SELECT * FROM pets
    SQL

    all = DB.execute(sql)
    all.map do |record|
      name = record[1]
      id = record[0]
      Pet.new(name, id)
    end
  end
end