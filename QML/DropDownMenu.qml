import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle{
    color: "white"
    id:root
    function addElement(text = ""){
        dropDownList.model.append({valueDrop: text});
        let lastItem = dropDownList.model.get(dropDownList.model.count - 1);
        let lastItemHeight = lastItem.height;
        dropDownList.height += lastItemHeight;
    }
    function deleteElement(index){
        dropDownList.model.remove(index)
    }
    MouseArea{
        anchors.fill:parent
        onClicked:{
            if(dropDownList.visible === true){
                dropDownList.visible = false
            }else{
                dropDownList.visible = true
            }
        }
    }
    Text{
        clip: true
        id: rootText
        wrapMode: Text.Wrap
        width: parent.width
        height: parent.height
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: "Выберите элемент"
    }
    ListView {
        clip: true
        visible: false
        id: dropDownList
        width: root.width
        height: 1
        anchors{
            top: parent.bottom
            left: parent.left
        }
        delegate: Rectangle{
            border.width:1
            clip: true
            color: root.color
            width: root.width
            height: nameCategory.height
            anchors{
                left: dropDownList.left
            }
            Text{
                id: nameCategory
                width: parent.width
                anchors.centerIn: parent
                wrapMode: TextArea.Wrap
                text: valueDrop
                font.pixelSize: fontSize
            }
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    dropDownList.visible = false
                    rootText.text = nameCategory.text
                }
                onPressed: {
                    dropDownList.interactive = false
                }
                onReleased: {
                    dropDownList.interactive = true
                }
            }
        }
        model: ListModel {}
    }
}
