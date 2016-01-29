class MessageSerializer < ActiveModel::Serializer
  attributes :id, :sender_id, :receiver_id, :msg_type, :msg_text, :attachment_url, :attachment_ext
end
