// code to add toggle behaviour on the add watchlist button on IMDB

document.addEventListener("DOMContentLoaded", function(){
  setTimeout(function(){
  const toggleButton = document.querySelector(".add-watchlist")
  const toggleElement = document.querySelector(".watchlist-form")

  toggleButton.addEventListener("click", function(){
    toggleElement.classList.toggle("d-none");
  })
}, 300)
})
