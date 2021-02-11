class Pokemon
  attr_accessor :id, :name, :type, :db

  def initialize(id:nil, name:, type:, db:)
    # @id = id
    # @name = name
    # @type = type
    # @db = db
    @id, @name, @type, @db = id, name, type, db
  end
  
  def self.save(name, type, db)
    new_mon = self.new(name: name, type: type, db: db)
    sql = <<-SQL
      INSERT INTO pokemon (name, type) VALUES
      (?, ?);
    SQL
    db.execute(sql, new_mon.name, new_mon.type)

    @id = db.execute("SELECT last_insert_rowid() FROM pokemon;")[0][0]
    new_mon
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon WHERE id = ?;
    SQL
    # found = db.execute(sql, id)
    # self.new(id: found[0][0], name: found[0][1], type: found[0][2], db:@db)
    found = db.execute(sql, id).flatten
    self.new(id: found[0], name: found[1], type: found[2], db:db)
  end
end
