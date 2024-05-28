import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects
Page {
    id: root
    function clear(){
        while(catList.count > 0){
            catList.model.remove(0);
        }
    }
    function createCat(c_name = "", load = false){
        if (c_name !== "") {
            var copyrate = false
            for (var i = 0; i < catList.count; i++) {
                if (c_name === catList.model.get(i).name) {
                    copyrate = true
                    break
                }
            }
            if (!copyrate) {
                if(!load){
                    myData.addCategory(c_name);
                }
                createGoodsPage.addCat(c_name)
                catList.model.append({
                    name: c_name,
                    fontColor: catList.count % 2 === 0 ? "black" : "#E9E9E9",
                    rectColor: catList.count % 2 === 0 ? "#969696" : "#646464",
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
                font.pixelSize: 16
                Layout.fillWidth: true
                placeholderText: "Впишите категорию"
            }
            CustomButton {
                Layout.fillWidth: true
                textValue: "Cоздать"
                id: createButton
                onClicked: {
                    createCat(nameCategori.text);
                }
            }
        }
        MultiEffect {
            anchors.fill: catList
            source: catList
            //paddingRect: Qt.rect(20, 20, 40, 30)
            shadowEnabled: true
            shadowColor: "#90000000"
            shadowVerticalOffset: 4
            shadowHorizontalOffset: 4
            shadowBlur: 0.5
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
            delegate: Rectangle {
                id: rectName
                height: nameValue.height
                width: nameCategori.width
                color: rectColor
                anchors {
                    left: catList.left
                }
                Text {
                    padding: 10
                    id: nameValue
                    color: fontColor
                    text: name
                    font.pixelSize: 16
                    wrapMode: TextArea.Wrap
                    width: parent.width
                }
                CustomButton {
                    id: deleteButton
                    textValue: "Удалить"
                    width: createButton.width
                    height: nameValue.height
                    anchors {
                        leftMargin: 5
                        left: rectName.right
                    }
                    onClicked: {
                        appAnswer.message("Удалено!")
                        createGoodsPage.delCat(index)
                        myData.removeCategory(name)
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
