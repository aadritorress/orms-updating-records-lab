require_relative "../config/environment.rb"

class Student

  attr :id, :name, :grade

  def initialize(id =nil, name, grade)
    @id = id 
    @name = name 
    @grade = grade
  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]
end


def self.create_table
  sql = <<-SQL
  CREATE TABLE students (
  id INTEGER PRIMARY KEY,
  name TEXT,
  grade INTEGER
); 
SQL

DB[:conn].execute(sql)
end


def self.drop_table
  sql = <<-SQL
  DROP TABLE students 
SQL

DB[:conn].execute(sql)
end


def save 
  sql = <<-SQL
  INSERT INTO students (name, grade) 
  VALUES (?, ?)
SQL

DB[:conn].execute(sql, self.name, self.grade)
 end


def self.create


end 

def self.find_by_name(name)
  sql = <<-SQL
  SELECT *
  FROM students
  WHERE name = ?
SQL

DB[:conn].execute(sql, name).map do |row|
  self.new_from_db(row)
end
end
end 