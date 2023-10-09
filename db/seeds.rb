# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Book.destroy_all
Author.destroy_all
Publisher.destroy_all


50.times do
  full_name = (Faker::Book.unique.author).split
  author = Author.create(
    first_name: full_name[0],
    last_name: full_name[1],
    date_of_birth: Faker::Date.between(from: '1930-01-01', to: 3.years.ago),
    about: Faker::Lorem.sentence(word_count: 3),
    nationality: Faker::Nation.nationality
  )

  publisher = Publisher.create(
    name: Faker::Book.unique.publisher
  )
  
  2.times do 
    book1 = Book.create!(
        title: Faker::Book.unique.title,
        isbn: Faker::Code.isbn(base: 13),
        date_of_publication: Faker::Date.between(from: '1930-01-01', to: Date.today),
        review: Faker::Lorem.sentence(word_count: 6),
        price: Faker::Number.decimal(l_digits: 2, r_digits: 2),
        author: author,
        publisher: publisher
        )
    end

#   book2 = Book.create(
#     title: Faker::Book.unique.title,
#     isbn: Faker::Number.unique(digits:13),
#     review: Faker::Lorem.sentence(word_count: 6),
#     price: Faker::Number.between(from: 4.00, to: 55.00),
#     author: author,
#     publisher: publisher
#   )
end

# author1 = Author.find_or_create_by!(first_name: "Stephen", last_name: "King", 
# date_of_birth: Date.new(1947, 9, 21), 
# about: "Stephen Edwin King (born September 21, 1947) is an American author"+
# " of horror, supernatural fiction, suspense, crime, science-fiction," + 
# " and fantasy novels.", nationality: "USA")

# publisher1 = Publisher.find_or_create_by!(name: "Scribner")

# book1 = Book.find_or_create_by!(title: "Misery", 
#     isbn: "9781501143106", 
#     date_of_publication: Date.new(2016, 1, 5), 
#     review: '“King at his best...a winner.” ― The New York Times',
#     price: 13.27, author: author1, publisher: publisher1)
    
# author2 = Author.find_or_create_by!(first_name: "J.K.", last_name: "Rowling",
#     date_of_birth: Date.new(1965, 7, 31),
#     about: "J.K. Rowling is the author of the enduringly popular, era-defining" +
#     " Harry Potter book series.", nationality: "USA")

# publisher2= Publisher.find_or_create_by!(name: "Scholastic Press");

# book2 = Book.find_or_create_by!(title: "Harry Potter and the Goblet of Fire",     
#     isbn: "9780439139595",
#     date_of_publication: Date.new(2000, 8, 1), 
#     review: "In Harry Potter and the Goblet of Fire, J.K. Rowling offers up" + 
#     " equal parts danger and delight--and any number of dragons, house-elves," +
#     " and death-defying challenges.",
#     price: 18.49, author: author2, publisher: publisher2)
    
# author3 = Author.find_or_create_by!(first_name: "Daniel", last_name: "Kahneman",
#     date_of_birth: Date.new(1934, 3, 5),
#     about: "Daniel Kahneman is an Israeli-American psychologist notable for" +
#     " his work on the psychology of judgment and decision-making, as well as" +
#     " behavioral economics.",
#     nationality: "Israel")

# publisher3 = Publisher.find_or_create_by!(name: "Farrar, Straus and Giroux")

# book3 = Book.find_or_create_by!(title: "Thinking, Fast and Slow", 
#     isbn: "9780374275631",
#     date_of_publication: Date.new(2011, 10, 25),
#     review: "It is an astonishingly rich book: lucid, profound, full of" +
#     " intellectual surprises and self-help value. It is consistently" +
#     " entertaining.. So impressive is its vision of flawed human reason that" +
#     " the New York Times columnist David Brooks recently declared that" + 
#     " Kahneman and Tversky's work 'will be remembered hundreds of years from" +
#     " now', and that it is a crucial pivot point in the way we see ourselves.",
#     price: 18.00, author: author3, publisher: publisher3)
