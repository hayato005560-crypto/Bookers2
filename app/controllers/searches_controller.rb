class SearchesController < ApplicationController
  def search
    @range = params[:range]
    @word = params[:word]
    @search = params[:search]

    if @range == "User"
      @records = User.search_for(@word, @search)
    else
      @records = Book.search_for(@word, @search)
    end
  end
end
