import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import Qt.labs.platform
import QtQuick.Dialogs

Page {
    property string hrefFromImg : "file:///B:\\c++\\MyProject\\Warehousing\\Pc.png"
    property int valueGoods : 0
    anchors.fill: parent
    visible: false
    function cleareAll(){
        titleText.text = null;
        descriptText.text = null;
        hrefFromImg = "file:///B:\\c++\\MyProject\\Warehousing\\Pc.png";
        valueGoods = 0;
    }
    onVisibleChanged:{
        if(!visible){
            cleareAll();
        }
    }
    FileDialog {
        id: fileDialog
        title: "Выберите файл"
        currentFolder: StandardPaths.standardLocations(StandardPaths.PicturesLocation)
        nameFilters: [ "Images (*.jpg *.png)"]
        onAccepted: {
            hrefFromImg = selectedFile;
        }
    }
    ColumnLayout {
        anchors.fill: parent
        Text{
            id: titlePage
            Layout.fillWidth: true
            anchors{
                top : parent.top
            }
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 40
            font.bold: true
            text : "Создание товара"
        }
        RowLayout{
            Layout.fillWidth: true
            anchors.centerIn: parent
            Item{
                Rectangle{
                    anchors.top: parent.top
                    anchors.centerIn: parent
                    width: 340
                    height: 560
                    color: "#E9E9E9"
                    Image{
                        height: 320
                        id: imageGoods
                        anchors{
                            left: parent.left
                            right: parent.right
                            top: parent.top
                        }
                        source: hrefFromImg
                        fillMode: Image.Stretch
                        smooth: true
                    }
                    CustomButton {
                        textValue: "Выбрать изображение"
                        anchors.right: parent.right
                        anchors.top: parent.top
                        width: 150
                        height: 25
                        onClicked: {
                            fileDialog.open();
                            console.log("Otril");
                        }
                    }
                    ColumnLayout{
                        clip: true
                        spacing: -20
                        anchors.top: imageGoods.bottom
                        anchors.bottom: buttonLayout.top
                        anchors.left: parent.left
                        anchors.right: parent.right

                        CustomTextArea{
                            id: titleText
                            maxCharacters:28
                            width: parent.width - 50
                            anchors{
                                left: parent.left-25
                                right: parent.right-25
                            }
                            Layout.leftMargin: 25
                            Layout.rightMargin: 25
                            font.bold: true
                            font.pixelSize: 18
                        }
                        CustomTextArea{
                            id: descriptText
                            placeholderText: "Впишите описание"
                            maxCharacters: 140
                            width: parent.width - 50
                            height: 125
                            anchors{
                                left: parent.left-25
                                right: parent.right-25
                            }
                            Layout.leftMargin: 25
                            Layout.rightMargin: 25
                            font.pixelSize: 16
                        }
                    }
                    RowLayout {
                        id: buttonLayout
                        spacing: 0
                        height: 40
                        anchors.bottom: parent.bottom
                        anchors.right: parent.right
                        anchors.left: parent.left

                        CustomButton {
                            textValue: "Очистить"
                            id: order
                            height: parent.height
                            Layout.fillWidth: true
                            Layout.preferredWidth: parent.width * 0.3
                            onClicked:{
                                cleareAll();
                            }
                        }
                        CustomButton {
                            colorButton: "#9E9E9E"
                            height: parent.height
                            Layout.fillWidth: true
                            Layout.preferredWidth: parent.width * 0.1
                        }
                        Rectangle {
                            height: parent.height
                            Layout.fillWidth: true
                            color: "#9E9E9E"
                            Layout.preferredWidth: parent.width * 0.2
                            Text{
                                text: "Кол-во"
                                anchors.top: parent.top
                                color: "#000000"
                                horizontalAlignment: Text.AlignHCenter
                                width: parent.width
                                height: parent.height/2
                            }
                            Text{
                                text: valueGoods
                                anchors.bottom: parent.bottom
                                color: "#000000"
                                horizontalAlignment: Text.AlignHCenter
                                width: parent.width
                                height: parent.height/2
                            }
                        }
                        CustomButton {
                            Layout.preferredWidth: parent.width * 0.1
                            colorButton: "#9E9E9E"
                            height: parent.height
                            Layout.fillWidth: true
                        }
                        CustomButton {
                            textValue: "Создать"
                            Layout.preferredWidth: parent.width * 0.3
                            height: parent.height
                            Layout.fillWidth: true
                            onClicked: {
                                page1.createGoods(hrefFromImg, titleText.text , descriptText.text ,valueGoods);
                            }
                        }
                    }
                }
            }
        }

    }
}