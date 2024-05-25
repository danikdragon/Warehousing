import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 2.15

Page {
    id: root

    Component {
        id: goodsListModelComponent
        ListModel {}
    }
    function editNameProduct(t_name = "", t_goodsName = "", new_name = ""){
        for (let i = 0; i < suppliesList.count; i++) {
            if (suppliesList.model.get(i).nameSup === t_name) {
                let goodsModel = suppliesList.model.get(i).goodsModel
                for (let j = 0; j < goodsModel.count; j++) {
                    if (goodsModel.get(j).nameGoods === t_goodsName) {
                        goodsModel.get(j).nameGoods = new_name
                        break
                    }
                }
                break
            }
        }
    }
    function addCel(t_name = "", t_number = "") {
        let newGoodsModel = goodsListModelComponent.createObject(root);
        suppliesList.model.append({nameSup: t_name, numberSup: t_number, goodsModel: newGoodsModel})
        myData.addSupplys(t_name,t_number)
    }
    function delCel(t_name = "") {
        for (let i = 0; i < suppliesList.count; i++) {
            if (suppliesList.model.get(i).nameSup === t_name) {
                suppliesList.model.remove(i)
                myData.removeSupply(t_name)
                break
            }
        }
    }
    function startDel(t_name = "", t_goodsName = "") {
        for (let i = 0; i < suppliesList.count; i++) {
            if (suppliesList.model.get(i).nameSup === t_name) {
                let goodsModel = suppliesList.model.get(i).goodsModel
                for (let j = 0; j < goodsModel.count; j++) {
                    if (goodsModel.get(j).nameGoods === t_goodsName) {
                        goodsModel.remove(j)
                        myData.removeProductSupply(t_name,t_goodsName)
                        break
                    }
                }
                break
            }
        }
    }
    function startAdd(t_name = "", t_goodsName = "") {
        let flagOnCreateDuplicate = false
        let flagOnSearch = false
        for (let i = 0; i < suppliesList.count; i++) {
            if (suppliesList.model.get(i).nameSup === t_name) {
                flagOnSearch = true;
                for (let j = 0; j < suppliesList.model.get(i).goodsModel.count; j++) {
                    if(suppliesList.model.get(i).goodsModel.get(j).nameGoods === t_goodsName){
                        myData.addSupply(t_name)
                        flagOnCreateDuplicate = true;
                        appAnswer.message("Карточка есть в таблице заказов", true)
                        break
                    }
                }
                if(!flagOnCreateDuplicate){
                    suppliesList.model.get(i).goodsModel.append({nameGoods: t_goodsName})
                    appAnswer.message("Карточка добавлена в таблицу заказов")
                }
                break
            }
        }
        if(!flagOnSearch){
            appAnswer.message("У этой карточки не существующий поставщик", true)
        }
    }

    RowLayout {
        anchors.fill: parent
        ListView {
            id: suppliesList
            anchors.fill: parent
            spacing: 10

            delegate: RowLayout {
                width: suppliesList.width
                height: 100
                ColumnLayout {
                    id: columSup
                    height: parent.height
                    width: parent.width / 2
                    spacing: 0

                    Rectangle {
                        clip: true
                        color: "transparent"
                        id: rectNameSup
                        width: parent.width
                        height: parent.height / 2
                        border.width: 1

                        Text {
                            text: nameSup
                            font.pixelSize: 14
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            padding: 10
                            anchors.fill: parent
                        }
                    }

                    Rectangle {
                        clip: true
                        color: "transparent"
                        id: rectNumberSup
                        width: parent.width
                        height: parent.height / 2
                        border.width: 1

                        Text {
                            text: numberSup
                            font.pixelSize: 14
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            padding: 10
                            anchors.fill: parent
                        }
                    }
                }
                ListView {
                    anchors {
                        left: columSup.right
                        right: parent.right
                    }
                    clip: true
                    spacing: 0
                    width: parent.width / 2
                    height: parent.height
                    id: goodsSup

                    delegate: RowLayout {
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
                        property int value: t_value
                        width: goodsSup.width
                        height: goodsSup.height / 2
                        Text {
                            id: nameGoodsId
                            text: nameGoods
                            font.pixelSize: 14
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignLeft
                            padding: 10
                            anchors.left: parent.left
                        }
                        RowLayout {
                            id: buttons
                            clip: true
                            spacing: 10
                            anchors.right: parent.right
                            CustomButton {
                                width: 40
                                height: 30
                                textValue: '-'
                                onClicked: {
                                    if (value !== 0)
                                        value--;
                                }
                                onPressed: {
                                    timer.action = textValue
                                    timer.running = true
                                    goodsSup.interactive = false
                                    suppliesList.interactive = false
                                }
                                onReleased: {
                                    timer.running = false
                                    timer.interval = 500;
                                    goodsSup.interactive = true
                                    suppliesList.interactive = true
                                }
                            }
                            Text {
                                width: 40
                                height: 30
                                font.pixelSize: 14
                                text: value
                            }
                            CustomButton {
                                width: 40
                                height: 30
                                textValue: '+'
                                onClicked: {
                                    value++;
                                }
                                onPressed: {
                                    timer.action = textValue
                                    timer.running = true
                                    goodsSup.interactive = false
                                    suppliesList.interactive = false
                                }
                                onReleased: {
                                    timer.running = false
                                    timer.interval = 500;
                                    goodsSup.interactive = true
                                    suppliesList.interactive = true
                                }
                            }
                        }
                        Rectangle {
                            width: 0
                            anchors.fill: parent
                            border.width: 1
                            color: "transparent"
                        }
                    }
                    model: goodsModel
                }
                Rectangle {
                    color: "transparent"
                    anchors.fill: parent
                    border.width: 1
                }
            }
            model: ListModel {}
        }
    }
}
