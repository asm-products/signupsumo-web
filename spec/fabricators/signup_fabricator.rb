Fabricator(:signup) do
  user(fabricator: :user)
  email { Faker::Internet.email }
  influential { [true, false].sample }
  hidden { [true, false].sample }
end
