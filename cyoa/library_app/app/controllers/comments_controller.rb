class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def add_comment
    oclc = params[:oclc]
    comment = params[:comment]
    book = Book.all.select { |current_book| current_book.oclc == oclc }
    return 'Error with finding book' if book.length == 0
    book = book[0] if book.length > 0
    user_comment = Comment.new({:user_id => current_user.id, :book_id => book.id, :comment => comment} )
    user_comment.save
  end

  def delete_comment
    comment_id = params[:comment_id].to_i
    puts 'what is comment id?'
    comment_to_delete = Comment.all.select { |comment| comment.id == comment_id }[0]
    return 'Cannot delete comment from a different user' if comment_to_delete.user_id != current_user.id
    comment_to_delete.destroy
  end
    

end
