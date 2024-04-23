import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Page {
    id: root
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
            text: "Категории"
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
                id: nameCategori
                font.pixelSize: fontSize
                Layout.fillWidth: true
                placeholderText: "Впишите категорию"
            }

            CustomButton {
                Layout.fillWidth: true
                textValue: "Cоздать"
                id: createButton
                onClicked: {
                    if (nameCategori.text !== "") {
                        var copyrate = false
                        for (var i = 0; i < catList.count; i++) {
                            if (nameCategori.text === catList.model.get(i).name) {
                                copyrate = true
                                break
                            }
                        }
                        if (!copyrate) {
                            catList.model.append({
                                name: nameCategori.text,
                            });
                            nameCategori.text = ""
                            appAnswer.message("Поле создано!")
                        } else {
                            appAnswer.message("Такая категория уже существует", true)
                        }
                    } else {
                        appAnswer.message("Заполните все поля", true)
                    }
                }
            }
        }
        ListView {
            id:catList
            clip: true
            Layout.fillWidth: true
            spacing: 10
            anchors {
                topMargin: 10
                right: parent.right
                top: createButtons.bottom
                bottom: parent.bottom
            }
            delegate: RowLayout {
                width: catList.model.widht
                Rectangle {
                    id: rectName
                    height: nameValue.height
                    clip: true
                    width: nameCategori.width
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

                CustomButton {
                    Layout.fillWidth: true
                    textValue: "Удалить"
                    width: createButton.width
                    height: nameValue.height
                    anchors {
                        leftMargin: 5
                        left: rectNumber.right
                    }
                    onClicked: {
                        appAnswer.message("Удалено!")
                        catList.model.remove(index);
                    }
                    onPressed: {
                        catList.interactive = false
                    }
                    onReleased: {
                        catList.interactive = true
                    }
                }
            }
            model: ListModel {
            }
        }
    }
}