// app/javascript/controllers/image_preview_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "preview", "img"]

    show() {
        const file = this.inputTarget.files[0]
        if (file && file.type.startsWith("image/")) {
            const reader = new FileReader()
            reader.onload = (e) => {
                this.imgTarget.src = e.target.result
                this.previewTarget.classList.remove("d-none")
            }
            reader.readAsDataURL(file)
        }
    }

    remove() {
        this.inputTarget.value = ""
        this.previewTarget.classList.add("d-none")
    }
}