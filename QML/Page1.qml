import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page{
    function createGoods(path = "file:///C:\\Users\\Даниил\\Pictures\\300px-Маск_шаблон_1.jpg", title = "Title", descript = "Descript", newValue = 0){
        goods.model.append({
            myPath: path,
            myTitle: title,
            myDescript: descript,
            myValue: newValue
        });
    }

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
                anchors.topMargin: 10
                imageSource: myPath
                titleText: myTitle
                descriptionText: myDescript
                value: myValue
            }
            ScrollBar.vertical: ScrollBar { }
        }
    }
}