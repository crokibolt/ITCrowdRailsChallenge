class PriceModifyJob < ApplicationJob
  queue_as :default

  def perform(publisher_id, option, percentage)
    books = Book.where(publisher_id: publisher_id)

    books.each do |book| 
      if option == "increase"
        new_price = book.price * (1 + (percentage.to_i/100))
      elsif option == "decrease"
        new_price = book.price * (1 - (percentage.to_i/100))
      else 
        new_price = book.price
      end
      book.update_attribute(:price, new_price)
    end
  end
  puts "Price modification completed"
end
