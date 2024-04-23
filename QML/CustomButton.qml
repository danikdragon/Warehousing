import QtQuick
import QtQuick.Controls

MouseArea {
    width: 100
    height: 50
    property color colorButton: "#000000"
    property color colorText: "#E9E9E9"
    property int fontSize: 12
    property string textValue: ""
    Rectangle {
        id: bg
        anchors.fill: parent
        color: colorButton
        clip: true
        Text {
            font.pixelSize: fontSize
            color: colorText
            anchors.centerIn: parent
            text: textValue
        }
    }
    onPressed: {
        bg.opacity = 0.5
        fontSize--
        goods.interactive = false
    }
    onReleased: {
        bg.opacity = 1
        fontSize++
        goods.interactive = true
    }
}