import QtQuick

Rectangle {
    width: log.width
    height: 50
    id: root
    visible: false
    anchors {
        right: parent.right
        top: parent.top
        margins: 10
    }
    Text {
        id: log
        color: "black"
        font.pixelSize: 14
        padding: 10
        anchors {
            centerIn: parent
        }
    }
    Timer {
        id: timer
        interval: 1600
        onTriggered: {
            root.visible = false
        }
    }

    function message(text = "", isError = false) {
        visible = true
        log.text = text
        root.color = isError ? "#D32F2F" : "#4CAF50";
        timer.start()
    }
}