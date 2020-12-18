FactoryBot.define do
  factory :researcher do
    post_doc_type_id { create(:post_doc_type).id }
  end
end