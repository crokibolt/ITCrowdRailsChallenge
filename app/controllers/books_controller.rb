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
      if params[:author].presence && params[:publisher].presence
        books = Book.includes(:author, :publisher)
        .where(:author_id => params[:author], 
                :publisher_id => params[:publisher]).page(params[:page]).per(4)
      elsif params[:author].presence
        books = Book.includes(:author, :publisher)
        .where(:author_id => params[:author]).page(params[:page]).per(4)
      elsif params[:publisher].presence
        books = Book.includes(:author, :publisher)
        .where(:publisher_id => params[:publisher]).page(params[:page]).per(4)
      else
        books = Book.includes(:author, :publisher).page(params[:page]).per(4)
      end

      books
    end
end
