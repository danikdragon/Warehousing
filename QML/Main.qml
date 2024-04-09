import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

Window {
    height: 680
    minimumHeight: 580
    minimumWidth: 920
    title: "Warehousing"
    visible: true
    width: 1400

    RowLayout{
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
                        if(textValue === "Создать товар"){
                            sv.push(page2);
                            textValue = "Назад";
                        }else{
                            sv.pop();
                            textValue = "Создать товар";
                        }
                    }
                }
                MenuButton{
                    textValue: "Создать новую таблицу"
                    onClicked: {
                        page1.createGoods();
                    }
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

        StackView {
            id: sv

            pushEnter: null
            pushExit: null
            popEnter: null
            popExit: null

            Layout.fillWidth: true
            Layout.preferredWidth: parent.width * 0.8

            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            initialItem: page1
        }
    }

    Page1 {
        id: page1
        anchors.fill: parent
        visible: false
    }
    CreateGoods{
        id: page2
        anchors.fill: parent
        visible: false
    }
}