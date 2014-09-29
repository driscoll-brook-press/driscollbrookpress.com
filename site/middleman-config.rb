$middleman.activate :blog do |blog|
    blog.sources = $site['book_pattern']
    blog.default_extension = ".md"

    blog.layout = "book"
    blog.permalink = "title/:title"

    blog.paginate = false
end

$middleman.activate :directory_indexes

$middleman.set :haml, { ugly: true }

$middleman.helpers
