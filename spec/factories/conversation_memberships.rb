FactoryBot.define do
  factory :conversation_membership do
    user
    conversation
    last_accessed_at { Time.now }
    is_member { true }
  end
end
