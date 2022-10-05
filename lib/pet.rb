class Pet < ActiveRecord::Base
  def self.search_by_name(term)
    Pet.where('LOWER(pets.name) LIKE ?', "%#{term.downcase}%")
  end
end