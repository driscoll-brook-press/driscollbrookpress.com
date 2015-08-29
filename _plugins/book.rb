module Book
  def book_link book
    "<a href='#{book.url}'>#{book.data['title']}</a>"
  end

  def with_slug books, slug
    books.find { |book| slug == self.slug(book.url) }
  end

  def slug url
    url.split('/').last.split('.').first
  end
end

Liquid::Template.register_filter(Book)
