$middleman.activate :blog do |blog|
    blog.sources = $site['book_pattern']
    blog.default_extension = ".md"

    blog.layout = "book"
    blog.permalink = "title/:title"

    blog.paginate = false
end

$middleman.activate :directory_indexes

$middleman.set :haml, { ugly: true }

require "helpers/retail.rb"
require "helpers/isbn.rb"
require "helpers/titles.rb"
require "helpers/books.rb"
$middleman.helpers Retail, ISBN, Titles, Books
