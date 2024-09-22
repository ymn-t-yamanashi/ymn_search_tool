const focus = document.querySelector("textarea:focus-visible, input:focus-visible")
let keyList = [] 
export const addkeydownAndOnclick = (query, key, fn) => {
    document.querySelector(query).onclick = fn
    keyList.push({key: key, fn: fn})
    console.log(keyList)
    document.addEventListener('keydown', (event) => {
        if (focus != null) return
        for(let i = 0; i < keyList.length; i++) {
            key = keyList[i]
            if (event.key == key.key) key.fn()
        }
    })
}