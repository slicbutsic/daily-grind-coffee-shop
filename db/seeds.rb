puts "destroying database..."
CartItem.destroy_all
Order.destroy_all
Cart.destroy_all
Product.destroy_all
Category.destroy_all
User.destroy_all
puts "Starting seed process..."

User.create!(
  email: "siviglialucas@gmail.com",
  password: "123456",
  first_name: "Lucas",
  last_name: "Siviglia"
)

# Create categories
puts "Creating categories..."
coffee_beans = Category.create!(name: "Coffee Beans")
coffee_machines = Category.create!(name: "Coffee Machines")
mugs = Category.create!(name: "Mugs")

# Create products
puts "Creating products..."
Product.create!( [
  { name: "Arabica Yirgacheffe", description: "Delicate floral and tea-like characteristics with citrus notes.", price: 15.00, image: "images/arabica.jpeg", category: coffee_beans, intensity: 4 },
  { name: "Supremo Blend", description: "Well-balanced with a smooth, clean taste and rich aroma.", price: 14.50, image: "images/blend.jpeg", category: coffee_beans, intensity: 6 },
  { name: "Brazilian Santos", description: "Full-bodied with a smooth, earthy flavor and low acidity.", price: 16.00, image: "images/brazilian.jpeg", category: coffee_beans, intensity: 5 },
  { name: "Colombian Tarrazu", description: "Bright acidity with a full body and hints of chocolate.", price: 15.50, image: "images/colombian.jpeg", category: coffee_beans, intensity: 7 },
  { name: "Dark AA", description: "Bold, full-bodied with a wine-like acidity and fruity notes.", price: 17.00, image: "images/dark.jpeg", category: coffee_beans, intensity: 9 },
  { name: "Dark Roast", description: "Low acidity with a sweet, nutty flavor and a light body.", price: 13.50, image: "images/dark1.jpeg", category: coffee_beans, intensity: 8 },
  { name: "Dark Sumatra", description: "Spicy and full-bodied with a rich, complex flavor.", price: 15.75, image: "images/dark2.jpeg", category: coffee_beans, intensity: 10 },
  { name: "Decaf Kona", description: "Smooth, mild with a slightly sweet flavor and floral aroma.", price: 25.00, image: "images/decaf.jpeg", category: coffee_beans, intensity: 3 },
  { name: "Espresso Blue Mountain", description: "Mild flavor with no bitterness and a vibrant aroma.", price: 30.00, image: "images/espresso.jpeg", category: coffee_beans, intensity: 8 },
  { name: "Ethiopian Sidamo", description: "Light body with a nutty flavor and hints of chocolate.", price: 14.00, image: "images/ethiopian.jpeg", category: coffee_beans, intensity: 5 },
  { name: "French Roast", description: "Medium body with a mild, sweet flavor and floral aroma.", price: 14.75, image: "images/french.jpeg", category: coffee_beans, intensity: 7 },
  { name: "Guatemala Antigua", description: "Bright acidity with a medium body and wine-like flavor.", price: 16.50, image: "images/guatemalan.jpeg", category: coffee_beans, intensity: 6 },
  { name: "Mountain Mysore", description: "Full-bodied with a spicy, intense flavor and low acidity.", price: 15.25, image: "images/mountain.jpeg", category: coffee_beans, intensity: 8 },
  { name: "Yemen Mocha", description: "Complex flavor with chocolate and wine notes.", price: 18.00, image: "images/normal.jpeg", category: coffee_beans, intensity: 7 },
  { name: "Papua New Guinea", description: "Medium body with a bright, clean taste and fruity notes.", price: 15.50, image: "images/normal1.jpeg", category: coffee_beans, intensity: 6 },
  { name: "Korean Robusta", description: "Strong, full-bodied with a harsh flavor and high caffeine content.", price: 12.00, image: "images/normal2.jpeg", category: coffee_beans, intensity: 10 },
  { name: "El Salvador Bourbon", description: "Sweet caramel flavor with a crisp, clean finish.", price: 14.25, image: "images/robusta.jpeg", category: coffee_beans, intensity: 5 },
  { name: "Single Rwanda Kivu", description: "Bright, clean taste with citrus and floral notes.", price: 16.25, image: "images/single.jpeg", category: coffee_beans, intensity: 4 },
  { name: "Vietnamese Toraja", description: "Full-bodied with a rich, earthy flavor and low acidity.", price: 16.75, image: "images/vietnamese.jpeg", category: coffee_beans, intensity: 9 },
   { name: "Espresso Machine", description: "Compact and easy to use with a powerful 15-bar pump.", price: 199.99, image: "images/machine1.jpeg", category: coffee_machines },
   { name: "Espresso Machine", description: "Compact and easy to use with a powerful 15-bar pump.", price: 199.99, image: "images/machine2.jpeg", category: coffee_machines },
   { name: "French Press", description: "Classic brewing method for rich, full-bodied coffee.", price: 29.99, image: "images/machine3.jpeg", category: coffee_machines },
   { name: "Pour-Over Coffee Maker", description: "Precision brewing for a clean and flavorful cup.", price: 49.99, image: "images/machine4.jpeg", category: coffee_machines },
   { name: "Single Serve Coffee Maker", description: "Brew a single cup of coffee quickly and easily.", price: 89.99, image: "images/machine5.jpeg", category: coffee_machines },
   { name: "Cold Brew Coffee Maker", description: "Brew smooth and refreshing cold brew at home.", price: 39.99, image: "images/machine6.jpeg", category: coffee_machines },
   { name: "Drip Coffee Maker", description: "Easy-to-use machine for brewing multiple cups of coffee.", price: 59.99, image: "images/machine7.jpeg", category: coffee_machines },
   { name: "Espresso Grinder", description: "Grind your beans to perfection for espresso brewing.", price: 79.99, image: "images/machine8.jpeg", category: coffee_machines },
   { name: "Coffee Capsule Machine", description: "Convenient machine that uses capsules for quick brewing.", price: 129.99, image: "images/machine9.jpeg", category: coffee_machines },
   { name: "Ceramic Mug", description: "Convenient machine that uses capsules for quick brewing.", price: 5.00, image: "images/mug1.jpeg", category: mugs },
   { name: "Ceramic Mug", description: "Convenient machine that uses capsules for quick brewing.", price: 5.00, image: "images/mug2.jpeg", category: mugs },
   { name: "Travel Mug", description: "Insulated travel mug to keep your coffee hot on the go.", price: 12.99, image: "images/mug3.jpeg", category: mugs },
   { name: "Personalized Coffee Mug", description: "Customizable mug with your name or favorite quote.", price: 15.00, image: "images/mug4.jpeg", category: mugs },
   { name: "Espresso Mug Set", description: "Set of two elegant espresso cups and saucers.", price: 19.99, image: "images/mug5.jpeg", category: mugs },
    { name: "Glass Mug", description: "Stylish glass mug for enjoying your favorite coffee drinks.", price: 8.00, image: "images/mug6.jpeg", category: mugs },
    { name: "Stoneware Mug", description: "Durable stoneware mug with a comfortable handle.", price: 10.00, image: "images/mug7.jpeg", category: mugs }
])

puts "Seeding complete!"
