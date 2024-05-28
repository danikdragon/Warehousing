import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

Page {
    function clear(){
        while(supList.count > 0){
            supList.model.remove(0);
        }
    }
    function addSuplier(name = "", number = "", load = false){
        var copyrate = false
        for (var i = 0; i < supList.count; i++) {
            if (name === supList.model.get(i).name) {
                copyrate = true
                break
            }
        }
        if (!copyrate) {
            createGoodsPage.addSup(name)
            suppliesPage.addCel(name, number, load)
            if(!load){
                myData.addSupplier(name, number)
            }
            supList.model.append({
                name: name,
                number: number,
                fontColorName: supList.count % 2 === 0 ? "black" : "#E9E9E9",
                rectColorName: supList.count % 2 === 0 ? "#969696" : "#646464",
                fontColorNumber: supList.count % 2 === 0 ? "#E9E9E9" :"black",
                rectColorNumber: supList.count % 2 === 0 ? "#646464" : "#969696",
            });
            appAnswer.message("Поле создано!")
            nameTextArea.text = ""
            numberTextArea.text = ""
        } else {
            appAnswer.message("Такой доставщик уже существует", true)
        }
    }
    property int fontSize: 16
    ColumnLayout {
        anchors {
            fill: parent
            leftMargin: 10
            rightMargin: 10
        }
        Text {
            id: titlePage
            font.bold: true
            font.pixelSize: 40
            horizontalAlignment: Text.AlignHCenter
            text: "Поставщики"
            anchors {
                top: parent.top
                horizontalCenter: parent.horizontalCenter
            }
        }
        RowLayout {
            id: createButtons
            anchors {
                top: titlePage.bottom
            }
            CustomTextArea {
                id: nameTextArea
                font.pixelSize: fontSize
                Layout.fillWidth: true
                placeholderText: "Впишите имя"
            }
            CustomTextArea {
                id: numberTextArea
                font.pixelSize: fontSize
                Layout.fillWidth: true
                placeholderText: "Впишите номер/Данные/Контакты/Адрес"
            }
            CustomButton {
                Layout.fillWidth: true
                textValue: "Cоздать"
                id: createButton
                onClicked: {
                    if (nameTextArea.text !== "" && numberTextArea.text !== "") {
                        addSuplier(nameTextArea.text,numberTextArea.text)
                    } else {
                        appAnswer.message("Заполните все поля", true)
                    }
                }
            }
        }
        ListView {
            clip: true
            id: supList
            Layout.fillWidth: true
            spacing: 10
            anchors {
                topMargin: 10
                right: parent.right
                top: createButtons.bottom
                bottom: parent.bottom
            }
            model: ListModel {}
            delegate: RowLayout {
                width: supList.model.widht
                height: nameValue.height >= numberValue.height ? nameValue.height : numberValue.height
                Rectangle {
                    id: rectName
                    height: nameValue.height >= numberValue.height ? nameValue.height : numberValue.height
                    clip: true
                    width: nameTextArea.width
                    color: rectColorName
                    anchors {
                        left: page3.left
                    }
                    Text {
                        padding: 10
                        id: nameValue
                        color: fontColorName
                        text: name
                        font.pixelSize: fontSize
                        wrapMode: TextArea.Wrap
                        width: parent.width
                    }
                }
                Rectangle {
                    id: spacerRect
                    width: 5
                    anchors.left: rectName.right
                }
                Rectangle {
                    clip: true
                    height: nameValue.height >= numberValue.height ? nameValue.height : numberValue.height
                    id: rectNumber
                    width: numberTextArea.width
                    color: rectColorNumber
                    anchors {
                        left: spacerRect.right
                    }
                    Text {
                        padding: 10
                        id: numberValue
                        font.pixelSize: fontSize
                        color: fontColorNumber
                        text: number
                        wrapMode: TextArea.Wrap
                        width: parent.width
                    }
                }
                CustomButton {
                    Layout.fillWidth: true
                    textValue: "Удалить"
                    width: createButton.width
                    height: nameValue.height >= numberValue.height ? nameValue.height : numberValue.height
                    anchors {
                        leftMargin: 5
                        left: rectNumber.right
                    }
                    onClicked: {
                        appAnswer.message("Удалено!")
                        myData.removeSupplier(name)
                        suppliesPage.delCel(name)
                        createGoodsPage.delSup(index)
                        supList.model.remove(index);
                        for (let i = 0; i < supList.count; i++) {
                            supList.model.get(i).fontColorName = i % 2 === 0 ? "black" : "#E9E9E9"
                            supList.model.get(i).rectColorName = i % 2 === 0 ? "#969696" : "#646464"
                            supList.model.get(i).fontColorNumber = i % 2 === 0 ? "#E9E9E9" :"black"
                            supList.model.get(i).rectColorNumber = i % 2 === 0 ? "#646464" : "#969696"
                        }
                    }

                    onPressed: {
                        supList.interactive = false
                    }
                    onReleased: {
                        supList.interactive = true
                    }
                }
            }
        }
    }
}
