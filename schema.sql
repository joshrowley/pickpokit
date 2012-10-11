require 'sqlite3'

db = SQLite3::Database.new( "pickpokit.db" )

sql = <<SQL
CREATE table students 
(	id INTEGER PRIMARY KEY,
	first_name TEXT,
	last_name TEXT,
	email TEXT,
	tag_line TEXT,
	bio TEXT,
	image TEXT,
	app_1 TEXT,
	app_2 TEXT,
	app_3 TEXT,
	linked_in TEXT,
	blog TEXT,
	twitter TEXT,
	github TEXT,
	code_school TEXT,
	coder_wall TEXT,
	stack_overflow TEXT,
	treehouse TEXT
	);
SQL

db.execute_batch( sql )