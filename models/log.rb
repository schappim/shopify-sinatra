# Define the Product Class
class Log
  include MongoMapper::Document
  key :shop, String
  key :message, String
  timestamps!
end