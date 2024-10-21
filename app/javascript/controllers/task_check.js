// code to add strikethrough behaviour on the tasks index page

const taskInput = document.querySelectorAll(".form-check-input")

taskInput.forEach(function (el) {
  el.addEventListener("change", function () {
    const taskName = el.nextElementSibling
    console.log("click")
    taskName.classList.toggle("strikethrough")
  })
});
