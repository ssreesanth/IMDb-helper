import { Application } from "@hotwired/stimulus";
import ImdbController from "../controllers/imdb_controller"; // Ensure the relative path is correct

const application = Application.start();
application.register("imdb-id", ImdbController);

window.Stimulus = application;
export { application };
