[User].each do |model|
  model.destroy_all
end

10.times do
  User.create({ first_name: FFaker::Name.first_name,
                last_name: FFaker::Name.last_name,
                emails: [FFaker::Internet.email],
                phone_numbers: ["+7#{rand(999)}#{rand(999)}#{rand(99)}#{rand(99)}"]})
end