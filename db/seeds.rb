# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

names = [
	{'first': 'Slade', 'last': 'Larsen'},
	{'first': 'Joshua', 'last': 'Albert'},
	{'first': 'Aristotle', 'last': 'Meadows'},
	{'first': 'Reed', 'last': 'Maynard'},
	{'first': 'Murphy', 'last': 'Bolton'},
	{'first': 'Lester', 'last': 'Lucas'},
	{'first': 'Demetrius', 'last': 'Edwards'},
	{'first': 'Tarik', 'last': 'Graves'},
	{'first': 'Wallace', 'last': 'Wall'},
	{'first': 'Ali', 'last': 'Lancaster'},
	{'first': 'Lars', 'last': 'Tyler'},
	{'first': 'Fuller', 'last': 'Manning'},
	{'first': 'Abbot', 'last': 'Blackburn'},
	{'first': 'Jerome', 'last': 'Cantu'},
	{'first': 'Wesley', 'last': 'Richards'},
	{'first': 'Paul', 'last': 'Fields'},
	{'first': 'Wylie', 'last': 'Klein'},
	{'first': 'Colin', 'last': 'Glenn'},
	{'first': 'Emmanuel', 'last': 'Sanders'},
	{'first': 'Clarke', 'last': 'Pacheco'},
	{'first': 'Gray', 'last': 'Weaver'},
	{'first': 'Todd', 'last': 'Mccormick'},
	{'first': 'Cullen', 'last': 'Riddle'},
	{'first': 'Kareem', 'last': 'Matthews'},
	{'first': 'Palmer', 'last': 'Mcgee'},
	{'first': 'Merrill', 'last': 'Bender'},
	{'first': 'Ulric', 'last': 'Hansen'}
];

names.each do |person|
    User.create(email: "#{person[:first]}@email.com", first_name: person[:first], last_name: person[:last], password: "password", password_confirmation: "password")
end

@group1 = Group.create(name: "Kappa Zeta Nu Fraternity")
@group2 = Group.create(name: "North West Central High School")

User.all.each_with_index do |user, index|
    if index == 0
        GroupsUser.create(user_id: user[:id], group_id: @group1[:id], role: "Admin")
    elsif (index > 0) && (index < 13)
        GroupsUser.create(user_id: user[:id], group_id: @group1[:id], role: "Standard")
    elsif (index >= 13) && (index < User.all.count - 1)
        GroupsUser.create(user_id: user[:id], group_id: @group2[:id], role: "Standard")
    elsif (index == User.all.count - 1)
        GroupsUser.create(user_id: user[:id], group_id: @group2[:id], role: "Admin")
    end
end

meals = [
    {'name': 'Porridge', 'description': 'Made by boiling ground, crushed, or chopped starchy plants – typically grain – in water or milk. It is often cooked or served with flavorings such as sugar, honey, etc. to make a sweet dish, or mixed with spices, vegetables, etc. to make a savoury dish. It is usually served hot in a bowl.', 'category': 1},
    {'name': 'Omlette', 'description': 'dish made from beaten eggs quickly fried with butter or oil in a frying pan (without stirring as in scrambled egg). It is quite common for the omelette to be folded around a filling such as cheese, chives, vegetables, meat (often ham or bacon), or some combination of the above. ', 'category': 1},
    {'name': 'Waffles', 'description': 'dish made from leavened batter or dough that is cooked between two plates that are patterned to give a characteristic size, shape and surface impression.', 'category': 1},
    {'name': 'Cheeseburger', 'description': 'Classic burger featuring and all beef patty grilled medium-well, a side of french fries and a house salad', 'category': 2},
    {'name': 'Hot Dog', 'description': 'A kosher all beef frank with the usual toppings, french fries, and cole slaw', 'category': 2},
    {'name': 'Taco Tuesday', 'description': 'Buffet style make your own mexican food, including ground beef, shredded chicken, and veggies', 'category': 2},
    {'name': 'BLTs', 'description': 'Bread, Bacon, Lettuce, Tomato, toasted', 'category': 2},
    {'name': 'Steak', 'description': 'New York Strip steak prepared medium rare, served with mashed potatoes and asparagus', 'category': 3},
    {'name': 'Chicken Kiev', 'description': 'Chicken Kiev, bursting from the seems with delicious butter', 'category': 3},
    {'name': 'Fried Shrimp', 'description': 'Golden fried jumbo shrimp and cocktail sauce', 'category': 3},
    {'name': 'Soup', 'description': 'Homestyle chicken noodle soup prepared with love', 'category': 3},
];

(0..90).each do |n|
    meal = meals[n % 11]
    Meal.create(name: meal[:name], description: meal[:description], category: meal[:category], group_id: n % 2 == 0 ? @group1[:id] : @group2[:id], meal_date: Date.today + n)
end
