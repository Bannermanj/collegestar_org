FactoryGirl.define do
  factory :module_proposal do
    first_name "John"
    last_name "Smith"
    university "UNC Something"
    department "My Department"
    email "john.smith@uncs"
    module_type "new_module"
    title "My New and Exciting Module"
    description "This is a module I've been working on for a long time."
    start_date "2016-01-15"
    completion_date "2016-03-15"
  end

end
