# Monster Shop
## Background and Description

***Monster Shop*** is a fictitious e-commerce platform where users can register to be able to place items into a shopping cart and 'check out'. Users who work for a merchant can mark their items as 'fulfilled'; the last merchant to mark items in an order as 'fulfilled' will automatically set the order status to "shipped". Each user role will have access to some or all CRUD functionality for application models.

### USED POSTGRESQL

**Many to Many Relationships and One to Many Relationships**

* This project utilizes both one-to-many and many-to-many relationships, connecting multiple tables in our database for an easier user experience.

  ![](https://f000.backblazeb2.com/file/MarkdownImages/monster-shop.png)

## Access
To visit our shop click [here](https://monster-shop-krd.herokuapp.com) to access the shop in production

## Contribution
- To contribute visit [https://github.com/sciencefixion/monster_shop_2005](https://github.com/sciencefixion/monster_shop_2005)  and clone the project.
- Run
  - [x] `bundle install`
  - [x] `rails db: {create, migrate}`
  - [x] `rails serve`

## User Roles for Monster Shop

There are four types of users  with different roles:-

1. Visitor - this type of user can anonymously browse through our site without logging in and will be able to view all the items and add them to the cart.  

   - Before you are able to checkout with any merchandise, you will need to register as a new user.

   - When registering, fill in all the fields with your information and remember, your email address must be unique!

   - Using a unique email allows us to register and view your unique profile page.

2. Regular User - This type of user is registered and logged in to the application.

   - User can order items
   - User can checkout items.	

3. Merchant User - This is a Merchant employee with unique abilities. 

   - They can fulfill orders on behalf of their merchant. 
   - They have the same permissions as a regular user 
   - They can activate, deactivate edit add and delete an item.

4. Admin User - Is a superuser who has unlimited controll of the app.

### Rails
* Create routes for namespaced routes
* Use Sessions to store information about a user and implement login/logout functionality
* Use BCrypt to hash user passwords before storing in the database
* Use filters (e.g. `before_action`) in a Rails controller => this functionality makes authorization possible.

## Application Resources

- Uses Rails 5.1.x
- Uses PostgreSQL
- Uses 'bcrypt' for authentication
- Controller and model code was be tested via feature tests and model tests, respectively
- Created using good GitHub branching, team code reviews via GitHub comments, and use Trello for team planning.
- Deployed on heroku.


## Contributors and links to their Github Repositories:

* [Kwibe Merci](https://github.com/jKwibe)

* [Ryan Laleh](https://github.com/RyN21)

* [Dorion](https://github.com/sciencefixion)


