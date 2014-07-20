module BookHelpers
    AMAZON_AFFILIATE_ID = "driscollbrookpress-20"
    
    def cover_url book
        "/images/#{File.basename book.slug, '.html'}-cover-web.jpg"
    end

    def ebook_links book
        links = []
        return [] unless book.ebook
        links <<= ibooks_link(book) if book.ebook.ibooks
        links <<= kindle_link(book) if book.ebook.kindle
        links <<= kobo_link(book) if book.ebook.kobo
        links <<= nook_link(book) if book.ebook.nook
        links <<= smashwords_link(book) if book.ebook.smashwords
    end

    def paperback_links book
        links = []
        return links unless book.paperback
        links <<= amazon_link(book) if book.paperback.amazon
        links
    end

    def amazon_link book
        link_to 'Amazon', asin_url(book.isbn10)
    end

    def asin_url asin
        "http://amazon.com/dp/#{asin}/?tag=#{AMAZON_AFFILIATE_ID}"
    end

    def ibooks_link book
        link_to 'iBooks', ibooks_url(book)
    end

    def ibooks_url book
        "https://itunes.apple.com/us/book/id#{book.ebook.ibooks}?mt=11"
    end

    def kindle_link book
        link_to 'Kindle', asin_url(book.ebook.kindle)
    end

    def kobo_link book
        link_to 'Kobo', kobo_url(book)
    end

    def kobo_url book
        "http://store.kobobooks.com/en-US/ebook/#{book.ebook.kobo}"
    end

    def nook_link book
        link_to 'Nook', nook_url(book)
    end

    def nook_url book
        "http://www.barnsandnoble.com/s/#{book.ebook.nook}"
    end

    def smashwords_link book
        link_to 'Smashwords', smashwords_url(book)
    end

    def smashwords_url book
        "https://www.smashwords.com/books/view/#{book.ebook.smashwords}"
    end

end
