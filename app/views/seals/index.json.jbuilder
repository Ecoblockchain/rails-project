json.array!(@seals) do |seal|
  json.extract! seal, :stamp, :created_at
  #json.url seal_path(seal.stamp, format: :json)
end
