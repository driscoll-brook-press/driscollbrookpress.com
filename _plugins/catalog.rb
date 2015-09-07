module Catalog
  AVAILABLE = %w(new now)

  def available_now(books)
    books.select { |book| AVAILABLE.include? book.data['availability'] }
  end

  def by_title(books)
    books.sort_by { |book| book.data['sort'] || book.data['title'] }
  end

  def coming_soon(books)
    books.select { |book| book.data['availability'] == 'soon' }
  end

  def in_genre(books, genre)
    books.select { |book| book.data['genre'] == genre }
  end

  def new_releases(books)
    books.select { |book| book.data['availability'] == 'new' }
  end

  def newest_first(books)
    oldest_first(books).reverse
  end

  def oldest_first(books)
    books.sort_by { |book| book.data['date'] }
  end
end

Liquid::Template.register_filter(Catalog)
