import QtQuick
import QtQuick.Controls

TextArea {
    id: description
    color: "#000000"
    width: 100
    height: 50
    implicitWidth: width
    implicitHeight: height
    placeholderText: "Впишите заголовок"
    wrapMode: TextArea.Wrap

    property int maxCharacters: 500
    onTextChanged: {
        if (description.length >= maxCharacters) {
            description.text = description.text.slice(0, -1);
            description.cursorPosition = maxCharacters - 1;
        }
    }
    Keys.onEnterPressed: {
        description.focus = false;
        hotKeyEscape.focus = true;
    }
    Rectangle {
        anchors.fill: parent
        border.color: "black"
        border.width: 2
        color: "#00000000"
    }
}