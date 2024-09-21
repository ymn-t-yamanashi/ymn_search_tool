export const hooks = {
    ymn: {
      mounted() {
        init()
      },
      updated() {
        init()
      },
    },
  };

function init() {
    SpeechRecognition = webkitSpeechRecognition || SpeechRecognition
    const recognition = new SpeechRecognition()

    recognition.onresult = (event) => {
        result = event.results[0][0].transcript
        q = document.querySelector("#q")
        q.value = result
        document.querySelector("form").requestSubmit()
    }

    document.querySelector("#getclip") //.addEventListener("click", (event) => {readText()});

    document.addEventListener('keydown', (event) => {
        focus = document.querySelector("textarea:focus-visible, input:focus-visible")
        links = document.querySelectorAll("#links a")

        if (focus != null) return 
        keyAssign(event, "g", "gemini")
        keyAssign(event, "c", "clear")
        for(i = 1; i <= links.length; i++) {
            keyAssign(event, i, "link" + i)
        }
        if(event.key == "r") recognition.start()
    });
}

function copy(){
  let llm = document.querySelector("#llm")
  let value = llm.value

  navigator.clipboard.writeText(value)
} 

function readText(){
  let questionType = document.querySelector("#question_type")
   navigator.clipboard.readText()
    .then(text => {
      location.href="/?q=" + text + "&question_type=" + questionType.value
  })
}

function keyAssign(event, key, id) {
  if(event.key == key) document.querySelector("#" + id).click()
}