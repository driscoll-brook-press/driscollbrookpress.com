module Catalog
  AVAILABLE = %w(new now)

  def available_now(books)
    books.select { |book| AVAILABLE.include? book['availability'] }
  end

  def by_title(books)
    books.sort_by { |book| book['sort'] || book['title'] }
  end

  def coming_soon(books)
    books.select { |book| book['availability'] == 'soon' }
  end

  def in_genre(books, genre)
    books.select { |book| book['genre'] == genre }
  end

  def new_releases(books)
    books.select { |book| book['availability'] == 'new' }
  end

  def newest_first(books)
    oldest_first(books).reverse
  end

  def oldest_first(books)
    books.sort_by { |book| book['date'] }
  end
end

Liquid::Template.register_filter(Catalog)
