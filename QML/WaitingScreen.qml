import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
MouseArea{
    visible: mainWindow.curentOpenFile === "" ? false : true
    anchors.fill: parent
    Rectangle{
        anchors.fill: parent
        color: "#000000"
        opacity: 0.5
    }
    Rectangle{
        anchors.centerIn: parent
        color: "#ffffff"
        width: 200
        height: 100
        Text{
            anchors.centerIn: parent
            text: "Откройте базу данных"
        }
    }
}
