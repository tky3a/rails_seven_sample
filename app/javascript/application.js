// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "jquery"
import "./common/drawer"

// turbo　有効時のサンプル（うまくいかなかったからコメントアウト）
//　参考 https://qiita.com/morrr/items/54f4be21032a45fd4fe9
// document.addEventListener("turbo:load", function () {
//     // var links = document.querySelectorAll(".link");
//     // const link = document.getElementById("link")
//     // document.addEventListener("turbo:click", function () {
//     //     alert("aaaaa")
//     // })
//     // links.forEach(function (link) {
//     //     link.addEventListener("turbo:click", function () {
//     //         alert("aaaaa")
//     //     })
//     // })
// })