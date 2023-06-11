import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    setTimeout(() => {
      this.dismiss()
    }, 3000);  // 3秒後にフラッシュメッセージを消去する
  }
  
  dismiss() {
    this.element.remove();
  }
}
