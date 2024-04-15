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
                    id: suppliersId
                    textValue: "Поставщики"
                    onClicked: {
                        if(textValue === "Поставщики"){
                            undoText();
                            sv.push(page3);
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
    Page{
        id: page3
        anchors.fill: parent
        visible: false
        ColumnLayout{
            anchors{
                fill: parent
                leftMargin:10
                rightMargin:10
            }
            Text {
                id:titlePage
                font.bold: true
                font.pixelSize: 40
                horizontalAlignment: Text.AlignHCenter
                text: "Создание карточки"
                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                }
            }
            RowLayout{
                id: createButtons
                anchors{
                    top: titlePage.bottom
                }
                CustomTextArea{
                    id: nameTextArea
                    font.pixelSize: 14
                    Layout.fillWidth: true
                    placeholderText: "Впишите имя"
                }
                CustomTextArea{
                    id: numberTextArea
                    font.pixelSize: 14
                    Layout.fillWidth: true
                    placeholderText: "Впишите номер"
                }
                CustomButton{
                    Layout.fillWidth: true
                    textValue: "Cоздать"
                    id: createButton
                    onClicked:{
                        if(nameTextArea.text !== "" && numberTextArea.text !== ""){
                            myList.model.append({
                                name:nameTextArea.text,
                                number:numberTextArea.text
                            });
                            nameTextArea.text = ""
                            numberTextArea.text = ""
                        }

                    }
                }
            }
            ListView{
                clip: true
                id: myList
                Layout.fillWidth: true
                anchors{
                    right: parent.right
                    top: createButtons.bottom
                    bottom: parent.bottom
                }
                spacing:10

                delegate: RowLayout{
                    id: obj
                    width: myList.model.widht
                    height: 50
                    Rectangle{
                        id: rectName
                        height: 50
                        clip: true
                        width: nameTextArea.width
                        color: "#646464"
                        anchors{
                            left: page3.left
                        }
                        Text{
                            color: "white"
                            text: name
                            font.pixelSize: 14
                            wrapMode: TextArea.Wrap
                            width: parent.width
                            anchors{
                                margins: 10
                                centerIn:parent
                            }
                        }
                    }

                    Rectangle{
                        id: spacerRect
                        width: 5
                        anchors.left: rectName.right
                    }

                    Rectangle{
                        clip: true
                        height: 50
                        id: rectNumber
                        width: numberTextArea.width
                        color: "#969696"
                        anchors{
                            left: spacerRect.right
                        }
                        Text{
                            font.pixelSize: 14
                            color: "black"
                            text: number
                            wrapMode: TextArea.Wrap
                            width: parent.width
                            anchors{
                                centerIn:parent
                                margins: 10
                            }
                        }
                    }
                    CustomButton{
                        Layout.fillWidth: true
                        textValue: "Удалить"
                        width: createButton.width
                        anchors{
                            leftMargin:5
                            left: rectNumber.right
                        }
                        onClicked:{
                            myList.model.remove(index);
                        }
                    }
                }
                model: ListModel {}
                ScrollBar.vertical: ScrollBar {
                    anchors{
                        top: page3.top
                        bottom: page3.bottom
                    }
                    snapMode : ScrollBar.NoSnap
                }
            }
        }
    }
}