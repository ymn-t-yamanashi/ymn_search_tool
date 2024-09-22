
let keyList = [] 
export const addkeydownAndOnclick = (query, key, fn) => {
    dom = document.querySelector(query)
    dom.onclick = fn
    keyList.push({key: key, dom: dom})
    console.log(keyList)
    document.addEventListener('keydown', (event) => {
        let focus = document.querySelector("textarea:focus-visible, input:focus-visible")
        if (focus != null) return
        for(let i = 0; i < keyList.length; i++) {
            key = keyList[i]
            if (event.key == key.key) key.dom.click()
        }
    })
}