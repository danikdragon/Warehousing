import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page{
    function createGoods(path = "B:\\c++\\MyProject\\Warehousing\\Pc.png", title = "title", descript = "descript", newValue){
        goods.model.append({
            myPath: path,
            myTitle: title,
            myDescript: descript,
            myValue: newValue
        });
    }

    id: page1
    RowLayout{
        anchors.fill: parent
        Item{
            Layout.preferredWidth: goods.width * 0.019
        }
        GridView {
            id: goods
            Layout.preferredWidth: parent.width * 0.8
            Layout.fillWidth: true
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            cellWidth: 340 + parent.width * 0.019
            cellHeight: 580
            flow: GridView.FlowLeftToRight

            model: ListModel {
                id: myModel
            }
            delegate: Goods {
                imageSource: myPath
                titleText: myTitle
                descriptionText: myDescript
                value: myValue
            }
            ScrollBar.vertical: ScrollBar { }
        }
    }
}