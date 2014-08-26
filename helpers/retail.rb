module Retail
    AMAZON_AFFILIATE_ID = "driscollbrookpress-20"#
    ITUNES_AFFILIATE_ID = "1l3vpYQ"

    def cover_url book
        "/images/#{File.basename book.slug, '.html'}-cover-web.jpg"
    end

    def ebook_links book
        links = []
        return [] unless book.ebook
        links <<= itunes_link(book) if book.ebook.ibooks
        links <<= kindle_link(book) if book.ebook.kindle
        links <<= kobo_link(book) if book.ebook.kobo
        links <<= nook_link(book) if book.ebook.nook
        links <<= smashwords_link(book) if book.ebook.smashwords
        links
    end

    def book_link title, url
        "<a href='#{url}'>#{title}</a>"
    end

    def paperback_links book
        links = []
        return links unless book.paperback
        links <<= amazon_link(book) if book.paperback.amazon
        links
    end

    def amazon_link book
        book_link 'Amazon', amazon_affiliate_url(isbn10(book.paperback.isbn))
    end

    def amazon_affiliate_url identifier
        "http://amazon.com/dp/#{identifier}?tag=#{AMAZON_AFFILIATE_ID}"
    end

    def itunes_link book
        book_link 'iBooks', itunes_affiliate_url(book)
    end

    def itunes_affiliate_url book
        "https://itunes.apple.com/us/book/isbn#{isbn13(book.ebook.isbn)}?mt=11&at=#{ITUNES_AFFILIATE_ID}"
    end

    def kindle_link book
        book_link 'Kindle', amazon_affiliate_url(book.ebook.kindle)
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
