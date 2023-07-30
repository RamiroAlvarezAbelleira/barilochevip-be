json.array! @bookings do |booking|
  json.extract! booking, :id, :start_date, :end_date, :equipo_id, :quantity
end
