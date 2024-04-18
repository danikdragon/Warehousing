import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import Qt.labs.platform 1.1
import QtQuick.Dialogs
import QtQuick.Effects

Window {
    height: 680
    minimumHeight: 580
    minimumWidth: 920
    title: "Warehousing"
    visible: true
    width: 1400
    property string curentOpenFile
    function undoText(){
        sv.pop();
        createId.textValue = "Создать товар";
        suppliersId.textValue = "Поставщики";
    }
    Rectangle{
        anchors.fill : parent
        color: "#c8c8c8"
    }
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
                    id: createId
                    textValue: "Создать товар"
                    onClicked: {
                        if(textValue === "Создать товар"){
                            undoText();
                            sv.push(createGoodsPage);
                            textValue = "Назад";
                        }else{
                            undoText();
                        }
                    }
                }
                MenuButton{
                    id: createTableId
                    textValue: "Создать новую таблицу"
                    onClicked:{
                        createJson.open();
                    }
                    FileDialog {
                        id: createJson
                        title: "Выберите папку"
                        fileMode: FileDialog.SaveFile
                        currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                        nameFilters: [".json"]
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
                    id: suppliersId
                    textValue: "Поставщики"
                    onClicked: {
                        if(textValue === "Поставщики"){
                            undoText();
                            sv.push(suppliers);
                            textValue = "Назад";
                        }else{
                            undoText();
                        }
                    }
                }
                MenuButton{
                    textValue: "Поставки"
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


    MainPage {
        id: goodsPage
        anchors.fill: parent
        visible: false
    }
    CreateGoods{
        id: createGoodsPage
        anchors.fill: parent
        visible: false
    }
    SuppliersPage{
        id: suppliers
        anchors.fill: parent
        visible: false
    }
    Answer{id: appAnswer}
}