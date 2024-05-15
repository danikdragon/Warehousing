import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    function createGoods(path = "qrc:/Warehousing/Images/Pc.png", title = " ", descript = " ", newValue = 0, sup = "None", cat = "None") {
        let copyrate = false
        for (let i = 0; i < goods.count; i++) {
            if (title === goods.model.get(i).myTitle) {
                copyrate = true
                break
            }
        }
        if (!copyrate) {
            goods.model.append({
                myPath: path,
                myTitle: title,
                myDescript: descript,
                myValue: newValue,
                supValue: sup,
                catValu: cat,
            });
            //код сохранения в бд
            appAnswer.message("Карточка создана!")
            createGoodsPage.cleareAll()
        } else
            appAnswer.message("Такая карточка уже существует!", true);
    }
    RowLayout {
        anchors.fill: parent
        Item {
            Layout.preferredWidth: goods.width * 0.019
        }
        GridView {
            id: goods
            Layout.preferredWidth: parent.width * 0.8
            Layout.fillWidth: true
            cellWidth: 340 + parent.width * 0.019
            cellHeight: 580
            flow: GridView.FlowLeftToRight
            anchors {
                topMargin: 10
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }
            delegate: Goods {
                anchors.topMargin: 10
                imageSource: myPath
                titleText: myTitle
                descriptionText: myDescript
                value: myValue
                nameSupplier: supValue
                nameCategory: catValue
            }
            ScrollBar.vertical: ScrollBar {
                snapMode: ScrollBar.NoSnap
            }
            model: ListModel {
            }
        }
    }
}