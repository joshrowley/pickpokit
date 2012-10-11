require 'open-uri'
require 'nokogiri'
require 'sqlite3'


# db = SQLite3::Database.new( "test.db" )
# db.execute ("CREATE table user (id INTEGER PRIMARY KEY, name TEXT)")
# db.execute ("CREATE table quiz (id INTEGER PRIMARY KEY, name TEXT)")
# db.execute ("CREATE table question (id INTEGER PRIMARY KEY,content TEXT,quiz_id INTEGER)")
# db.execute ("CREATE table choice (id INTEGER PRIMARY KEY,content TEXT,correct BOOLEAN,question_id INTEGER)")
# db.execute ("CREATE table answer (id INTEGER PRIMARY KEY,user_id INTEGER,question_id INTEGER,choice_id INTEGER)")






doc = Nokogiri::HTML(open("http://students.flatironschool.com/joshrowley.html"))

names = []
doc.css('h1').each do |node|
	names << node.text
end

puts names.inspect

# names.each do |name|
# 	db.execute "INSERT INTO user (name) VALUES (#{name});"
# end

# name_seed = 'INSERT INTO user (name) VALUES ("Josh"), ("Li"), ("Matt");'
# db.execute (name_seed)