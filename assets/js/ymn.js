export const hooks = {
  ymn: {
    mounted() {
      init()
    },
    updated() {
      init()
    },
  },
}

const init = () => {
  SpeechRecognition = webkitSpeechRecognition || SpeechRecognition
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
  document.querySelector("#getclip").onclick = readText
  document.querySelector("#gemini").onclick = copy

  document.addEventListener('keydown', (event) => {
    focus = document.querySelector("textarea:focus-visible, input:focus-visible")
    links = document.querySelectorAll("#links a")

    if (focus != null) return
    keyAssign(event, "g", "gemini")
    keyAssign(event, "c", "clear")
    for (i = 1; i <= links.length; i++) {
      keyAssign(event, i, "link" + i)
    }
    if (event.key == "r") recognition_start()
  })

}

const copy = () => {
  let llm = document.querySelector("#llm")
  navigator.clipboard.writeText(llm.value)
}

const readText = () => {
  let questionType = document.querySelector("#question_type")
  navigator.clipboard.readText()
    .then(text => {
      location.href = "/?q=" + text + "&question_type=" + questionType.value
    })
}

const keyAssign = (event, key, id) => {
  if (event.key == key) document.querySelector("#" + id).click()
}