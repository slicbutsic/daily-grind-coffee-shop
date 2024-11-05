# Daily Grind Coffee E-commerce

Welcome to the **Daily Grind** coffee e-commerce website! This application allows users to browse and purchase a variety of coffee products, manage their profiles, and keep track of their orders. Below is a comprehensive guide to help you set up, run, and deploy the application.


## Features
- **User Authentication**: Users can sign up, log in, and manage their profiles.
- **Product Catalog**: Browse a wide selection of coffee, coffee machines and mugs.
- **Wishlist**: Save favorite products for later purchase.
- **Order Management**: View past orders and track current orders.
- **Shopping Cart**: Add products to a cart for easy checkout and manage quantities before purchasing.
- **Stripe Payment Integration**: Seamlessly process payments using Stripe, allowing users to pay securely with credit or debit cards.
- **Freight Cost Calculation**: Automatically calculate shipping costs based on user location.
- **Responsive Design**: Mobile-friendly layout for easy browsing on any device.

## Technologies Used
- **Ruby on Rails**: The web framework used for building the application.
- **PostgreSQL**: The database management system for storing user and product data.
- **Tailwind**: Front-end framework for responsive design.
- **StimulusJS**: JavaScript framework for enhancing interactivity.

## Getting Started
To set up the project locally, follow these steps:

### Prerequisites
Make sure you have the following installed:
- Ruby (version 3.0 or higher)
- Rails (version 7.1 or higher)
- PostgreSQL
- Node.js or Yarn

### Installation Steps
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/slicbutsic/daily-grind-coffee-shop.git
   cd daily-grind
2. **Start Database & Server**:
   ```bash
   rails db:create
   rails db:migrate
   rails db:seed
   rails s
