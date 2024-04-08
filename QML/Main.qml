import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

Window {
    height: 680
    minimumHeight: 580
    minimumWidth: 920
    title: "Warehousing"
    visible: true
    width: 1400

    RowLayout{
        anchors.fill: parent
        Rectangle{
            id: buttons
            Layout.preferredWidth: parent.width * 0.2
            Layout.fillWidth: true

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            // color: "#DDDDDD"
            color: "#c8c8c8"

            ColumnLayout{
                spacing: 10
                anchors.fill: parent
                Rectangle {
                    color: "transparent"
                }
                MenuButton{
                    textValue: "Создать товар"
                    onClicked: {
                        if(textValue === "Создать товар"){
                            sv.push(page2);
                            textValue = "Назад";
                        }else{
                            sv.pop();
                            textValue = "Создать товар";
                        }
                    }
                }
                MenuButton{
                    textValue: "Создать новую таблицу"
                    onClicked: {
                        page1.createGoods();
                    }
                }
                MenuButton{
                    textValue: "Открыть таблицу"
                }
                MenuButton{
                    textValue: "Поставки"
                }
                MenuButton{
                    textValue: "Поставщики"
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

            initialItem: page1
        }
    }

    Page1 {
        id: page1
        anchors.fill: parent
        visible: false
    }
    Page {
        id: page2

        anchors.fill: parent
        visible: false

        ColumnLayout {
            anchors.fill: parent
            spacing: 20
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
            Item{
                Layout.fillWidth: true
                anchors.top: titlePage.buttom

                Rectangle{
                    anchors.top: parent.top
                    anchors.centerIn: parent
                    width: 340
                    height: 560
                    color: "#E9E9E9"
                    Image{
                        id: imageGoods
                        source: "file:///B:\\c++\\MyProject\\Warehousing\\Pc.png"
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.horizontalCenter
                        fillMode: Image.PreserveAspectFit
                        smooth: true
                    }
                    CustomButton {
                        anchors.right: parent.right
                        anchors.top: parent.top
                        width: 60
                        height: 25
                    }
                    ColumnLayout{
                        clip: true
                        spacing: -20
                        anchors.top: imageGoods.bottom
                        anchors.bottom: buttonLayout.top
                        anchors.left: parent.left
                        anchors.right: parent.right

                        CustomTextArea{
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
                            id: order
                            height: parent.height
                            Layout.fillWidth: true
                            Layout.preferredWidth: parent.width * 0.3
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
                                anchors.top: parent.top
                                color: "#000000"
                                horizontalAlignment: Text.AlignHCenter
                                width: parent.width
                                height: parent.height/2
                            }
                            Text{
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
                            Layout.preferredWidth: parent.width * 0.3
                            height: parent.height
                            Layout.fillWidth: true
                        }
                    }
                }
            }
        }
    }
}