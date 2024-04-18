import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page{
    function createGoods(path = "qrc:/Warehousing/Images/Pc.png", title = " ", descript = " ", newValue = 0){
        goods.model.append({
            myPath: path,
            myTitle: title,
            myDescript: descript,
            myValue: newValue
        });
        appAnswer.message("Карточка создана!")
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
            cellWidth: 340 + parent.width * 0.019
            cellHeight: 580
            flow: GridView.FlowLeftToRight
            anchors{
                topMargin: 10
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }
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
            ScrollBar.vertical: ScrollBar {
                snapMode : ScrollBar.NoSnap
            }
        }
    }
}