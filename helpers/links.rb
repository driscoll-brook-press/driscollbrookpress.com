def link(display, url)
    the_link = "<a href='#{url}'>#{display}</a>"
    puts "Made link: #{the_link} from url #{url} and display #{display}"
    the_link
end
