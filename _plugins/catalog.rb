module Catalog
  AVAILABLE = ['new', 'now']

  def available_now(books)
    books.select{ |book| AVAILABLE.include? book.data['availability'] }
      .sort_by { |book| book.data['title'] }
      .reverse
  end

  def coming_soon(books)
    books.select{ |book| book.data['availability'] == 'soon' }
      .sort_by { |book| book.data['date'] }
  end

  def new_releases(books)
    books.select{ |book| book.data['availability'] == 'new' }
      .sort_by { |book| book.data['date'] }
  end
end

Liquid::Template.register_filter(Catalog)
