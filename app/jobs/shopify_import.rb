class ShopifyImport
  def initialize(params)
    @base_uri = "https://#{params[:api_key]}:#{params[:password]}@#{params[:shop_name]}.myshopify.com/admin/api/#{ENV['API_VERSION']}"
    @query = params[:query]
    @entity = params[:entity].constantize
    @headers = params[:headers]
    base64 = Base64.strict_encode64("#{params[:api_key]}:#{params[:password]}")
    @base64_header = {Authorization: "Basic #{base64}"}
  end

  def fetch
    start = Time.now
    order_count = HTTParty.get(@base_uri + "/orders/count.json?#{@query}", headers: @headers)
    total = order_count['count'].to_i
    puts "TOTAL ORDER COUNT FROM SHOPIFY: #{total}"

    response_init = HTTParty.get(@base_uri + "/orders.json?" + @query + "&limit=250", headers: @headers)
    next_url = response_init.headers['link'].slice(/\<(?<next_url>.*)\>/, "next_url")
    page_of_orders = response_init.parsed_response['orders']
    @used = response_init.headers['x-shopify-shop-api-call-limit'].to_i
    @entity.upsert_all(page_of_orders)

    while(next_url)
      puts "inside loop"
      batch_throttle(@used)
      new_request = HTTParty.get(next_url, headers: @base64_header)
      link = new_request.headers['link']

      if new_request.code == 200
        @used = new_request.headers['x-shopify-shop-api-call-limit'].to_i
        bulk_upsert(new_request.parsed_response['orders'])
        next_url = link.slice(/\, \<(?<next_url>.*)\>; rel=\"next\"/, "next_url")
        puts "next_url: #{next_url.inspect}"
      else
        puts "Error"
        break
      end
    end

    puts "#{@entity.all.count}/ #{total} Orders imported from Shopify"
    puts "Run time: #{Time.now - start} seconds"
  end

  def bulk_upsert(obj_array)
    puts "reached bulk upsert"
    for hsh in obj_array do
      begin
        @entity.upsert(hsh, unique_by: :id)
      rescue StandardError => e
        puts " failed on #{hsh.inspect}"
        next
      end
    end
    puts "finished bulk upsert"
  end

  def batch_throttle(requests_used)
    puts "requests used: #{requests_used}"
    if requests_used >= 70
      puts "requests used: #{requests_used}, sleeping #{requests_used/4}..."
      sleep requests_used/4
    end
  end


end
