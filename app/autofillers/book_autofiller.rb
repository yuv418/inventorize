class BookAutofiller < Autofill
  def_fields :isbn, :title, :author, :publication, feed: :isbn

  def fill
    # Put your autofill code here. This code will automatically get executed on the object's instantiation.
    # You can use the instance variable @fields in order to access the fields that were previously defined.
    info = JSON.parse HTTP.get("https://openlibrary.org/api/books?bibkeys=ISBN:#{@fields[:isbn]}&format=json&jscmd=data").body
  end
end
