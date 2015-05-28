class DataController < ActionController::Base

	def index
	end

  def create_csv
  	# file = File.read('files/avago.json')
  	file = params["file"] || File.read('files/data.json')
  	file = File.read(file.path) if params["file"]
  	data = JSON.parse(file)
    CSV.open("public/avago.csv", "w") do |csv|
      csv << ["uid","mpn","sku", "offer:product_url", "offer:on_order_eta", 
              "offer:last_updated", "offer:order_multiple", "offer:in_stock_quantity", 
              "offer:eligible_region", "offer:moq", "offer:on_order_quantity", "offer:octopart_rfq_url", 
              "offer:__class__", "offer:offer:seller:display_flag", "offer:seller:has_ecommerce", "offer:seller:uid", 
              "offer:seller:__class__", "offer:seller:homepage_url", "offer:seller:name", "packaging", 
              "offer:Currency", "offer:Price 1", "offer:Price 10",  "offer:Price 25", "offer:Price 50", "offer:Price 100", 
              "offer:Price 200", "offer:Price 250", "offer:Price 500", "offer:Price 1000", "offer:Price 2000", 
              "offer:Price 3000", "offer:Price 4000", "offer:Price 5000", "offer:Price 10000", "offer:Price 50000", 
              "offer:Price 100000", "offer:factory_lead_days", "offer:factory_order_multiple", 
              "offer:is_authorized", "offer:is_realtime", "short_description",
              "octopart_url", "specs", "manufacturer:uid", "manufacturer:homepage_url", "manufacturer:__class__", "manufacturer:name"]
      data.each do |part|
        part["offers"].each_with_index do |offer,i|
          array = []  
          price_hash= offer["prices"].values.flatten.in_groups_of(2).to_h
            array << [ part['uid'], part['mpn'] ] if i == 0
            array << ["", ""] unless i == 0
            array << [offer["sku"], 
                   offer["product_url"], 
                   offer["on_order_eta"], 
                   offer["last_updated"], 
                   offer["order_multiple"], 
                   offer["in_stock_quantity"], 
                   offer["eligible_region"], 
                   offer["moq"], 
                   offer["on_order_quantity"], 
                   offer["octopart_rfq_url"],
                   offer["__class__"], 
                   offer["seller"]["display_flag"], 
                   offer["seller"]["has_ecommerce"], 
                   offer["seller"]["uid"], 
                   offer["seller"]["__class__"], 
                   offer["seller"]["homepage_url"], 
                   offer["seller"]["name"], 
                   offer["packaging"], 
                   offer["prices"].keys[0],
                   price_hash[1],
                   price_hash[10],
                   price_hash[25],
                   price_hash[50],
                   price_hash[100],
                   price_hash[200],
                   price_hash[250],
                   price_hash[500],
                   price_hash[1000],
                   price_hash[2000],
                   price_hash[3000],
                   price_hash[4000],
                   price_hash[5000],
                   price_hash[10000],
                   price_hash[50000],
                   price_hash[100000], 
                   offer["factory_lead_days"], 
                   offer["factory_order_multiple"], 
                   offer["is_authorized"], 
                   offer["is_realtime"]]
            array << [part["short_description"], part["octopart_url"], 
                      part["specs"], 
                      part["manufacturer"]["uid"], part["manufacturer"]["homepage_url"], 
                      part["manufacturer"]["__class__"], 
                      part["manufacturer"]["name"]] if i == 0
            csv << array.flatten              
        end if part["offers"]     
      end
    end 
	  send_file "public/avago.csv" 
  end

  def old_create_csv
    file = params["file"] || File.read('files/data.json')
    file = File.read(file.path) if params["file"]
    data = JSON.parse(file)
    CSV.open("public/Data.csv", "w") do |csv|
      csv << ["Manufacturer Name", "Part number", "Part Description", "Distributor", "SKU", "Stock Quantity", "MOQ- Minimum Order Quantity", "Packaging", "Currency", "Price 1", "Price 10",  "Price 25", "Price 50", "Price 100", "Price 200", "Price 250", "Price 500", "Price 1000", "Price 2000", "Price 3000", "Price 4000", "Price 5000", "Price 10000", "Price 50000", "Price 100000" ] 
      data.each do |part|        
        part["offers"].each do |offer|
          price_hash= offer["prices"].values.flatten.in_groups_of(2).to_h
            csv << [ part['manufacturer']['name'],
                   offer['sku'],
                   part["snippet"],
                   offer["seller"]["name"],
                   offer["sku"],
                   offer["in_stock_quantity"],
                   offer["moq"],
                   offer["packaging"],
                   offer["prices"].keys[0],
                   price_hash[1],
                   price_hash[10],
                   price_hash[25],
                   price_hash[50],
                   price_hash[100],
                   price_hash[200],
                   price_hash[250],
                   price_hash[500],
                   price_hash[1000],
                   price_hash[2000],
                   price_hash[3000],
                   price_hash[4000],
                   price_hash[5000],
                   price_hash[10000],
                   price_hash[50000],
                   price_hash[100000]
                  ]              
        end if part["offers"]     
      end
    end 
    send_file "public/Data.csv" 
  end
end
