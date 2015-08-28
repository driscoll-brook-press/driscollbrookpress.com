module Catalog
  AVAILABLE = %w(new now)

  def available_now(books)
    books.select { |book| AVAILABLE.include? book.data['availability'] }
      .sort_by { |book| book.data['sort'] || book.data['title'] }
  end

  def coming_soon(books)
    books.select { |book| book.data['availability'] == 'soon' }
      .sort_by { |book| book.data['date'] }
  end

  def new_releases(books)
    books.select { |book| book.data['availability'] == 'new' }
      .sort_by { |book| book.data['date'] }
      .reverse
  end
end

Liquid::Template.register_filter(Catalog)
