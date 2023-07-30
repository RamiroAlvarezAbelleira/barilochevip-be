json.array! @marcas do |marca|
  json.extract! marca, :id, :name
end
