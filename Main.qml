import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
Window {
    width: 1240
    height: 680
    minimumWidth: 840
    minimumHeight: 480
    visible: true
    title: "Warehousing"

    StackView{
        id: sv
        anchors.fill: parent
        initialItem: page1
    }
    Page{
        id: page1
        Rectangle{
            anchors.fill: parent
            color: "#D9D9D9"
            RowLayout{
                id: items
                spacing: 0
                anchors.fill: parent
                Rectangle{
                    id: buttons
                    Layout.preferredWidth: parent.width * 0.2
                    Layout.fillWidth: true
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    // color: "#DDDDDD"
                    color: "#c8c8c8"
                    ColumnLayout{
                        spacing: 10
                        anchors.fill: parent
                        Rectangle {
                            color: "transparent"
                        }
                        CustomButton{
                            anchors.horizontalCenter: parent.horizontalCenter
                            Layout.fillWidth: true
                            colorButton: "#5A5A5A"
                            colorText: "#E9E9E9"
                            textValue: "Создать товар"
                            height: 44
                            width: width - 10
                            fontSize: 14
                            onClicked: {
                                goods.model.append({col1: "", col2: "", col3: "", col4: ""});
                            }
                        }
                        CustomButton{
                            anchors.horizontalCenter: parent.horizontalCenter
                            Layout.fillWidth: true
                            colorButton: "#5A5A5A"
                            colorText: "#E9E9E9"
                            textValue: "Создать новую таблицу"
                            height: 44
                            width: width - 10
                            fontSize: 14
                        }
                        CustomButton{
                            anchors.horizontalCenter: parent.horizontalCenter
                            Layout.fillWidth: true
                            colorButton: "#5A5A5A"
                            colorText: "#E9E9E9"
                            textValue: "Открыть таблицу"
                            height: 44
                            width: width - 10
                            fontSize: 14
                        }
                        CustomButton{
                            anchors.horizontalCenter: parent.horizontalCenter
                            Layout.fillWidth: true
                            colorButton: "#5A5A5A"
                            colorText: "#E9E9E9"
                            textValue: "Поставки"
                            height: 44
                            width: width - 10
                            fontSize: 14
                        }
                        CustomButton{
                            anchors.horizontalCenter: parent.horizontalCenter
                            Layout.fillWidth: true
                            colorButton: "#5A5A5A"
                            colorText: "#E9E9E9"
                            textValue: "Поставщики"
                            height: 44
                            width: width - 10
                            fontSize: 14
                        }
                        CustomButton{
                            anchors.horizontalCenter: parent.horizontalCenter
                            Layout.fillWidth: true
                            colorButton: "#5A5A5A"
                            colorText: "#E9E9E9"
                            textValue: "Категории товаров"
                            height: 44
                            width: width - 10
                            fontSize: 14
                        }
                        CustomButton{
                            anchors.horizontalCenter: parent.horizontalCenter
                            Layout.fillWidth: true
                            colorButton: "#5A5A5A"
                            colorText: "#E9E9E9"
                            textValue: "Фильтр"
                            height: 44
                            width: width - 10
                            fontSize: 14
                        }
                        Rectangle {
                            Layout.fillHeight: true
                            color: "transparent"
                        }
                    }
                }
                ListView {
                    id: goods
                    Layout.preferredWidth: parent.width * 0.8
                    Layout.fillWidth: true
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    flickableDirection: Flickable.VerticalFlick
                    boundsBehavior: Flickable.StopAtBounds

                    model: ListModel {
                        ListElement { col1: "row1col1"; col2: "row1col2"; col3: "row1col3"; col4: "row1col4" }
                        ListElement { col1: "row2col1"; col2: "row2col2"; col3: "row2col3"; col4: "row2col4" }
                        ListElement { col1: "row2col1"; col2: "row2col2"; col3: "row2col3"; col4: "row2col4" }
                        ListElement { col1: "row2col1"; col2: "row2col2"; col3: "row2col3"; col4: "row2col4" }
                        // другие элементы ListElement
                    }

                    delegate: Row {
                        spacing: 10
                        Goods {}
                        Goods {}
                        Goods {}
                        Goods {}
                    }
                }
            }
        }
    }
}
// Goods{
//     onOrdering: {
//         sv.push(page2);
//     }
//     anchors.centerIn: parent
// }