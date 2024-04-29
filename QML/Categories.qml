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
            DropDownMenu{
                id: dropDown
                height: 50
                width: 120
                Layout.fillWidth: true
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
                                fontColor: catList.count % 2 === 0 ? "black" : "#E9E9E9",
                                rectColor: catList.count % 2 === 0 ? "#969696" : "#646464",
                            });
                            dropDown.addElement(nameCategori.text)
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
            z: 99
        }
        ListView {
            z : 1
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
                    color: rectColor
                    anchors {
                        left: page3.left
                    }
                    Text {
                        padding: 10
                        id: nameValue
                        color: fontColor
                        text: name
                        font.pixelSize: fontSize
                        wrapMode: TextArea.Wrap
                        width: parent.width
                    }
                }
                CustomButton {
                    textValue: "Удалить"
                    width: createButton.width
                    height: nameValue.height
                    anchors {
                        leftMargin: 5
                        right: page3.right
                    }
                    onClicked: {
                        appAnswer.message("Удалено!")
                        dropDown.deleteElement(index)
                        catList.model.remove(index);
                        for (let i = 0; i < catList.count; i++) {
                            catList.model.get(i).fontColor = i % 2 === 0 ? "black" : "#E9E9E9"
                            catList.model.get(i).rectColor = i % 2 === 0 ? "#969696" : "#646464"
                        }
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