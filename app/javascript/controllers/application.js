import { Application } from "@hotwired/stimulus";
import ImdbController from "./imdb_controller";

const application = Application.start();
application.register("imdb-id", ImdbController);

window.Stimulus = application;
export { application };
