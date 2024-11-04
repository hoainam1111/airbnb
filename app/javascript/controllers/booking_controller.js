import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["nights", "baseFare","serviceFee", "totalAmount"]
    SERVICE_FEE = 0.18;

    connect() {
        const perNightPrice = this.element.dataset.perNightPrice;
        console.log(perNightPrice); 
        this.updateDetails();
    }
    updateDetails() {
        console.log(this.nightsTarget);
        console.log(this.numberOfNights);
        this.nightsTarget.textContent=this.numberOfNights();
        this.baseFareTarget.textContent=this.calculateBaseFare();
        this.serviceFeeTarget.textContent=this.calculateSeviceFee();
        this.totalAmountTarget.textContent=this.calculateTotalAmount();
    }
    numberOfNights(){
        return 4;
    }
    calculateBaseFare() {
        return parseFloat((this.numberOfNights() * this.element.dataset.perNightPrice).toFixed(2));
    }
    calculateSeviceFee() {
        return parseFloat((this.calculateBaseFare() * this.SERVICE_FEE).toFixed(2));
    }
    calculateTotalAmount() {
        return parseFloat((this.calculateBaseFare() + this.calculateSeviceFee()).toFixed(2));
    }
}
