class TagSearchesController < ApplicationController
  
  def tag_search
    @model = Book
    @word = params[:word]
    @books = Book.where(tag: @word)
    render 'searches/search'
  end
  
end
