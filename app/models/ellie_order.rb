class EllieOrder < ApplicationRecord
  def import
    params = {
      'api_key': ENV['ELLIE_API_KEY'],
      'password': ENV['ELLIE_API_PW'],
      'shop_name': ENV['ELLIE_SHOP'],
      'query': "created_at_min=2018-01-01&created_at_max=2018-12-31&status=any&fields=#{ENV['ORDER_FIELDS']}",
      'entity': self.class.name,
      'headers': { 'Content-Type' => 'application/json' }
    }
    ShopifyImport.new(params).fetch
  end
end
