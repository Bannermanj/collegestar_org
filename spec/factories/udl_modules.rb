FactoryGirl.define do
  factory :udl_module do
    sequence(:title) { |n| "Test Module #{n}" }
    sequence(:slug) { |n| "test-module-#{n}" }
    sub_heading 'testing modules all the time'
    udl_representation '1'
    udl_action_expression '1'
    udl_engagement '0'
    description 'This is a test module used to test modules...'
    
    factory :udl_module_with_sections do
      after(:create) do |udl_module|
        udl_module.sections << create(:introduction_section)
        udl_module.sections << create(:udl_principles_section)
        udl_module.sections << create(:instructional_practice_section)
        udl_module.sections << create(:learn_more_section)
        udl_module.sections << create(:references_section)
      end
    end
  end

  factory :new_udl_module, class: UdlModule do
    title "test"
    slug "test"
    sub_heading "My sub heading"
    udl_representation "1"
    udl_action_expression "1"
    udl_engagement "0"
    description "Test description"
  end
end
