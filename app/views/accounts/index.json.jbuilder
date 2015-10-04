json.array!(@accounts) do |account|
  json.extract! account, :id, :name, :close_via_id, :has_initial, :order
  json.url account_url(account, format: :json)
end
