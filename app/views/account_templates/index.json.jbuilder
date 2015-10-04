json.array!(@account_templates) do |account_template|
  json.extract! account_template, :id, :number, :name, :has_initial, :order
  json.url account_template_url(account_template, format: :json)
end
