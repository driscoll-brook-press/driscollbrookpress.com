module Books
  def catalog
    @titles ||= sitemap.resources.select{|r| r.path.start_with? 'title/'}
    Catalog.new @titles
  end


  class Catalog
    def initialize(pages)
      @books = pages.map do |book|
        Book.new(book)
      end
    end

    def find(slug)
      @books.select{|book| book.slug == slug}.first
    end

    def available
      @books.select{|book| book.available?}.sort_by{|book| book.sort_title}
    end

    def new_releases
      @books.select{|book| book.new_release?}.sort_by{|book| book.pubdate}.reverse
    end

    def coming_soon
      @books.select{|book| book.coming_soon?}.sort_by{|book| book.pubdate}
    end
  end

  class Book
    def initialize(resource)
      @resource = resource
    end

    def method_missing(meth, *args, &block)
      property meth.to_s
    end

    def property(name)
      option(name) || page_property(name)
    end

    def option(name)
      metadata(:options, name.to_sym)
    end

    def page_property(name)
      metadata(:page, name)
    end

    def slug
      File.basename(@resource.path, '.html')
    end

    def metadata group, name
      @resource.metadata[group][name]
    end

    def new_release?
      availability == 'new'
    end

    def available?
      ['new', 'now'].include? availability
    end

    def coming_soon?
      availability == 'soon'
    end

    def cover_link
      link cover_image, url
    end

    def cover_link_to_cover_image
      link cover_image, cover_url
    end

    def sort_title
      sort || title
    end

    def title_link
      link title, url
    end

    def url
      "/title/#{slug}/"
    end

    def cover_image
      "<img src='#{cover_url}' />"
    end

    def cover_url
      "/images/#{slug}-cover-web.jpg"
    end
  end
end
