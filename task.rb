class Task
  attr_reader :id
  attr_accessor :title, :description, :done

  def initialize(attributes = {})
    @id = attributes[:id]
    @title = attributes[:title]
    @description = attributes[:description]
    @done = attributes[:done] || false
  end

  def self.find(id)
    task = DB.execute("SELECT * FROM tasks WHERE id = ?", id).first
    return build_instance(task) if task
  end

  def save
    !id ? create : update
  end

  def destroy
    DB.execute("DELETE FROM tasks WHERE id = ?", id).first
  end

  def self.all
    attributes = DB.execute("SELECT * FROM tasks")
    attributes.map { |attribute| build_instance(attribute) }
  end

  def self.build_instance(attributes)
    Task.new(
      id: attributes['id'],
      title: attributes['title'],
      description: attributes['description'],
      done: attributes['done'] == 1
    )
  end


  private

  def create
    DB.execute("INSERT INTO tasks(title, description)
    VALUES (?, ?)" , title, description)
    @id = DB.last_insert_row_id
  end

  def update
    done_as_i = done ? 1 : 0
    DB.execute(
      "UPDATE tasks
      SET title = ?, description = ?, done = ?
      WHERE id = ?",
      title, description, done_as_i, id
    )
  end
end
