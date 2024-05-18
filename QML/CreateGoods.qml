import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform
import QtQuick.Dialogs
import QtQuick.Effects

Page {
    id: root
    property string hrefFromImg: "qrc:/Warehousing/Images/Pc.png"
    property int valueGoods: 0

    property int numberOfEdit: 0
    property  string lastSup:""
    property  string lastName:""

    function onRedact(number = 0, t_title = "", t_href = "", t_desc = "", t_value = 0, t_sup = "", t_cat = ""){
        createOrEditButton.textValue = "Сохранить";
        appAnswer.message("Режим редактирования");
        lastSup = t_sup;
        lastName = t_title;
        numberOfEdit = number;
        titleText.text = t_title;
        hrefFromImg = t_href;
        descriptText.text = t_desc;
        valueGoods = t_value;
        textSup.text = t_sup;
        textCat.text = t_cat;
    }

    function cleareAll() {
        textCat.text = "Выбери категорию"
        textSup.text = "Выбери поставщика"
        titleText.text = null;
        descriptText.text = null;
        hrefFromImg = "qrc:/Warehousing/Images/Pc.png";
        valueGoods = 0;
        createOrEditButton.textValue = "Создать";
        listSup.visible = false;
        listCat.visible = false;
    }
    function addSup(name = ""){
        listSup.model.append({supValue: name})
    }
    function delSup(number = 0){
        listSup.model.remove(number + 1)
    }
    function addCat(name = ""){
        listCat.model.append({catValue: name})
    }
    function delCat(number = 0){
        listCat.model.remove(number + 1)
    }
    anchors.fill: parent
    visible: false

    onVisibleChanged: {
        if (!visible) {
            cleareAll();
        }
    }

    Timer {
        property string action: '+'
        id: timer
        interval: 500
        repeat: true
        running: false
        onTriggered: {
            if (action === '-') {
                if (valueGoods !== 0) {
                    valueGoods--;
                }
            } else {
                valueGoods++;
            }
            if (interval !== 50) {
                interval -= 50;
            }
        }
    }
    FileDialog {
        id: fileDialog
        currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)
        nameFilters: ["Images (*.jpg *.png)"]
        title: "Выберите файл"
        onAccepted: {
            hrefFromImg = selectedFile;
        }
    }
    ColumnLayout {
        anchors.fill: parent
        id: mainArea
        Text {
            id: titlePage
            Layout.fillWidth: true
            font.bold: true
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            text: "Создание карточки"
            anchors {
                top: parent.top
            }
        }
        RowLayout {
            Layout.fillWidth: true
            anchors {
                bottom: parent.bottom
                top: titlePage.bottom
                horizontalCenter: titlePage.horizontalCenter
            }
            Rectangle {
                anchors.top: parent.top
                color: "#E9E9E9"
                height: 560
                width: 340
                MultiEffect {
                    source: parent
                    anchors.fill: parent
                    shadowColor: "#000000"
                    shadowEnabled: true
                    shadowBlur: 20
                    shadowVerticalOffset: 5
                    shadowHorizontalOffset: 10
                }
                Image {
                    id: imageGoods
                    fillMode: Image.Stretch
                    height: 320
                    smooth: true
                    source: hrefFromImg
                    sourceSize.width: imageGoods.height * 2
                    sourceSize.height: imageGoods.width * 2
                    anchors {
                        left: parent.left
                        right: parent.right
                        top: parent.top
                    }
                }
                CustomButton {
                    anchors.right: parent.right
                    anchors.top: parent.top
                    height: 25
                    textValue: "Выбор изображения"
                    width: 150
                    onClicked: {
                        fileDialog.open();
                    }
                }
                ColumnLayout {
                    anchors.bottom: buttonLayout.top
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: imageGoods.bottom
                    clip: true
                    spacing: -20

                    CustomTextArea {
                        id: titleText
                        Layout.leftMargin: 25
                        Layout.rightMargin: 25
                        font.bold: true
                        font.pixelSize: 18
                        maxCharacters: 28
                        width: parent.width - 50

                        anchors {
                            left: parent.left - 25
                            right: parent.right - 25
                        }
                    }
                    CustomTextArea {
                        id: descriptText

                        Layout.leftMargin: 25
                        Layout.rightMargin: 25
                        font.pixelSize: 16
                        height: 125
                        maxCharacters: 140
                        placeholderText: "Введите описание"
                        width: parent.width - 50

                        anchors {
                            left: parent.left - 25
                            right: parent.right - 25
                        }
                    }
                }
                RowLayout {
                    id: buttonLayout
                    anchors{
                        bottom: parent.bottom
                        left: parent.left
                        right: parent.right
                    }
                    height: 40
                    spacing: 0

                    CustomButton {
                        id: order
                        Layout.fillWidth: true
                        Layout.preferredWidth: parent.width * 0.3
                        height: parent.height
                        textValue: "Очистить"
                        onClicked: {
                            if(createOrEditButton.textValue === "Создать"){
                                cleareAll();
                            }
                            else{
                                cleareAll();
                                createOrEditButton.textValue = "Сохранить"
                            }

                        }
                    }
                    CustomButton {
                        Layout.fillWidth: true
                        Layout.preferredWidth: parent.width * 0.1
                        colorButton: "#9E9E9E"
                        colorText: "black"
                        fontSize: fontSize + 10
                        height: parent.height
                        textValue: "-"
                        onClicked: {
                            if (valueGoods !== 0) {
                                valueGoods--;
                            }
                        }
                        onPressed: {
                            timer.action = '-'
                            timer.running = true
                        }
                        onReleased: {
                            timer.running = false
                            timer.interval = 500;
                        }
                    }
                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredWidth: parent.width * 0.2
                        color: "#9E9E9E"
                        height: parent.height
                        Text {
                            anchors.top: parent.top
                            color: "#000000"
                            height: parent.height / 2
                            horizontalAlignment: Text.AlignHCenter
                            text: "Кол-во"
                            width: parent.width
                        }
                        Text {
                            anchors.bottom: parent.bottom
                            color: "#000000"
                            height: parent.height / 2
                            horizontalAlignment: Text.AlignHCenter
                            text: valueGoods
                            width: parent.width
                        }
                    }
                    CustomButton {
                        Layout.fillWidth: true
                        Layout.preferredWidth: parent.width * 0.1
                        colorButton: "#9E9E9E"
                        colorText: "black"
                        fontSize: fontSize + 10
                        height: parent.height
                        textValue: "+"

                        onClicked: {
                            valueGoods++;
                        }
                        onPressed: {
                            timer.action = '+'
                            timer.running = true
                        }
                        onReleased: {
                            timer.running = false
                            timer.interval = 500;
                        }
                    }
                    CustomButton {
                        id: createOrEditButton
                        Layout.fillWidth: true
                        Layout.preferredWidth: parent.width * 0.3
                        height: parent.height
                        textValue: "Создать"
                        onClicked: {
                            let cat = "None"
                            let sup = "None"
                            if(createOrEditButton.textValue === "Создать"){
                                if (titleText.text !== "" && descriptText.text !== "") {
                                    if(textSup.text !== "Выбери поставщика"){
                                        sup = textSup.text
                                    }
                                    if(textCat.text !== "Выбери категорию"){
                                        cat = textCat.text
                                    }
                                    goodsPage.createGoods(hrefFromImg, titleText.text, descriptText.text, valueGoods, sup, cat)
                                } else {
                                    appAnswer.message("Заполните все данные", true)
                                }
                            }else{
                                if (titleText.text !== "" && descriptText.text !== "") {
                                    if(textSup.text !== "Выбери поставщика"){
                                        sup = textSup.text
                                    }
                                    if(textCat.text !== "Выбери категорию"){
                                        cat = textCat.text
                                    }
                                    if(lastSup !== sup){
                                        suppliesPage.startDel(lastSup,lastName)
                                    }else{
                                        suppliesPage.editNameProduct(lastSup,lastName,titleText.text)
                                    }
                                    goodsPage.redactGoods(hrefFromImg, titleText.text, descriptText.text, valueGoods, sup, cat, numberOfEdit)
                                    mainWindow.undoText()
                                    cleareAll()
                                } else {
                                    appAnswer.message("Заполните все данные", true)
                                }
                            }
                        }
                    }
                }
            }
            RowLayout{
                id: dropDownLayout
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                Item{
                    width: 200
                    anchors{
                        top: parent.top
                        bottom: parent.bottom
                    }
                    ListView{
                        visible: false
                        id: listCat
                        width: mouseCat.width
                        anchors{
                            horizontalCenter: mouseCat.horizontalCenter
                            top: mouseCat.bottom
                            bottom: parent.bottom
                        }
                        delegate: Rectangle{
                            clip: true
                            border.width: 1
                            color: rectCat.color
                            width: 200
                            height: 50
                            Text{
                                id: nameCat
                                anchors{
                                    centerIn: parent
                                }
                                wrapMode: TextArea.Wrap
                                text: catValue
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    listCat.visible = false
                                    textCat.text = nameCat.text
                                }
                            }
                        }
                        model: ListModel{}
                        Component.onCompleted: {
                            addCat("None")
                        }
                    }
                    MouseArea{
                        id: mouseCat
                        width: 200
                        height: 50
                        Rectangle{
                            clip: true
                            id: rectCat
                            anchors.fill: parent
                            color: "#cfcfcf"
                            Text{
                                id: textCat
                                anchors.centerIn: parent
                                text: "Выбери категорию"
                            }
                        }
                        onClicked:{
                            listCat.visible = !listCat.visible
                        }
                    }
                }
                Item {
                    width: 200
                    anchors {
                        top: parent.top
                        bottom: parent.bottom
                    }
                    ListView{
                        visible: false
                        id: listSup
                        anchors{
                            horizontalCenter: mouseSup.horizontalCenter
                            top: mouseSup.bottom
                            left: mouseSup.left
                            bottom: parent.bottom
                        }
                        delegate: Rectangle{
                            clip: true
                            border.width: 1
                            color: rectSup.color
                            width: 200
                            height: 50
                            Text{
                                id: nameSup
                                anchors{
                                    centerIn: parent
                                }
                                wrapMode: TextArea.Wrap
                                text: supValue
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    listSup.visible = false
                                    textSup.text = nameSup.text
                                }
                            }
                        }
                        model: ListModel{}
                        Component.onCompleted: {
                            addSup("None")
                        }
                    }
                    MouseArea{
                        id: mouseSup
                        width: 200
                        height: 50
                        Rectangle{
                            clip: true
                            id: rectSup
                            anchors.fill: parent
                            color: "#cfcfcf"
                            Text{
                                id: textSup
                                anchors.centerIn: parent
                                text: "Выбери поставщика"
                            }
                        }
                        onClicked:{
                            listSup.visible = !listSup.visible
                        }
                    }
                }
            }
        }
    }
}