require 'open-uri'
require 'nokogiri'
require 'sqlite3'

doc = Nokogiri::HTML(open("http://students.flatironschool.com/davidbaker.html"))


name = doc.css('h1').text
name = name.split(" ")

first_name = name[0]
last_name = name[1]

app_1 = doc.css('h4')[0].text
app_2 = doc.css('h4')[1].text
app_3 = doc.css('h4')[2].text

email = doc.css('.mail a')[0]["href"]
email["mailto:"] = ""
tag_line = doc.css('#tagline')[0].text
bio = doc.css('.two_third > p').text
linked_in = doc.css('.linkedin a')[0]["href"]
blog = doc.css('.blog a')[0]["href"]
twitter = doc.css('.twitter a')[0]["href"]
github = doc.css('a[href*="github"]')[0]["href"]
code_school = doc.css('a[href*="codeschool"]')[0]["href"]
coder_wall = doc.css('a[href*="coderwall"]')[0]["href"]
stack_overflow = doc.css('a[href*="stackoverflow"]')[0]["href"]
treehouse = doc.css('a[href*="treehouse"]')[0]["href"]

db = SQLite3::Database.new( "scraper.db" )

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

db.execute("INSERT INTO students (first_name, last_name, email, tag_line, bio, app_1, app_2, app_3, linked_in, blog, twitter, github, code_school, coder_wall, stack_overflow, treehouse) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", first_name, last_name, email, tag_line, bio,app_1, app_2, app_3, linked_in, blog, twitter, github, code_school, coder_wall, stack_overflow, treehouse)

db.execute("INSERT INTO students (github, twitter, code_school) VALUES (?, ?)", github, twitter, code_school)

puts app_1
puts app_2
puts app_3
puts first_name
puts last_name
puts email
puts tag_line
puts bio
puts linked_in
puts blog
puts twitter
puts github
puts code_school
puts coder_wall
puts stack_overflow
puts treehouse


