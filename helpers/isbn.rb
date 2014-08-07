#!/usr/bin/env ruby

BOOKLAND = "978"
PUBLISHER_GROUP = "1"
DRISCOLL_BROOK_PRESS = "63261"

def isbn10(title, separator='')
    isbn_parts = [PUBLISHER_GROUP, DRISCOLL_BROOK_PRESS, title]
    multiplier = 10
    checksum = 0
    isbn_parts.join.each_char do |c|
        digit = c.to_i
        product = digit * multiplier
        checksum += product
        multiplier -= 1
    end
    check_digit = (11 - (checksum % 11)) % 11
    isbn_parts <<= check_digit
    isbn_parts.join(separator)
end

def isbn13(title, separator='')
    isbn_parts = [BOOKLAND, PUBLISHER_GROUP, DRISCOLL_BROOK_PRESS, title]
    multiplier = 1
    checksum = 0
    isbn_parts.join.each_char do |c|
        digit = c.to_i
        product = digit * multiplier
        checksum += product
        multiplier = (multiplier + 2) % 4
    end

    check_digit = 10 - (checksum % 10)
    isbn_parts <<= check_digit
    isbn_parts.join(separator)
end

