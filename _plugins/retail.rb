module Retail
  AMAZON_AFFILIATE_ID = 'driscollbrookpress-20'
  ITUNES_AFFILIATE_ID = '1l3vpYQ'
  SMASHWORDS_AFFILIATE_ID = 'dalehartleyemery'

  AMAZON_URL_TEMPLATE = "http://amazon.com/dp/%s?tag=#{AMAZON_AFFILIATE_ID}"
  BN_URL_TEMPLATE = 'http://www.barnsandnoble.com/s/%s'
  IBOOKS_URL_TEMPLATE = "https://itunes.apple.com/us/book/isbn%s?mt=11&at=#{ITUNES_AFFILIATE_ID}"
  INKTERA_URL_TEMPLATE = 'http://www.inktera.com/store/title/%s'
  KOBO_URL_TEMPLATE = 'http://store.kobobooks.com/Search/Query?fcmedia=Book&query=%s'
  OYSTER_URL_TEMPLATE = 'https://www.oysterbooks.com/book/%s'
  SCRIBD_URL_TEMPLATE = 'https://www.scribd.com/book/%s'
  SMASHWORDS_URL_TEMPLATE = "https://www.smashwords.com/books/search?query=%s&ref=#{SMASHWORDS_AFFILIATE_ID}"

  IDENTIFIED_BY_EBOOK_ISBN13 = lambda { |offer| ISBN::CALCULATOR.isbn13(offer.book['ebook']['isbn']) }
  IDENTIFIED_BY_PAPERBACK_ISBN10 = lambda { |offer| ISBN::CALCULATOR.isbn10(offer.book['paperback']['isbn']) }
  IDENTIFIED_BY_PAPERBACK_ISBN13 = lambda { |offer| ISBN::CALCULATOR.isbn13(offer.book['paperback']['isbn']) }
  IDENTIFIED_BY_STOCK_NUMBER = lambda { |offer| offer.stock_number }

  class Marketplace
    def initialize
      @retailers = {
        amazon: Retailer.new('Amazon', AMAZON_URL_TEMPLATE, IDENTIFIED_BY_PAPERBACK_ISBN10),
        bn: Retailer.new('B&amp;N', BN_URL_TEMPLATE, IDENTIFIED_BY_PAPERBACK_ISBN13),
        ibooks: Retailer.new('iBooks', IBOOKS_URL_TEMPLATE, IDENTIFIED_BY_EBOOK_ISBN13),
        inktera: Retailer.new('Inktera', INKTERA_URL_TEMPLATE, IDENTIFIED_BY_STOCK_NUMBER),
        kindle: Retailer.new('Kindle', AMAZON_URL_TEMPLATE, IDENTIFIED_BY_STOCK_NUMBER),
        kobo: Retailer.new('Kobo', KOBO_URL_TEMPLATE, IDENTIFIED_BY_EBOOK_ISBN13),
        nook: Retailer.new('Nook', BN_URL_TEMPLATE, IDENTIFIED_BY_STOCK_NUMBER),
        oyster: Retailer.new('Oyster', OYSTER_URL_TEMPLATE, IDENTIFIED_BY_STOCK_NUMBER),
        scribd: Retailer.new('Scribd', SCRIBD_URL_TEMPLATE, IDENTIFIED_BY_STOCK_NUMBER),
        smashwords: Retailer.new('Smashwords', SMASHWORDS_URL_TEMPLATE, IDENTIFIED_BY_EBOOK_ISBN13)
      }
    end

    def retailer(offerer)
      @retailers[offerer.to_sym]
    end
  end

  class Offer
    attr_reader :book, :offerer, :stock_number

    def initialize(book, details)
      @book = book
      if details.is_a? Hash
        @offerer = details.keys.first
        @stock_number = details.values.first
      else
        @offerer = details
      end
    end
  end

  class Retailer
    def initialize(name, url_template, identify_offer)
      @name = name
      @url_template = url_template
      @identify_offer = identify_offer
    end

    def link_to(offer)
      "<a href='#{@url_template % @identify_offer.call(offer)}'>#{@name}</a>"
    end
  end

  MARKETPLACE = Marketplace.new

  def offer_link(book, details)
    offer = Offer.new(book, details)
    MARKETPLACE.retailer(offer.offerer).link_to(offer)
  end
end

Liquid::Template.register_filter(Retail)
