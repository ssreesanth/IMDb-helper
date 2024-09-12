import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log("IMDB controller connected");
    // this.currentDetails = null;
  }
  imdbinfo(event) {
    console.log("seeking imdb-info")
    //getting the info IMDB id from the clicked element.
    const imdbId = event.currentTarget.dataset.imdbId;
    const listItem = event.currentTarget;

    fetch(`http://www.omdbapi.com/?i=${imdbId}&apikey=adf1f2d7`)
      .then(response => response.json())
      .then(data => {
        console.log(data);
        this.displayMovieDetails(data, listItem);
      })
  }

  displayMovieDetails(data, listItem) {

    if (this.currentDetails) {
      this.currentDetails.remove();
    }
    // Create HTML content for movie details
    const movieDetailsHTML = `
          <div class="movie-details">
            <img src="${data.Poster}" alt="${data.Title} Poster" style="width:100px; height:156px; float:left; margin-right:10px;">
            <p><b>Title:</b> ${data.Title}</p>
            <p><b>Rating:</b> ${data.imdbRating}</p>
            <p><b>Year:</b> ${data.Year}</p>
            <p><b>Plot:</b> ${data.Plot}</p>
          </div>
        `;

    // Insert the details after the clicked <li> element
    listItem.insertAdjacentHTML('afterend', movieDetailsHTML);
    listItem.style.display = 'none';
    this.currentDetails = listItem.nextElementSibling;

  }
}
