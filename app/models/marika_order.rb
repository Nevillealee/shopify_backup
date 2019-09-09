class MarikaOrder < ApplicationRecord
  def import
    params = {
      'api_key': ENV['MARIKA_API_KEY'],
      'password': ENV['MARIKA_API_PW'],
      'shop_name': ENV['MARIKA_SHOP'],
      'query': "created_at_min=2018-01-01&status=any&fields=#{ENV['ORDER_FIELDS']}",
      'entity': self.class.name,
      'headers': { 'Content-Type' => 'application/json' }
    }
    ShopifyImport.new(params).fetch
  end
end
