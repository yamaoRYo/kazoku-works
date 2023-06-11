import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="confirm"
export default class extends Controller {
  confirmLogout(e) {
    e.preventDefault()
    
    if (window.confirm("ログアウトしてよろしいですか")) {
      e.target.closest('form').submit();
    }
  }
}


