#!/usr/bin/env ruby

def isbn10_check_digit(isbn)
    multiplier = 10
    checksum = 0
    isbn.each_char do |c|
        digit = c.to_i
        product = digit * multiplier
        checksum += product
        multiplier -= 1
    end
    (11 - (checksum % 11)) % 11
end

def isbn13_check_digit(isbn)
    multiplier = 1
    checksum = 0
    isbn.each_char do |c|
        digit = c.to_i
        product = digit * multiplier
        checksum += product
        multiplier = (multiplier + 2) % 4
    end

    10 - (checksum % 10)
end

ISBN13_PREFIX = "978"

DBP_ISBN_BASE = "63261"

def isbn9(id)
    "1" + DBP_ISBN_BASE + id
end

def isbn12(id)
    ISBN13_PREFIX + isbn9(id)
end

def isbn_core(id)
    "1-" + DBP_ISBN_BASE + "-" + id
end

def isbn10(id)
    isbn_core(id) + "-" + isbn10_check_digit(isbn9(id)).to_s
end

def isbn13(id)
    ISBN13_PREFIX + "-" + isbn_core(id) + "-" + isbn13_check_digit(isbn12(id)).to_s
end

