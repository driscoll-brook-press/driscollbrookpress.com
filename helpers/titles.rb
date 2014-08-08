module Titles
    def title_link(slug)
        link_to title_name(slug), title_url(slug)
    end

    def title_name(slug)
        matches = blog.articles.select{|title| title.slug == "#{slug}.html"}
        matches.first.title
    end

    def title_url(slug)
        "/title/#{slug}"
    end
end
