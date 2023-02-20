import { Controller } from '@hotwired/stimulus'
import { Notify } from 'notiflix/build/notiflix-notify-aio'

export default class extends Controller {
  static values = {
    flashType: String,
    message: String,
  }
  connect() {
    console.log('message', this.messageValue)
    console.log('type', this.flashTypeValue)
    const options = {
      timeout: 4000,
      clickToClose: true,
    }

    switch (this.flashTypeValue) {
      case 'notice':
      case 'success':
        Notify.success(this.messageValue, options)
        break
      case 'info':
        Notify.info(this.messageValue, options)
        break
      case 'error':
        Notify.failure(this.messageValue, options)
        break
    }
  }
}
