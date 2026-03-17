import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  copy() {
    let text = ""
    document.querySelectorAll("#songsList li").forEach((el, i) => {
      text += (i+1) + ". " + el.innerText + "\n"
    })
    navigator.clipboard.writeText(text)
  }

  openSpotlistr() {
    let text = ""
    document.querySelectorAll("#songsList li").forEach((el) => {
      text += el.innerText + "\n"
    })

    navigator.clipboard.writeText(text)
    window.open("https://beta.spotlistr.com/search/v2/textbox/spotify", "_blank")
  }
}
