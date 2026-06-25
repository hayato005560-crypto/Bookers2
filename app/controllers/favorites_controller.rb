class FavoritesController < ApplicationController
  
    def create
    @book = Book.find(params[:book_id])
    Current.user.favorites.find_or_create_by(book_id: @book.id)
    
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back(fallback_location: book_path(@book)) }
    end
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = Current.user.favorites.find_by(book_id: @book.id)
    favorite&.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back(fallback_location: book_path(@book)) }
    end
  end
  
end