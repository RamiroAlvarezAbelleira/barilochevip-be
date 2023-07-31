json.extract! @equipo, :id, :name, :description, :price, :stock_total, :category_id, :marca_id, :category, :marca, :bookings

json.images do
  json.array!(@equipo.images) do |image|
    image_url = url_for(image)
    base_url = 'https://barilochevip-be-production.up.railway.app' # Replace with your base URL
    json.image_url "#{base_url}#{image_url}"
  end
end
