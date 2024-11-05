Yenda Foodies App

Yenda Foodies App is an application designed specifically to help customers of Warung Padang Yenda Foodies
find menu information, read reviews, and enjoy an easier ordering experience. 
This app is built with Flutter and Dart for the user interface (frontend) and PHP Laravel 11 for the API and data management (backend).

Main Features
Complete Menu List: Displays the full menu of Warung Padang Yenda Foodies, including prices and descriptions.
Popular Menu Recommendations: Provides recommendations for the most ordered menu items.
Customer Reviews and Ratings: Users can leave reviews and ratings for the menu items they’ve tried.
User Profile: Users can create profiles, view order histories, and manage preferences.
Delivery Service (Shipper): Supports ordering with a delivery option for customer convenience.

Technologies Used
Frontend: Flutter & Dart
Backend: PHP Laravel 11


Project Structure
Yenda-Foodies-App/
├── admin/               # Admin app for menu and data management
│   ├── lib/             # Main code for the admin interface
│   └── assets/          # Asset files for the admin interface
├── api/                 # Laravel backend as the main API
│   ├── app/             # Main Laravel code (Controllers, Models, etc.)
│   ├── config/          # Laravel app configuration
│   ├── database/        # Database schema and migrations
│   └── routes/          # Laravel API routes
├── shipper/             # Delivery-related app
│   ├── lib/             # Main code for the delivery interface
│   └── assets/          # Asset files for the delivery interface
├── user/                # Main app for end users
│   ├── lib/             # Main code for the user app
│   └── assets/          # Asset files for the user app
└── README.md            # Project documentation

Installation:
- Backend (Laravel 11)
1. Clone the repository:
git clone https://github.com/Erlemico/Yenda-Foodies-App.git

3. Go to the api directory for the backend:
cd Yenda-Foodies-App/api

3. Install Laravel dependencies:
composer install

4. Create the .env file from .env.example and configure the database settings:
cp .env.example .env

5. Generate the application key:
php artisan key:generate

6. Run the database migrations to create the necessary tables:
php artisan migrate

7. Start the Laravel server:
php artisan serve

- Frontend (Flutter)
1. Make sure you’re in the main repository directory, then go to the user folder for the user app:
cd Yenda-Foodies-App/user

2. Install all Flutter dependencies:
flutter pub get

3. Run the Flutter app on an emulator or physical device:
flutter run

- Admin Panel
1. To access the admin panel, go to the admin directory:
cd Yenda-Foodies-App/admin

2. Install Flutter dependencies for the admin app:
flutter pub get

3. Run the admin app:
flutter run

- Shipper App
1. Go to the shipper directory for the delivery app:
cd Yenda-Foodies-App/shipper

2. Install Flutter dependencies for the shipper app:
flutter pub get

3. Run the shipper app:
flutter run

Usage
Admin Panel: Allows admins to add, edit, and delete menu items, view order reports, and manage restaurant data.
User App: Allows users to browse the menu, leave reviews, view popular menu recommendations, and place orders.
Shipper App: Handles delivery orders to customers.

Contribution
We welcome contributions from anyone who wants to help improve this app. If you would like to contribute:

1. Fork this repository.
2. Create a new branch for your feature or fix:
git checkout -b new-feature

3. Commit your changes:
git commit -m "Add new feature"

4. Push to your branch:
git push origin new-feature

5. Open a pull request to this repository.

License
This project is licensed under the MIT License.
