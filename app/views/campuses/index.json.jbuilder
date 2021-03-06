json.array!(@campuses) do |campus|
  json.extract! campus, :id, :name, :abbreviation, :type, :director_id, :website_url, :address_1, :address_2, :city, :state, :zip, :image_url
  json.url campus_url(campus, format: :json)
end
