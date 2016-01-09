json.array!(@targets) do |target|
  json.extract! target, :id, :name, :comments, :rating, :severity, :distance, :is_active
  json.url target_url(target, format: :json)
end
