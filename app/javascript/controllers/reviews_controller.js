import { Controller } from "@hotwired/stimulus"
import {enter, leave, toggle} from 'el-transition'

export default class extends Controller {

  connect () {
    console.log('reviews conneced')
  }
  toggleReviewsModal(){
    document.getElementById('reviews').click()
  }
}