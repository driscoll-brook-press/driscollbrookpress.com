AMAZON_AFFILIATE_ID = "driscollbrookpress-20"#
ITUNES_AFFILIATE_ID = "1l3vpYQ"
SMASHWORDS_AFFILIATE_ID = "dalehartleyemery"

def ebook_links book
    links = []
    return [] unless book.ebook
    links <<= itunes_link(book) if book.ebook.ibooks
    links <<= inktera_link(book) if book.ebook.inktera
    links <<= kindle_link(book) if book.ebook.kindle
    links <<= kobo_link(book) if book.ebook.kobo
    links <<= nook_link(book) if book.ebook.nook
    links <<= scribd_link(book) if book.ebook.scribd
    links <<= smashwords_link(book) if book.ebook.smashwords
    links
end

def paperback_links book
    links = []
    return links unless book.paperback
    links <<= amazon_link(book) if book.paperback.amazon
    links <<= bn_link(book) if book.paperback.bn
    links
end

def amazon_link book
    link 'Amazon', amazon_affiliate_url(isbn10(book.paperback.isbn))
end

def amazon_affiliate_url identifier
    "http://amazon.com/dp/#{identifier}?tag=#{AMAZON_AFFILIATE_ID}"
end

def bn_link book
    link 'B&amp;N', bn_url(book)
end

def bn_url book
    "http://www.barnsandnoble.com/s/#{isbn13(book.paperback.isbn)}"
end

def inktera_link book
  link 'Inktera', inktera_url(book)
end

def inktera_url book
  "http://www.inktera.com/store/title/#{book.ebook.inktera}"
end

def itunes_link book
    link 'iBooks', itunes_affiliate_url(book)
end

def itunes_affiliate_url book
    "https://itunes.apple.com/us/book/isbn#{isbn13(book.ebook.isbn)}?mt=11&at=#{ITUNES_AFFILIATE_ID}"
end

def kindle_link book
    link 'Kindle', amazon_affiliate_url(book.ebook.kindle)
end

def kobo_link book
    link 'Kobo', kobo_url(book)
end

def kobo_url book
    "http://store.kobobooks.com/Search/Query?fcmedia=Book&query=#{isbn13(book.ebook.isbn)}"
end

def nook_link book
    link 'Nook', nook_url(book)
end

def nook_url book
    "http://www.barnsandnoble.com/s/#{book.ebook.nook}"
end

def scribd_link book
  link 'Scribd', scribd_url(book)
end

def scribd_url book
  "https://www.scribd.com/book/#{book.ebook.scribd}"
end

def smashwords_link book
    link 'Smashwords', smashwords_url(book)
end

def smashwords_url book
  "https://www.smashwords.com/books/search?query=#{isbn13(book.ebook.isbn)}&ref=#{SMASHWORDS_AFFILIATE_ID}"
end
