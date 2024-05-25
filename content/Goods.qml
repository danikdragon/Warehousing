import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: root
    width: 340
    height: 560
    anchors {
        topMargin: 20
    }

    readonly property color blackButton: "#000000"
    readonly property color whiteButton: "#9E9E9E"
    readonly property color blackText: "#000000"
    readonly property color whiteText: "#E9E9E9"
    property string imageSource: "qrc:/qt/qml/content/image/Pc.png"
    property string titleText: "Игровой компьютер 1"
    property string descriptionText: "Видеокарта: RTX 4090ti gigabyte\n" +
                                     "Процессор: intel core i9 10500\n" +
                                     "ОЗУ: 16gb ddr5\n" +
                                     "Блок питнания: AeroCool 1000wt\n" +
                                     "Память: m2me 1000gb, ssd 4tb"
    property int value: 0
    property string nameSupplier: ""
    property string nameCategory: ""

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
    Rectangle {
        anchors.fill: parent
        color: "#E9E9E9"
        Image {
            id: imageGoods
            height: 320
            source: imageSource
            sourceSize.width: imageGoods.height * 2
            sourceSize.height: imageGoods.width * 2
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                bottom: parent.horizontalCenter
            }
            fillMode: Image.Stretch
            smooth: true
        }
        CustomButton {
            anchors.right: parent.right
            anchors.top: parent.top
            width: 60
            height: 25
            textValue: "Удалить"
            onClicked: {
                appAnswer.message("Удалено!")
                suppliesPage.startDel(nameSupplier,titleText)
                myData.removeProduct(nameSupplier,titleText)
                goods.model.remove(index);
                root.visible = false;
                root.destroy();
                root.visible = true;
            }
        }
        ColumnLayout {
            clip: true
            spacing: -20
            anchors.top: imageGoods.bottom
            anchors.bottom: buttonLayout.top
            anchors.left: parent.left
            anchors.right: parent.right

            Text {
                id: titleId
                wrapMode: Text.Wrap
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: 25
                    rightMargin: 25
                }
                font.bold: true
                text: titleText
                font.pixelSize: 18
            }
            Text {
                wrapMode: Text.Wrap
                anchors {
                    left: parent.left
                    right: parent.right
                    leftMargin: 25
                    rightMargin: 25
                    top: titleId.bottom
                    topMargin: 10
                }
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
                onClicked: {
                    suppliesPage.startAdd(nameSupplier , titleText)
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
                    if (value !== 0)
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
            Rectangle {
                height: parent.height
                Layout.fillWidth: true
                color: whiteButton
                Layout.preferredWidth: parent.width * 0.2
                Text {
                    id: uperValue
                    anchors.top: parent.top
                    text: "Кол-во"
                    color: blackText
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                    height: parent.height / 2
                }
                Text {
                    id: valueText
                    anchors.bottom: parent.bottom
                    text: value
                    color: blackText
                    horizontalAlignment: Text.AlignHCenter
                    width: parent.width
                    height: parent.height / 2
                }
            }
            CustomButton {
                Layout.preferredWidth: parent.width * 0.1
                id: plus
                colorButton: whiteButton
                colorText: blackText
                height: parent.height
                Layout.fillWidth: true
                textValue: '+'
                fontSize: fontSize + 10
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
            CustomButton {
                Layout.preferredWidth: parent.width * 0.3
                id: edit
                height: parent.height
                Layout.fillWidth: true
                textValue: "Редактировать"
                onClicked:{
                    sv.push(createGoodsPage);
                    createId.textValue = "Назад";
                    for(let i = 0; i < goods.count; i++){
                        if(goods.model.get(i).myTitle === titleId.text)
                        {
                            createGoodsPage.onRedact(i, goods.model.get(i).myTitle,
                                goods.model.get(i).myPath,
                                goods.model.get(i).myDescript,
                                goods.model.get(i).myValue,
                                goods.model.get(i).supValue,
                                goods.model.get(i).catValue
                            );
                        }
                    }
                }
            }
        }
    }
}
