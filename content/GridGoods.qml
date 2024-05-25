import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

GridView {
    Layout.preferredWidth: parent.width * 0.8
    Layout.fillWidth: true
    cellWidth: 340 + parent.width * 0.019
    cellHeight: 580
    flow: GridView.FlowLeftToRight
    anchors {
        topMargin: 10
        right: parent.right
        top: parent.top
        bottom: parent.bottom
    }
    delegate: Goods {
        anchors.topMargin: 10
        imageSource: myPath
        titleText: myTitle
        descriptionText: myDescript
        value: myValue
        nameSupplier: supValue
        nameCategory: catValue
    }
    ScrollBar.vertical: ScrollBar {
        snapMode: ScrollBar.NoSnap
    }
    model: ListModel {
    }
}