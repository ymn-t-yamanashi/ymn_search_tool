import {addkeydownAndOnclick} from "./ymnlib.js"

export const YmnSpeechRecognition = {
  mounted() {
    init()
  },
  updated() {
    init()
  },
}

const init = () => {
  const SpeechRecognition = webkitSpeechRecognition || SpeechRecognition
  const recognition = new SpeechRecognition()

  recognition.onresult = (event) => {
    result = event.results[0][0].transcript
    q = document.querySelector("#q")
    q.value = result
    document.querySelector("form").requestSubmit()
  }

  const recognition_start = () => {
    recognition.start()
  }
  addkeydownAndOnclick("#recognition", "r", recognition_start)
}