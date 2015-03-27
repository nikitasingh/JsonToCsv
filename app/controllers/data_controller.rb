class DataController < ActionController::Base

	def index
	end

  def create_csv
  	# file = File.read('files/avago.json')
  	file = params["file"] || File.read('files/avago.json')
  	file = File.read(file.path) if params["file"]
  	data = JSON.parse(file)
    CSV.open("public/avago.csv", "w") do |csv|
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
        end      
      end
    end 
	  send_file "public/avago.csv" 
  end
end
