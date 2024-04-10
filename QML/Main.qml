import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import Qt.labs.platform 1.1
import QtQuick.Dialogs
import QtQuick.Effects

Window {
    Rectangle{
        anchors.fill : parent
        color: "#c8c8c8"
    }
    height: 680
    minimumHeight: 580
    minimumWidth: 920
    title: "Warehousing"
    visible: true
    width: 1400
    property string curentOpenFile

    RowLayout{
        anchors.fill: parent

        Rectangle{
            id: buttons
            Layout.preferredWidth: (parent.width * 0.2)
            Layout.fillWidth: true
            anchors{
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                leftMargin: 2.5
            }
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
                            sv.push(createGoodsPage);
                            textValue = "Назад";
                        }else{
                            sv.pop();
                            textValue = "Создать товар";
                        }
                    }
                }
                MenuButton{
                    textValue: "Создать новую таблицу"
                    onClicked:{
                        createJson.open();
                    }
                    FileDialog {
                        id: createJson
                        title: "Выберите файл"
                        currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                        nameFilters: ["folder"]
                        onAccepted: {

                        }
                    }
                }
                MenuButton{
                    textValue: "Открыть таблицу"
                    onClicked:{
                        openJson.open();
                    }
                    FileDialog {
                        id: openJson
                        title: "Выберите файл"
                        currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                        nameFilters: [ "Data (*.json)"]
                        onAccepted: {
                            curentOpenFile = selectedFile;
                        }
                    }
                }
                MenuButton{
                    textValue: "Поставки"
                }
                MenuButton{
                    textValue: "Поставщики"
                    onClicked: {
                        if(textValue === "Поставщики"){
                            sv.push(page3);
                            textValue = "Назад";
                        }else{
                            sv.pop();
                            textValue = "Поставщики";
                        }
                    }
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

            initialItem: goodsPage
        }
    }

    Page1 {
        id: goodsPage
        anchors.fill: parent
        visible: false
    }
    CreateGoods{
        id: createGoodsPage
        anchors.fill: parent
        visible: false
    }
    Page{
        id: page3

        MultiEffect {
            source: sourceItem
            anchors.fill: sourceItem
            shadowBlur: 2.0
            shadowEnabled: true
            shadowVerticalOffset: 10
            shadowHorizontalOffset: 5
        }
        Rectangle {
            id: sourceItem
            width: 100
            height: 100
            color: "grey"
            anchors.centerIn: parent
        }
        visible: false
    }
}