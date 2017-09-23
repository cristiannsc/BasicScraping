class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # Define the Product object
  class Product 
    def initialize(name, price)
      @name = name
      @price = price
    end
    attr_reader :name
    attr_reader :price
  end

  def scraping_test
    require 'open-uri'
    doc = Nokogiri::HTML(open("https://www.zmart.cl/JuegosPS4"))

    # Build the products array
    products = doc.css('.BoxProductoS2')
    @productsArray = []
    products.each do |product|
      name = product.css('.BoxProductoS2_Descripcion').text
      price = product.css('.BoxProductoS2_Precios').css('.BoxProductoS2_Precio').text    
      @productsArray << Product.new(name, price)
    end

    # Render the array through the view
    render template: 'scraping_test'
  end
end
