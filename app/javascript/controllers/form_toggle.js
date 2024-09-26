
document.addEventListener("DOMContentLoaded", function(){
  const toggleButton = document.querySelector(".add-watchlist")
  const toggleElement = document.querySelector(".watchlist-form")

  toggleButton.addEventListener("click", function(){
    toggleElement.classList.toggle("d-none");
  })
})
