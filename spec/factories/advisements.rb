FactoryBot.define do
  factory :advisement do
    advisement_degree_id { create(:advisement_degree).id }
    intern_id { create(:intern).id }
  end
end
