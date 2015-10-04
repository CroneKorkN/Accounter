json.array!(@records) do |record|
  json.extract! record, :id, :task_id, :order
  json.url record_url(record, format: :json)
end
