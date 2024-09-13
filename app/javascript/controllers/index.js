// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import ImdbController from "./imdb_controller"
application.register("imdb-id", ImdbController)

import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
