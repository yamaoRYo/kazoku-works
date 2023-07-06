import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="birthdate-calculations"
export default class extends Controller {
  static targets = ["birthdate", "age", "constellation"]

  calculate() {
    let birthdate = new Date(this.birthdateTarget.value)
    let age, constellation

    // Calculate age
    let today = new Date()
    age = today.getFullYear() - birthdate.getFullYear()
    if (today.getMonth() < birthdate.getMonth() || 
        (today.getMonth() == birthdate.getMonth() && today.getDate() < birthdate.getDate())) {
      age--
    }

    // Calculate constellation
    let month = birthdate.getMonth() + 1
    let day = birthdate.getDate()
    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
      constellation = "Aquarius"
    } else if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
      constellation = "Pisces"
    } else if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) {
      constellation = "Aries"
    } else if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
      constellation = "Taurus"
    } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
      constellation = "Gemini"
    } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
      constellation = "Cancer"
    } else if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
      constellation = "Leo"
    } else if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
      constellation = "Virgo"
    } else if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
      constellation = "Libra"
    } else if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) {
      constellation = "Scorpio"
    } else if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) {
      constellation = "Sagittarius"
    } else {
      constellation = "Capricorn"
    }

    this.ageTarget.value = age
    this.constellationTarget.value = constellation
  }
}