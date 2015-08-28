module Books
  def catalog
    @titles ||= sitemap.resources.select { |resource| resource.path.start_with? 'title/' }
    @catalog ||= Catalog.new @titles
  end

  class Catalog
    def initialize(pages)
      @books = pages.map { |page| Book.new(page) }
    end

    def find(slug)
      @books.find { |book| book.slug == slug }
    end

    def available
      @books.select(&:available?).sort_by(&:sort_title)
    end

    def new_releases
      @books.select(&:new_release?).sort_by(&:date).reverse
    end

    def coming_soon
      @books.select(&:coming_soon?).sort_by(&:date)
    end
  end

  class Book
    def initialize(page)
      @page = page
    end

    def slug
      File.basename(@page.path, '.html')
    end

    def about
      @page.render({ layout: false })
    end

    def method_missing(meth, *_args, &_block)
      property meth.to_s
    end

    def property(name)
      @page.metadata[:page][name]
    end

    def new_release?
      availability == 'new'
    end

    def available?
      %w(new now).include? availability
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
