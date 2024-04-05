import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Window {
    width: 1400
    height: 680
    minimumWidth: 910
    minimumHeight: 580
    visible: true
    title: "Warehousing"

    StackView{
        id: sv
        anchors.fill: parent
        initialItem: page1
    }
    Page1{
        id: page1
    }

}
// Goods{
//     onOrdering: {
//         sv.push(page2);
//     }
//     anchors.centerIn: parent
// }