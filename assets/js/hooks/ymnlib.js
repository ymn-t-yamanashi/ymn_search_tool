
let keyList = []
const addeyList = (key, dom) => {
    for (let i = 0; i < keyList.length; i++) {
        if (keyList[i].key == key) return
    }
    keyList.push({ key: key, dom: dom })
}

export const addkeydownAndOnclick = (query, key, fn) => {
    dom = document.querySelector(query)
    dom.onclick = fn
    addeyList(key, dom)
    document.addEventListener('keydown', (event) => {
        let focus = document.querySelector("textarea:focus-visible, input:focus-visible")
        if (focus != null) return
        for (let i = 0; i < keyList.length; i++) {
            key = keyList[i]
            if (event.key == key.key) key.dom.click()
        }
    })
}