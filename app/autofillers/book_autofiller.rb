class BookAutofiller < Autofill
  def_fields :isbn, :title, :author, :publisher, feed: :isbn

  def fill
    # Put your autofill code here. This code will automatically get executed on the object's instantiation.
    # You can use the instance variable @fields in order to access the fields that were previously defined.
    info = JSON.parse(HTTP.get("https://openlibrary.org/api/books?bibkeys=ISBN:#{@fields[:isbn]}&format=json&jscmd=data").body)["ISBN:#{@fields[:isbn]}"]

    @fields[:publisher] = info["publishers"].map { |pub| pub["name"] }
    @fields[:title] = info["title"]
    @fields[:author] = info["authors"].map { |i| i["name"] }
  end
end
