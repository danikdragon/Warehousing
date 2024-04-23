import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

Page {
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
                        var copyrate = false
                        for (var i = 0; i < supList.count; i++) {
                            if (nameTextArea.text === supList.model.get(i).name) {
                                copyrate = true
                                break
                            }
                        }
                        if (!copyrate) {
                            supList.model.append({
                                name: nameTextArea.text,
                                number: numberTextArea.text
                            });
                            nameTextArea.text = ""
                            numberTextArea.text = ""
                            appAnswer.message("Поле создано!")
                        } else {
                            appAnswer.message("Такой доставщик уже существует", true)
                        }
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
            delegate: RowLayout {
                width: supList.model.widht
                height: nameValue.height >= numberValue.height ? nameValue.height : numberValue.height
                Rectangle {
                    id: rectName
                    height: nameValue.height >= numberValue.height ? nameValue.height : numberValue.height
                    clip: true
                    width: nameTextArea.width
                    color: "#646464"
                    anchors {
                        left: page3.left
                    }
                    Text {
                        padding: 10
                        id: nameValue
                        color: "#E9E9E9"
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
                    color: "#969696"
                    anchors {
                        left: spacerRect.right
                    }
                    Text {
                        padding: 10
                        id: numberValue
                        font.pixelSize: fontSize
                        color: "black"
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
                        supList.model.remove(index);
                    }

                    onPressed: {
                        supList.interactive = false
                    }
                    onReleased: {
                        supList.interactive = true
                    }
                }
            }
            model: ListModel {
            }
        }
    }
}