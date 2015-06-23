class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def add_comment
    oclc = params[:oclc]
    comment = params[:comment]
    book = current_user.books.where(oclc: oclc).first
    return 'Book not found' if !book 
    Comment.create({:user_id => current_user.id, :book_id => book.id, :comment => comment} )
  end

  def delete_comment
    comment_id = params[:comment_id].to_i
    #Is it better to look up the comment from the comments table and then see 
    #if it belongs to the user or to look up all the users comments and then 
    #find the one we are looking for?
    comment_to_delete = current_user.comments.where(id: comment_id).first
    return 'Cannot find a comment with this id for current user' if !comment_to_delete
    comment_to_delete.destroy
  end
    

end
