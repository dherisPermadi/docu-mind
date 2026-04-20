import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "form","spinner", "button", "error" ]

  showLoading() {
    document.getElementById("submit-btn").classList.add("hidden")
    document.getElementById("loading-spinner").classList.remove("hidden")
    document.getElementById("chat-results").style.opacity = "0.5"
  }

  hideLoading() {
    document.getElementById("submit-btn").classList.remove("hidden")
    document.getElementById("loading-spinner").classList.add("hidden")
    document.getElementById("chat-results").style.opacity = "1"
    document.querySelector('input[name="question[user_query]"]').value = ""
  }

  submit() {
    this.spinnerTarget.classList.remove("hidden")
    this.containerTarget.classList.add("hidden")
  }

  typeEffect() {
    const element = this.contentTarget
    const text = element.dataset.fullText
    element.innerHTML = ""
    
    let i = 0
    const speed = 10

    const type = () => {
      if (i < text.length) {
        element.textContent += text.charAt(i)
        i++
        setTimeout(type, speed)
      }
    }
    type()
  }
}