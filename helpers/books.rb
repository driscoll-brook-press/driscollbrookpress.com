module Books
    class Catalog
        def initialize(posts)
            @books = posts.map do|post|
                Book.new(post)
            end
        end

        def available()
            @books.select{|book| book.available}
        end

        def new_releases()
            @books.select{|book| book.new}
        end

        def coming_soon()
            @books.select{|book| book.soon}
        end

    end

    class Book
        attr_reader :description, :slug, :title

        def initialize(post)
            @slug = post.slug
            @title = post.title
            @description = post.body
            post.data.each do |k,v|
                self.instance_variable_set("@#{k}", v)
                self.class.send(:define_method, k, proc{self.instance_variable_get("@#{k}")})
            end
        end

        def link
            link_to(@name, @url)
        end

        def cover_url()
           "/images/#{File.basename @slug, '.html'}-cover-web.jpg"
        end

        def url
            "/title/#{@slug}"
        end
    end
end
