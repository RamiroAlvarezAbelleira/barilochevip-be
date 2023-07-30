json.array!(@equipos) do |equipo|
  json.extract! equipo, :id, :name, :description, :price, :stock_total

  json.images equipo.images do |image|
    image_url = url_for(image)
    base_url = 'http://[::1]:3000' # Replace with your base URL
    json.image_url "#{base_url}#{image_url}"
    # You can include additional image attributes if needed
    # json.title image.blob.title
    # json.content_type image.blob.content_type
    # ...
  end
end
