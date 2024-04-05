import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item{
    readonly property color blackButton: "#000000"
    readonly property color whiteButton: "#9E9E9E"
    readonly property color blackText: "#000000"
    readonly property color whiteText: "#E9E9E9"
    property string imageSource: "B:\\c++\\MyProject\\Warehousing\\Pc.png"
    property string titleText: "Игровой компьютер 1"
    property string descriptionText: "Видеокарта: RTX 4090ti gigabyte\n"+
                                        "Процессор: intel core i9 10500\n"+
                                        "ОЗУ: 16gb ddr5\n"+
                                        "Блок питнания: AeroCool 1000wt\n"+
                                        "Память: m2me 1000gb, ssd 4tb"
    property int value: 0

    signal ordering()

    width: 340
    height: 560

    Rectangle{
        anchors.fill: parent
        color: "#E9E9E9"
        Image{
            id: imageGoods
            source: "file:///" + imageSource
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
            textValue: "Удалить"
            onClicked: {
                delete root;
            }
        }
        ColumnLayout{
            clip: true
            spacing: -20
            anchors.top: imageGoods.bottom
            anchors.bottom: buttonLayout.top
            anchors.left: parent.left
            anchors.right: parent.right

            Text{
                anchors.left: parent.left-25
                anchors.right: parent.right-25
                Layout.leftMargin: 25
                Layout.rightMargin: 25
                font.bold: true
                text: titleText
                font.pixelSize: 18
            }
            Text{
                anchors.left: parent.left-25
                anchors.right: parent.right-25
                Layout.leftMargin: 25
                Layout.rightMargin: 25
                text: descriptionText
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
                textValue: "Заказать"
                onClicked:{
                    ordering();
                }
            }
            CustomButton {
                id: minus
                colorButton: whiteButton
                colorText: blackText
                height: parent.height
                Layout.fillWidth: true
                Layout.preferredWidth: parent.width * 0.1
                textValue: "-"
                fontSize: fontSize + 10
                onClicked: {
                    if(value != 0)
                        value--;
                }
            }
            Rectangle {
                height: parent.height
                Layout.fillWidth: true
                color: whiteButton
                Layout.preferredWidth: parent.width * 0.2
                Text{
                    id: uperValue
                    anchors.top: parent.top
                    text:"Кол-во"
                    color: blackText
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                    height: parent.height/2
                }
                Text{
                    id: valueText
                    anchors.bottom: parent.bottom
                    text: value
                    color: blackText
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                    height: parent.height/2
                }
            }
            CustomButton {
                Layout.preferredWidth: parent.width * 0.1
                id: plus
                colorButton: whiteButton
                colorText: blackText
                height: parent.height
                Layout.fillWidth: true
                textValue: "+"
                fontSize: fontSize + 10
                onClicked: {
                    value++;
                }
            }
            CustomButton {
                Layout.preferredWidth: parent.width * 0.3
                id: edit
                height: parent.height
                Layout.fillWidth: true
                textValue: "Редактировать"
            }
        }
    }
}