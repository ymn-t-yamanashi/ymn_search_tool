const focus = document.querySelector("textarea:focus-visible, input:focus-visible")
export const addkeydownAndOnclick = (query, key, fn) => {
    document.querySelector(query).onclick = fn
    document.addEventListener('keydown', (event) => {
        if (focus != null) return
        if (event.key == key) fn()
    })
}