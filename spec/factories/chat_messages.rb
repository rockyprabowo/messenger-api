FactoryBot.define do
  factory :chat_message do
    conversation
    conversation_membership
    body { Faker::Lorem.sentences }
  end
end
