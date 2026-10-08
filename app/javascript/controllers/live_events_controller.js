import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="live-events"
export default class extends Controller {
  connect() {
  }

  toggleAttended(event) {
    const checkbox = event.currentTarget
    const liveEventId = checkbox.value
    const attended = checkbox.checked
    const note = checkbox.nextElementSibling

    console.log("ID:", liveEventId)
    console.log("Attended:", attended)

    note.classList.toggle("attended", attended)

    fetch(`/live_events/${liveEventId}`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({ live_event: { attended } })
    })
  }
}
