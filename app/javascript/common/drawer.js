const nav = document.getElementById("navArea")
const drawerBtn = document.getElementById("drawerBtn")
const mask = document.getElementById("mask")

// ドロワーボタン押下イベント
if (drawerBtn) {
    drawerBtn.addEventListener("click", () => {
        if (nav.className !== "open") {
            nav.classList.add("open")
        } else {
            nav.classList.remove("open")
        }
    })
}

// マスク押下イベント
if (mask) {
    mask.addEventListener("click", () => {
        nav.classList.remove("open")
    })
}