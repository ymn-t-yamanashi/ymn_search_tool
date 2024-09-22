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

  document.querySelector("#recognition").onclick = recognition_start

  document.addEventListener('keydown', (event) => {
    focus = document.querySelector("textarea:focus-visible, input:focus-visible")
    if (focus != null) return
    if (event.key == "r") recognition_start()
  })
}