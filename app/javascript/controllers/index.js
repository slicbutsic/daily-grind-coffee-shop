// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)

import WishlistController from "./wishlist_controller"
application.register("wishlist", WishlistController)

import NavbarController from "./navbar_controller"
application.register("navbar", NavbarController)

import LoginController from "./login_controller"
application.register("login", LoginController)
