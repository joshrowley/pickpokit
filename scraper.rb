require 'open-uri'
require 'nokogiri'
require 'sqlite3'

# Create the database


db = SQLite3::Database.new( "pickpokit.db" )
sql = <<SQL
CREATE table students 
(	id INTEGER PRIMARY KEY,
first_name TEXT,
last_name TEXT,
email TEXT DEFAULT "#",
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

# Index Parser (get URLs for each student)


urlnoki = "http://students.flatironschool.com/"
profile_links = [] 

doc = Nokogiri::HTML(open(urlnoki))
doc.xpath('//div[@class="one_third"]/a').map do |link| 
  profile_links << urlnoki + link['href']
end
doc.xpath('//div[@class="one_third last"]/a').map do |link| 
  profile_links << urlnoki + link['href']
end

# Iterating through all profile_links (array), running scraper, and saving into DB


profile_links.delete_if {|url| url.include?('billy')}
puts profile_links

profile_links.each do |link|
		doc = Nokogiri::HTML(open(link))


		name = doc.css('h1').text
		name = name.split(" ")

		first_name = name[0]
		last_name = name[1]

		app_1 = doc.css('h4')[0].text
		app_2 = doc.css('h4')[1].text
		app_3 = doc.css('h4')[2].text
		unless doc.css('.mail a').empty?
			email = doc.css('.mail a')[0]["href"]
		end
		if email.include?("mailto:")
			email["mailto:"] = ""
		end
		tag_line = doc.css('#tagline')[0].text
		bio = doc.css('.two_third > p').text
		linked_in = doc.css('.linkedin a')[0]["href"]
		blog = doc.css('.blog a')[0]["href"]
		twitter = doc.css('.twitter a')[0]["href"]
		github = doc.css('a[href*="github"]')[0]["href"]
		code_school = doc.css('a[href*="codeschool"]')[0]["href"]
		coder_wall = doc.css('a[href*="coderwall"]')[0]["href"]
		stack_overflow = doc.css('a[href*="stack"]')[0]["href"]
		treehouse = doc.css('a[href*="treehouse"]')[0]["href"]



		db.execute("INSERT INTO students (first_name, last_name, email, tag_line, bio, app_1, app_2, app_3, linked_in, blog, twitter, github, code_school, coder_wall, stack_overflow, treehouse) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)", first_name, last_name, email, tag_line, bio,app_1, app_2, app_3, linked_in, blog, twitter, github, code_school, coder_wall, stack_overflow, treehouse)
end
