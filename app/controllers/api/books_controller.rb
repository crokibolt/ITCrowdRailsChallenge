module Api
  class BooksController < ActionController::API
    before_action :set_book, only: [ :show, :edit, :update, :destroy ]
    before_action :set_authors, only: [ :index, :edit, :new]
    before_action :set_publishers, only: [ :index, :edit, :new ]

    def index
      @books = filter
      render json: {books: @books,
       pagination: {
          total_pages: @books.total_pages,
          limit: @books.limit_value,
          current_page: @books.current_page,
       }}, status: :ok
    end

    def show
    end

    def new
      @book = Book.new
    end

    def edit
    end

    def create
      create_params = book_params
      
      @author = Author.where(first_name: params[:author].split[0],
                             last_name: params[:author].split[1])[0]
      @publisher = Publisher.where(name: params[:publisher])[0]

      @book = Book.new(
        title: create_params[:title],
        isbn: create_params[:isbn],
        date_of_publication: create_params[:date_of_publication],
        review: create_params[:review],
        price: create_params[:price],
        author: @author,
        publisher: @publisher
      )

      if @book.save
        render json: @book, status: :created
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end

    def update
      create_params = book_params
      
      @author = Author.where(first_name: params[:author].split[0],
                             last_name: params[:author].split[1])[0]

      @publisher = Publisher.where(name: params[:publisher])[0]

      if @book.update( 
        title: create_params[:title],
        isbn: create_params[:isbn],
        date_of_publication: create_params[:date_of_publication],
        review: create_params[:review],
        price: create_params[:price],
        author: @author,
        publisher: @publisher)

        render json: @book, status: :ok, location: @book
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @book.destroy!
    end

    private

    def set_book
      @book = Book.includes(:author, :publisher).find(params[:id])
    end

    def set_authors
      @authors = Author.select("id, first_name, last_name")
    end

    def set_publishers
      @publishers = Publisher.select("id, name")
    end

    def book_params
      params.require(:book).permit(:title, :isbn, :date_of_publication,
      :review, :price)
    end

    def filter
      if params[:author].presence && params[:publisher].presence

      books = Book.includes(:author, :publisher)
        .where(author: {first_name: params[:author].split[0],
                        last_name: params[:author].split[1]}, 
                        publisher: {name: params[:publisher]})
                        .page(params[:page]).per(4)

      elsif params[:author].presence

        books = Book.includes(:author, :publisher)
        .where(author: {first_name: params[:author].split[0],
                        last_name: params[:author].split[1]})
                        .page(params[:page]).per(4)
                        
      elsif params[:publisher].presence

        books = Book.includes(:author, :publisher)
        .where(publisher: {name: params[:publisher]}).page(params[:page]).per(4)

      else
        books = Book.includes(:author, :publisher).page(params[:page]).per(4)
      end

      books
    end
  end

end
