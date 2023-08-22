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
    age = age + "歳"

    // Calculate constellation
    let month = birthdate.getMonth() + 1
    let day = birthdate.getDate()
    if ((month == 1 && day >= 20) || (month == 2 && day <= 18)) {
      constellation = "水瓶座/aquarius"
    } else if ((month == 2 && day >= 19) || (month == 3 && day <= 20)) {
      constellation = "魚座/pisces"
    } else if ((month == 3 && day >= 21) || (month == 4 && day <= 19)) {
      constellation = "牡羊座/aries"
    } else if ((month == 4 && day >= 20) || (month == 5 && day <= 20)) {
      constellation = "牡牛座/taurus"
    } else if ((month == 5 && day >= 21) || (month == 6 && day <= 20)) {
      constellation = "双子座/gemini"
    } else if ((month == 6 && day >= 21) || (month == 7 && day <= 22)) {
      constellation = "蟹座/cancer"
    } else if ((month == 7 && day >= 23) || (month == 8 && day <= 22)) {
      constellation = "獅子座/leo"
    } else if ((month == 8 && day >= 23) || (month == 9 && day <= 22)) {
      constellation = "乙女座/virgo"
    } else if ((month == 9 && day >= 23) || (month == 10 && day <= 22)) {
      constellation = "天秤座/libra"
    } else if ((month == 10 && day >= 23) || (month == 11 && day <= 21)) {
      constellation = "蠍座/scorpio"
    } else if ((month == 11 && day >= 22) || (month == 12 && day <= 21)) {
      constellation = "射手座/sagittarius"
    } else {
      constellation = "山羊座/capricorn"
    }

    this.ageTarget.value = age
    this.constellationTarget.value = constellation
  }
}