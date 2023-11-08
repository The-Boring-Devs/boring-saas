import { Controller } from "@hotwired/stimulus"
import { enter, leave } from "el-transition"

export default class extends Controller {
  static values = {
    autoLeave: { type: Boolean, default: true },
    leaveTime: { type: Number, default: 2000 }
  }

  connect() {
    enter(this.element)

    this.setAutoLeave()
  }

  setAutoLeave() {
    if (this.autoLeaveValue) setTimeout(() => this.leave(), this.leaveTimeValue)
  }

  leave() {
    leave(this.element)
  }
}
