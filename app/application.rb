class Application

#Create a new route called /cart to show the items in your cart.

#Create a new route called /add that takes in a GET param with the key item.
# This should check to see if that item is in @@items and add it to the cart if it is. 
#Otherwise it should give an error.

  
  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term)
    elsif req.path.match(/cart/)
        if @@cart.empty?
          resp.write "Your cart is empty"
        else
            @@cart.each do |item|
              resp.write "#{item}\n"
            end
        end

    elsif req.path.match(/add/)
          add_value = req.params["item"]
          if @@items.include?(add_value)
            @@cart << add_value
            resp.write "added #{add_value}"
          else
            resp.write "We don't have that item"
          end
    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
