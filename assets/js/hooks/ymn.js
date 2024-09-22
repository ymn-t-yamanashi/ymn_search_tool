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
  addkeydownAndOnclick("#clear", "c")
  links = document.querySelectorAll("#links a")
  for (i = 1; i <= links.length; i++) {
    addkeydownAndOnclick("#link" + i, i,)
  }
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

