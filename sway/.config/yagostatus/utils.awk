function jsonify(label, text, color) {
    if (label != "") {
        text = sprintf("%s %s", label, text)
    }

    printf "[{ \"full_text\": \"%s\", \"color\": \"%s\" }]", text, color
}
