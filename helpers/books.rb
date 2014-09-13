require_relative 'links'

module Books

    class Catalog
        def initialize(posts)
            @books = posts.map do|post|
                Book.new(post)
            end
        end

        def find(slug)
            @books.select{|book| book.slug == slug}.first
        end

        def available
            @books.select{|book| book.available?}
        end

        def new_releases
            @books.select{|book| book.new_release?}
        end

        def coming_soon
            @books.select{|book| book.coming_soon?}
        end

    end

    class Book
        attr_reader :description, :slug, :title, :url

        def initialize(post)
            @slug = File.basename post.slug, '.html'
            @title = post.title
            @description = post.body
            @url = post.url
            post.data.each do |k,v|
                self.instance_variable_set("@#{k}", v)
                self.class.send(:define_method, k, proc{self.instance_variable_get("@#{k}")})
            end
        end

        def new_release?
            @availability == 'new'
        end

        def available?
            ['new', 'now'].include? @availability
        end

        def coming_soon?
            @availability == 'soon'
        end

        def publication_date
            Date.parse(@pubdate).strftime("%B %-d, %Y")
        end

        def cover_link
            link cover_image, @url
        end

        def cover_link_to_cover_image
            link cover_image, cover_url
        end

        def title_link
            link @title, @url
        end

        def url
            "/title/#{@slug}/"
        end
        
        def cover_image
            "<img src='#{cover_url}' />"
        end

        def cover_url
           "/images/#{@slug}-cover-web.jpg"
        end
    end
end
