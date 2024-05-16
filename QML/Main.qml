import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform
import QtQuick.Window
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
    id: mainWindow
    function undoText() {
        sv.pop();
        createId.textValue = "Создать товар";
        suppliersId.textValue = "Поставщики";
        categoriesButton.textValue = "Категории товаров";
    }
    Item {
        id: hotKeyEscape
        focus: true
        Keys.onEscapePressed:{
            undoText()
        }
    }

    Rectangle {
        opacity : 1
        anchors.fill: parent
        color: "#c8c8c8"
    }
    RowLayout {
        anchors.fill: parent
        Rectangle {
            // color: "#DDDDDD"
            // color: "#c8c8c8"
            color: "transparent"
            id: buttons
            Layout.preferredWidth: (parent.width * 0.2)
            Layout.fillWidth: true
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                leftMargin: 2.5
            }
            ColumnLayout {
                spacing: 10
                anchors.fill: parent
                Rectangle {
                    color: "transparent"
                }

                CustomTextArea{
                    id: searchText
                    height: 40
                    anchors{
                        left: createId.left
                        right: createId.right
                    }
                    placeholderText: "Поставщик/Категория\nЗаголовок/Описание"
                    maxCharacters: 80
                    Layout.preferredWidth: parent.width
                    onTextChanged: {
                        goodsPage.sorting();
                    }
                }
                MenuButton {
                    id: createId
                    textValue: "Создать товар"
                    onClicked: {
                        if (textValue === "Создать товар") {
                            undoText();
                            sv.push(createGoodsPage);
                            textValue = "Назад";
                        } else {
                            undoText();
                        }
                    }
                }
                MenuButton {
                    id: categoriesButton
                    textValue: "Категории товаров"

                    onClicked:{
                        if (textValue === "Категории товаров") {
                            undoText();
                            sv.push(categoriesPage);
                            textValue = "Назад";
                        } else {
                            undoText();
                        }
                    }
                }
                MenuButton {
                    id: suppliersId
                    textValue: "Поставщики"
                    onClicked: {
                        if (textValue === "Поставщики") {
                            undoText();
                            sv.push(suppliers);
                            textValue = "Назад";
                        } else {
                            undoText();
                        }
                    }
                }
                MenuButton {
                    textValue: "Поставки"
                }

                MenuButton {
                    id: createTableId
                    textValue: "Создать таблицу"
                    onClicked: {
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
                MenuButton {
                    textValue: "Открыть таблицу"
                    onClicked: {
                        openJson.open();
                    }
                    FileDialog {
                        id: openJson
                        title: "Выберите файл"
                        currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                        nameFilters: ["Data (*.json)"]
                        onAccepted: {
                            curentOpenFile = selectedFile;
                        }
                    }
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
    CreateGoods {
        id: createGoodsPage
        anchors.fill: parent
        visible: false
    }
    SuppliersPage {
        id: suppliers
        anchors.fill: parent
        visible: false
    }
    Categories{
        id: categoriesPage
        anchors.fill: parent
        visible: false
    }
    Answer {
        id: appAnswer
    }
}