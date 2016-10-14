module Book
  def book_link(book)
    %Q{<a href="#{book.url}">#{book['title']}</a>}
  end

  def with_slug(books, slug)
    books.find { |book| slug == self.slug(book.url) }
  end

  def slug(book_url)
    book_url.split('/').last.split('.').first
  end

  def cover_image(book)
    %Q{<img class="cover-image" src="#{cover_url(book)}" alt="Cover image for #{book['title']}"/>}
  end

  def cover_url(book)
    '/images/%s-cover-web.jpg' % self.slug(book['url'])
  end
end

Liquid::Template.register_filter(Book)
