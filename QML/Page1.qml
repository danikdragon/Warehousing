import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

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
                    MenuButton{
                        textValue: "Создать товар"
                        onClicked: {
                            goods.model.append({col1: ""});
                        }
                    }
                    MenuButton{
                        textValue: "Создать новую таблицу"
                    }
                    MenuButton{
                        textValue: "Открыть таблицу"
                    }
                    MenuButton{
                        textValue: "Поставки"
                    }
                    MenuButton{
                        textValue: "Поставщики"
                    }
                    MenuButton{
                        textValue: "Категории товаров"
                    }
                    MenuButton{
                        textValue: "Фильтр"
                    }
                    Rectangle {
                        Layout.fillHeight: true
                        color: "transparent"
                    }
                }
            }

            Item{
                Layout.preferredWidth: goods.width * 0.019
            }
            GridView {
                id: goods
                Layout.preferredWidth: parent.width * 0.8
                Layout.fillWidth: true
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                cellWidth: 340 + parent.width * 0.019
                cellHeight: 580
                flow: GridView.FlowLeftToRight

                model: ListModel {
                    id: myModel
                }
                delegate: Rectangle {

                    Goods{

                    }
                }
                ScrollBar.vertical: ScrollBar { }
            }
        }
    }
}