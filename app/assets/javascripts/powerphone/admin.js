// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import { Turbo } from '@hotwired/turbo-rails'
import '@popperjs/core'
import * as bootstrap from 'bootstrap'
import { htmlNodeFromText, setWithDefault, UUIDv4 } from 'powerphone/utilities'

document.addEventListener('DOMContentLoaded', function () {
  // Initialize popovers
  const popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
  popoverTriggerList.map(function (popoverTriggerEl) {
    return new bootstrap.Popover(popoverTriggerEl)
  })
})

//
// <turbo-stream action="displayError" target="sip_domain"></turbo-stream>
// <turbo-stream action="displayError" target="sip_domain" message="SIP domain can't be blank"></turbo-stream>
// <turbo-stream action="displayError" targets="class-control" message="An error occured"></turbo-stream>
//
Turbo.StreamActions.displayError = function () {
  const message = setWithDefault(this.getAttribute('message'), 'Unknown error')

  this.targetElements.forEach((element) => {
    const elementId = setWithDefault(element.id, UUIDv4.generate())

    // If there was no id, now, there is!
    element.id = elementId

    const errorId = `${elementId}_error`
    element.classList.add('display-error')

    const errorElement = document.getElementById(errorId)
    if (errorElement) {
      errorElement.innerText = message
    } else {
      element.after(htmlNodeFromText(`<div id="${errorId}" class="form-text display-error-message">${message}</div>`))
    }
  })
}

//
// <turbo-stream action="resetDisplayError"></turbo-stream>
//
Turbo.StreamActions.resetDisplayError = function () {
  Array.from(document.getElementsByClassName('display-error-message')).forEach((element) => {
    element.previousSibling.classList.remove('display-error')
    element.remove()
  })
}
