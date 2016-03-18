json.array!(@seals) do |seal|
  json.extract! seal, :id
  json.url seal_url(seal, format: :json)
end
