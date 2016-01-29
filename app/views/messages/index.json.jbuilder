json.array!(@messages) do |message|
  json.extract! message, :id, :sender_id, :receiver_id, :msg_type, :msg_text, :attachment_url, :attachment_ext
  json.url message_url(message, format: :json)
end
