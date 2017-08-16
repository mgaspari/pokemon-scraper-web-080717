class Pokemon
  attr_accessor :name, :type, :db, :id
  def initialize(name:, type:, db:, id: nil)
    puts hash
    @name = name
    @type = type
    @db = db
    @id = id
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
    SQL
    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() from pokemon")[0][0]
    self
  end

  def self.find(id, db)
    sql = ("SELECT * FROM pokemon WHERE id = ?")
    fPokemon = db.execute(sql, id)[0]
    Pokemon.new(id: fPokemon[0], name:fPokemon[1], type:fPokemon[2], db: db)
  end
end
