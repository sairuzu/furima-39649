FactoryBot.define do
  factory :user do
    nickname              {'test'}
    email                 {Faker::Internet.email}
    password              {'000aaa'}
    password_confirmation {password}
    last_name             {'焼肉'}
    first_name            {'太郎'}
    last_name_kana        {'ヤキニク'}
    first_name_kana       {'タロウ'}
    birth_date            {'19990101'}
  end
end
