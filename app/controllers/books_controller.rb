class BooksController < ApplicationController
  before_action :set_book, only: [ :show, :edit, :update, :destroy ]
  before_action :set_authors, only: [ :index, :edit, :new]
  before_action :set_publishers, only: [ :index, :edit, :new, :prices_edit ]
  before_action :authenticate_admin!, except: [:index, :show]

  # GET /books or /books.json
  def index
    @books = filter
  end

  # GET /books/1 or /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was successfully created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was successfully updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy!

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def prices_edit
  end

  def prices_update
    PriceModifyJob.set(wait: 5.seconds).perform_later(params[:publisher], params[:option], 
      params[:percentage])
    redirect_to books_url
  end

  def search
    fields = params[:search].split(', ')
    if fields.length == 4
      @book = Book.includes(:author, :publisher).where(title: fields[0],
        isbn: fields[1],
        author: {first_name: fields[2].split[0], last_name: fields[2].split[1]},
        publisher: {name: fields[3]})[0]
      
      if !@book.presence
        redirect_to root_path, alert: "Book not found"
      else
        redirect_to frontend_book_path(@book)
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.includes(:author, :publisher).find(params[:id])
    end

    def set_authors
      @authors = Author.select("id, first_name, last_name")
    end

    def set_publishers
      @publishers = Publisher.select("id, name")
    end

    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :isbn, :date_of_publication,
      :review, :price, :author_id, :publisher_id)
    end

    def filter
      books = Book.includes(:author, :publisher).all
      
      if params[:author].presence

        books = books.where(author: {id: params[:author]})
                        
      end

      if params[:publisher].presence

        books = books.where(publisher: {id: params[:publisher]})

      end

      books.page(params[:page]).per(4)
    end
end
