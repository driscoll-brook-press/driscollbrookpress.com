module Books
    class Catalog
        def initialize(posts)
            @books = posts.map do|post|
                Book.new(post)
            end
        end

        def available()
            @books.select{|book| book.available?}
        end

        def new_releases()
            @books.select{|book| book.new?}
        end

        def coming_soon()
            @books.select{|book| book.coming_soon?}
        end

    end

    class Book
        attr_reader :description, :slug, :title

        def initialize(post)
            @slug = File.basename post.slug, '.html'
            @title = post.title
            @description = post.body
            post.data.each do |k,v|
                self.instance_variable_set("@#{k}", v)
                self.class.send(:define_method, k, proc{self.instance_variable_get("@#{k}")})
            end
        end

        def new?
            @availability == 'new'
        end

        def available?
            ['new', 'now'].include? @availability
        end

        def coming_soon?
            @availability == 'soon'
        end

        def cover_url()
           "/images/#{@slug}-cover-web.jpg"
        end

        def url
            "/title/#{@slug}/"
        end
    end
end
