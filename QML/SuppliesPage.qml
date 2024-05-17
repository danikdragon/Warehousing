import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

Page {
    id:root
    RowLayout {
        anchors.fill: parent
        ListView{
            id: suppliesList
            anchors.fill: parent
            spacing: 10
            delegate:RowLayout{
                width: suppliesList.width
                height: 100
                ColumnLayout {
                    id: columSup
                    height: parent.height
                    width: parent.width / 2
                    spacing: 0
                    Rectangle {
                        clip: true
                        color:"transparent"
                        id: rectNameSup
                        width: parent.width
                        height: parent.height / 2
                        border.width: 1
                        Text {
                            text: nameSup
                            font.pixelSize: 14
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLef
                            padding: 10
                            anchors {
                                fill: parent
                            }
                        }
                    }
                    Rectangle {
                        clip: true
                        color:"transparent"
                        id: rectNumberSup
                        width: parent.width
                        height: parent.height / 2
                        border.width: 1
                        Text {
                            text: numberSup
                            font.pixelSize: 14
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLef
                            padding: 10
                            anchors {
                                fill: parent
                            }
                        }
                    }
                }
                ListView{
                    anchors{
                        left: columSup.right
                        right: goodsSup.right
                    }
                    clip: true
                    spacing: 0
                    width: parent.width / 2
                    height: parent.height
                    id: goodsSup
                    delegate: RowLayout{
                        property int value: 0
                        Timer {
                            property string action: '+'
                            id: timer
                            interval: 500
                            repeat: true
                            running: false
                            onTriggered: {
                                if (action === '-') {
                                    if (value !== 0) {
                                        value--;
                                    }
                                } else {
                                    value++;
                                }
                                if (interval !== 50) {
                                    interval -= 50;
                                }
                            }
                        }
                        width: goodsSup.width
                        height: goodsSup.height / 2
                        Text{
                            Layout.fillWidth: true
                            Layout.preferredWidth: parent.width * 0.8
                            id: nameGoodsId
                            text: nameGoods
                            font.pixelSize: 14
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLef
                            padding: 10
                            anchors {
                                left: parent.left
                                //right: buttons.left
                            }
                        }
                        RowLayout{
                            id: buttons
                            clip:true
                            spacing: 10
                            anchors{
                                //left: nameGoodsId.right
                                right: parent.right
                            }
                            CustomButton{
                                width: 40
                                height: 30
                                textValue: '-'
                                onClicked: {
                                    if(value !== 0)
                                        value--;
                                }
                                onPressed: {
                                    timer.action = textValue
                                    timer.running = true
                                }
                                onReleased: {
                                    timer.running = false
                                    timer.interval = 500;
                                }
                            }
                            Text{
                                width: 40
                                height: 30
                                font.pixelSize: 14
                                text: value
                            }
                            CustomButton{
                                width:40
                                height: 30
                                textValue: '+'
                                onClicked: {
                                    value++;
                                }
                                onPressed: {
                                    timer.action = textValue
                                    timer.running = true
                                }
                                onReleased: {
                                    timer.running = false
                                    timer.interval = 500;
                                }
                            }
                        }
                        Rectangle{
                            anchors.fill:parent
                            border.width:1
                            color:"transparent"
                        }
                    }
                    model:ListModel{}
                    Component.onCompleted: {
                        goodsSup.model.append({nameGoods: "NameGoods"})
                        goodsSup.model.append({nameGoods: "NameGoods"})
                    }
                }
                Rectangle{
                    color: "transparent"
                    anchors.fill: parent
                    border.width:1
                }
            }
            model:ListModel{}
            Component.onCompleted: {
                suppliesList.model.append({nameSup: "nameSup" ,numberSup: "numberSup"})
                suppliesList.model.append({nameSup: "nameSup" ,numberSup: "numberSup"})
            }
        }
    }
}