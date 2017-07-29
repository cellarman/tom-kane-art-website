FactoryGirl.define do
  factory :charge do

  end
  factory :admin do
    email 'tka@email.com'
    password "000000"
  end
  
  factory :painting do
    title 'Cherry Blossoms With Wind'
    description 'Frame Optional'
    year '2017'
    dimensions '11 x 14 inches'
    medium 'Acrylic'
    support 'Canvas'
    framed 'false'
    price '1500'
    image 'https://images-na.ssl-images-amazon.com/images/I/31Dy9-24ulL._SY355_.jpg'
    style 'landscape'
    status 'for sale'
  end
end
