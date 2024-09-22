import {addkeydownAndOnclick} from "./ymnlib"

export const Ymn = {
  mounted() {
    init()
  },
  updated() {
    init()
  },
}

const init = () => {
  addkeydownAndOnclick("#getclip", "p", readText)
  addkeydownAndOnclick("#gemini", "g", copy)
  
  document.addEventListener('keydown', (event) => {
    focus = document.querySelector("textarea:focus-visible, input:focus-visible")
    links = document.querySelectorAll("#links a")

    if (focus != null) return
    keyAssign(event, "c", "clear")
    for (i = 1; i <= links.length; i++) {
      keyAssign(event, i, "link" + i)
    }
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