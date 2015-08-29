module Book
  def book_link_for_slug slug
    @books ||= Jekyll.sites[0].collections['books'].docs
    book = @books.find { |book| slug == slug_for_book(book) }
    "<a href='#{book.url}'>#{book.data['title']}</a>"
  end

  def slug_for_book book
    book.url.split('/').last.split('.').first
  end
end

Liquid::Template.register_filter(Book)
