import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

Page{
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
                snapMode : ScrollBar.NoSnap
            }
        }
    }
}