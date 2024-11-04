import { Controller } from "@hotwired/stimulus"
import {enter, leave, toggle} from 'el-transition'

export default class extends Controller {

  static targets =['dropdown', 'openUserMenu']

  connect () {
    
  }
  toggleModal() {
    const modalTriggerId = this.element.dataset.modalTriggerId;
    toggle(document.getElementById(`modal-${modalTriggerId}wrapper`));
  }
}


