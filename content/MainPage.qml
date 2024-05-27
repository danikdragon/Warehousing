import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Page {
    function sorting(){
        let flag = false
        for(let i = sortGoods.count; i >= 0; i--){
            sortGoods.model.remove(i)
        }
        for(let j = 0; j < goods.count; j++){
            if( goods.model.get(j).myTitle === searchText.text ||
                goods.model.get(j).myDescript === searchText.text ||
                goods.model.get(j).supValue === searchText.text ||
                goods.model.get(j).catValue === searchText.text){
                sortGoods.model.append(goods.model.get(j))
                flag = true
            }
        }
        if(flag === false){
            goods.visible = true
            sortGoods.visible = false
        }else{
            goods.visible = false
            sortGoods.visible = true
        }
    }
    function createGoods(path = "qrc:/Warehousing/Images/Pc.png", title = " ", descript = " ", newValue = 0, sup = "None", cat = "None", load = false) {
        appAnswer.message("Товар создан")
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
                catValue: cat,
            });
            if(!load){
                myData.addProduct(title, descriptText, href, value, sup, cat)
            }
            appAnswer.message("Карточка создана!")
            createGoodsPage.cleareAll()
        } else
            appAnswer.message("Такая карточка уже существует!", true);
    }
    function redactGoods(path = "qrc:/Warehousing/Images/Pc.png", title = " ", descript = " ", newValue = 0, sup = "None", cat = "None", number = 0){
        goods.model.get(number).myPath = path;
        goods.model.get(number).myTitle = title;
        goods.model.get(number).myDescript = descript;
        goods.model.get(number).myValue = newValue;
        goods.model.get(number).supValue = sup;
        goods.model.get(number).catValue = cat;
        //код сохранения в бд
    }
    RowLayout {
        anchors.fill: parent
        Item {
            Layout.preferredWidth: goods.width * 0.019
        }
        GridGoods{
            id: goods
            visible: true
        }
        GridGoods{
            id: sortGoods
            visible: false
        }
    }
}
