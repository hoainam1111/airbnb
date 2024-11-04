import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
    static targets = ["nights","checkin","checkout", "baseFare","serviceFee", "totalAmount"]
    SERVICE_FEE = 0.18;
    disableDates = [];

    connect() {
        // console.log(this.element.dataset.blockedDates);

       this.formatBlockedDates();

        flatpickr(this.checkinTarget, {
            minDate: new Date().fp_incr(1),
            disable: this.disableDates,
            onChange: (selectedDates, dateStr, instance) => {
                this.triggerCheckoutDatePicker(selectedDates);
            }
        });
        this.updateDetails();
        
    }

    

    triggerCheckoutDatePicker(selectedDates) {
        flatpickr(this.checkoutTarget, {
            minDate: new Date(selectedDates).fp_incr(1),
            disable: this.disableDates,
            onChange: (selectedDates, dateStr, instance) => {
                this.updateDetails();
            }
        });
        this.checkoutTarget.click();
    }
    formatBlockedDates() {
        const blockedDates = JSON.parse(this.element.dataset.blockedDates);

        for(let i = 0 ; i < blockedDates.length; i++) {
            const dates = blockedDates[i];
            // console.log(dates[0]);
            // console.log(dates[1]);
            this.disableDates.push(
                {
                    from: dates[0], //check-in date
                    to: dates[1],   //check-out date
                }
            )
        }
    }
    updateDetails() {
        const nightsCount = this.numberOfNights;
        const baseFare = this.calculateBaseFare(nightsCount);
        const serviceFee = this.calculateSeviceFee(baseFare);
        const totalAmount = this.calculateTotalAmount(baseFare, serviceFee);

        this.nightsTarget.textContent=nightsCount;
        this.baseFareTarget.textContent=baseFare;
        this.serviceFeeTarget.textContent=serviceFee;
        this.totalAmountTarget.textContent=totalAmount;
    }
    get numberOfNights(){
        const checkinDate = new Date(this.checkinTarget.value);
        const checkoutDate = new Date(this.checkoutTarget.value);
        // console.log(checkinDate);
        // console.log(checkoutDate);
        return (checkoutDate - checkinDate) / (1000 * 60 * 60 * 24);
    }
    calculateBaseFare(nightsCount) {
        return parseFloat((nightsCount * this.element.dataset.perNightPrice).toFixed(2));
    }
    calculateSeviceFee(baseFare) {
        return parseFloat((baseFare * this.SERVICE_FEE).toFixed(2));
    }
    calculateTotalAmount(baseFare, serviceFee) {
        return parseFloat((baseFare + serviceFee).toFixed(2));
    }
}
