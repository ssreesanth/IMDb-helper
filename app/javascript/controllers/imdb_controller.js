import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log("IMDB controller connected");
    // initializing variables to hide and show list items later on
    this.currentDetails = null;
    this.previousItem = null;
  }
  imdbinfo(event) {
    console.log("seeking imdb-info")
    //getting the info IMDB id from the clicked element.
    const imdbId = event.currentTarget.dataset.imdbId;
    // targets the clicked list so that we can get its imdb id and send it to the api
    const listItem = event.currentTarget;
    // imdbId is the custom data set value we set in the list so that we can get the imdb id from the movie. its hidden to the user
    fetch(`https://www.omdbapi.com/?i=${imdbId}&apikey=adf1f2d7`)
      .then(response => response.json())
      .then(data => {
        console.log(data);
        this.displayMovieDetails(data, listItem);
      })
  }

  displayMovieDetails(data, listItem) {
    // adds the previous movie info back when we click on a new movie
    if (this.previousItem){
      this.previousItem.style.display = "block";
    }
    // removes the previous movie details if any
    if (this.currentDetails) {
      this.currentDetails.remove();
      listItem.style.display = '';
    }
    // Create HTML content for movie details
    const movieDetailsHTML = `
          <div class="movie-details">
            <img src="${data.Poster}" alt="${data.Title} Poster" style="width:100px; height:156px; float:left; margin-right:10px;">
            <p><b>Title:</b> ${data.Title}</p>
            <p><b>Rating:</b> ${data.imdbRating}</p>
            <p><b>Year:</b> ${data.Year}</p>
            <p class="movie-plot"><b>Plot:</b> ${data.Plot}</p>
          </div>
        `;

    // Insert the details after the clicked <li> element
    listItem.insertAdjacentHTML('afterend', movieDetailsHTML);
    // hides the list with movie info as we have a card with same info and more
    listItem.style.display = 'none';
    // this variable will be used to add the current movie as a list item when we click on a new movie
    this.previousItem = listItem;

    // stores the new div which shows the movie movie deatails. We can remove this when we click on a new movie
    this.currentDetails = listItem.nextElementSibling;

  }
}
