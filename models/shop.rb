# Define the Product Class
class Shop
  include MongoMapper::Document
  key :shop, String
  key :token, String
  key :status, String
  timestamps!
end