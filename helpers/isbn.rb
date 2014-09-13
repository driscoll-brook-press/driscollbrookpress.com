BOOKLAND = "978"
PUBLISHER_GROUP = "1"
DRISCOLL_BROOK_PRESS = "63261"

def isbn10(title, separator='')
    identifier = '%03d' % title.to_i
    isbn_parts = [PUBLISHER_GROUP, DRISCOLL_BROOK_PRESS, identifier]
    multiplier = 10
    checksum = 0
    isbn_parts.join.each_char do |c|
        digit = c.to_i
        term = digit * multiplier
        checksum += term
        multiplier -= 1
    end
    check_digit = (11 - (checksum % 11)) % 11
    check_digit = 'X' if check_digit == 10
    isbn_parts <<= check_digit.to_s
    isbn_parts.join(separator)
end

def isbn13(title, separator='')
    identifier = '%03d' % title.to_i
    isbn_parts = [BOOKLAND, PUBLISHER_GROUP, DRISCOLL_BROOK_PRESS, identifier]
    multiplier = 1
    checksum = 0
    isbn_parts.join.each_char do |c|
        digit = c.to_i
        term = digit * multiplier
        checksum += term
        multiplier = (multiplier + 2) % 4
    end

    check_digit = (10 - (checksum % 10)) % 10
    isbn_parts <<= check_digit.to_s
    isbn_parts.join(separator)
end
