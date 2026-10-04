import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "results"]

  connect() {
    this.timeout = null
  }

  // 入力が止まってから 300ms後に検索を実行
  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      const query = this.inputTarget.value.trim()

      if (query === "") {
        this.resultsTarget.innerHTML = ""
        return
      }

      this.fetchPlaces(query)
    }, 300)
  }

  async fetchPlaces(query) {
    try {
      const response = await fetch("/live_events/venue_search", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector(
            'meta[name="csrf-token"]'
          ).content
        },
        body: JSON.stringify({
          query: query
        })
      })

      if (!response.ok) {
        throw new Error("会場検索に失敗しました")
      }

      const data = await response.json()
      console.log(JSON.stringify(data, null, 2))
      this.displayResults(data.suggestions)
    } catch (error) {
      console.error("会場検索エラー:", error)
      this.resultsTarget.innerHTML = ""
    }
  }

  displayResults(suggestions) {
    this.resultsTarget.innerHTML = ""

    suggestions.forEach((suggestion) => {
      const place = suggestion.placePrediction

      if (!place) return

      const button = document.createElement("button")
      button.type = "button"

      const mainText = document.createElement("div")
      mainText.textContent = place.structuredFormat.mainText.text

      const secondaryText = document.createElement("div")
      secondaryText.textContent = place.structuredFormat.secondaryText?.text || ""

      button.appendChild(mainText)
      button.appendChild(secondaryText)
    
      button.addEventListener("click", () => {
        this.selectPlace(place)
      })
      
      this.resultsTarget.appendChild(button)
    })
  }

  selectPlace(place) {
    this.inputTarget.value = place.structuredFormat.mainText.text

    // 結果をクリア
    this.resultsTarget.innerHTML = ""
  }
} 



