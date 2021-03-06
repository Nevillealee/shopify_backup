class CreateZobhaOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :zobha_orders do |t|
      t.bigint :app_id
      t.jsonb :billing_address
      t.string :browser_ip
      t.boolean :buyer_accepts_marketing
      t.string :cancel_reason
      t.datetime :cancelled_at
      t.string :cart_token
      t.jsonb :client_details
      t.datetime :closed_at
      t.datetime :created_at
      t.string :currency
      t.jsonb :customer
      t.string :customer_locale
      t.jsonb :discount_applications
      t.jsonb :discount_codes
      t.string :email
      t.string :financial_status
      t.jsonb :fulfillments
      t.string :fulfillment_status
      t.string :landing_site
      t.jsonb :line_items
      t.bigint :location_id
      t.string :name
      t.string :note
      t.jsonb :note_attributes
      t.bigint :number
      t.bigint :order_number
      t.jsonb :payment_details
      t.jsonb :payment_gateway_names
      t.string :phone
      t.string :presentment_currency
      t.datetime :processed_at
      t.string :processing_method
      t.string :referring_site
      t.jsonb :refunds
      t.jsonb :shipping_address
      t.jsonb :shipping_lines
      t.string :source_name
      t.string :subtotal_price
      t.jsonb :subtotal_price_set
      t.string :tags
      t.jsonb :tax_lines
      t.boolean :taxes_included
      t.boolean :test
      t.string :token
      t.string :total_discounts
      t.jsonb :total_discounts_set
      t.string :total_line_items_price
      t.jsonb :total_line_items_price_set
      t.string :total_price
      t.jsonb :total_price_set
      t.string :total_tax
      t.jsonb :total_tax_set
      t.string :total_tip_received
      t.integer :total_weight
      t.datetime :updated_at
      t.bigint :user_id
      t.string :order_status_url
    end
  end
end
