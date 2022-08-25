import { Controller } from "@hotwired/stimulus"

export default class Orders extends Controller {
  calculate() {
    document.getElementById('order-form').requestSubmit()
  }
}
