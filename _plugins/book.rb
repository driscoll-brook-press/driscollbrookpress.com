module Book
  def book_link book
    "<a href='#{book.url}'>#{book.data['title']}</a>"
  end

  def with_slug books, slug
    books.find { |book| slug == self.slug(book.url) }
  end

  def slug book_url
    book_url.split('/').last.split('.').first
  end

  def cover_image book
    "<img src='#{cover_url(book)}' />"
  end

  def cover_url book
    '/images/%s-cover-web.jpg' % self.slug(book['url'])
  end
end

Liquid::Template.register_filter(Book)
