json.array!(@entries) do |entry|
  json.extract! entry, :id, :task_account_id, :value
  json.url entry_url(entry, format: :json)
end
