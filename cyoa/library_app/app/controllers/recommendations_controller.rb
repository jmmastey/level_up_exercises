class RecommendationsController < ApplicationController

  def update
    book_id = params[:id]
    user_id = current_user.id
    @user_recommendation = Recommendation.find_by(book_id:book_id, user_id:user_id)
    if @user_recommendation
      @user_recommendation.recommended = !@user_recommendation.recommended
    else
      @user_recommendation = Recommendation.new({:user_id => current_user.id, :book_id => book_id})
      @user_recommendation.recommended = !@user_recommendation.recommended
    end
    @user_recommendation.save
  end
 
  def recommended_books
   recs = Recommendation.where(recommended: true)
   #Get list of book id's
   book_ids = []
   recs.each do |rec|
     book_ids.push(rec.book_id)  
   end
   @recommended_books = Book.where(id: book_ids)
   #Take out books that are already in this user's library?
   @recommended_books = @recommended_books.select { |book| current_user.books.where(id: book.id).length == 0 }
  end
   
  def detailed_rec_info
    oclc_num = params[:oclc]
    puts 'did we get the book oclc', oclc_num
    @book = Book.where(oclc: oclc_num).first
    puts 'what about the book', @book
  end

end
