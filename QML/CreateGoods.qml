import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15
import Qt.labs.platform
import QtQuick.Dialogs
import QtQuick.Effects

Page {
    id: root
    property string hrefFromImg: "qrc:/Warehousing/Pc.png"
    property int valueGoods: 0

    function cleareAll() {
        titleText.text = null;
        descriptText.text = null;
        hrefFromImg = "qrc:/Warehousing/Pc.png";
        valueGoods = 0;
    }

    anchors.fill: parent
    visible: false

    onVisibleChanged: {
        if (!visible) {
            cleareAll();
        }
    }

    Timer {
        property string action : '+'
        id: timer
        interval: 500
        repeat: true
        running: false
        onTriggered: {
            if(action === '-'){
                if (valueGoods !== 0) {
                    valueGoods--;
                }
            } else{
                valueGoods++;
            }
            if (interval != 50){
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
            anchors.centerIn: parent

            Item {
                Rectangle {
                    anchors.centerIn: parent
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

                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        height: 40
                        spacing: 0

                        CustomButton {
                            id: order
                            Layout.fillWidth: true
                            Layout.preferredWidth: parent.width * 0.3
                            height: parent.height
                            textValue: "Очистить"

                            onClicked: {
                                cleareAll();
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
                            Layout.fillWidth: true
                            Layout.preferredWidth: parent.width * 0.3
                            height: parent.height
                            textValue: "Cоздать"

                            onClicked: {
                                goodsPage.createGoods(root.hrefFromImg, titleText.text, descriptText.text, root.valueGoods);
                            }
                        }
                    }
                }
            }
        }
    }
}