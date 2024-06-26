import QtQuick
import content
import QtQuick.Controls
import QtQuick.Layouts
import Qt.labs.platform
import QtQuick.Dialogs
import QtQuick.Effects

Window {
    height: 680
    minimumHeight: 580
    minimumWidth: 920
    title: "Warehousing"
    visible: true
    width: 1400
    property string curentOpenFile: myData.getPath()
    id: mainWindow
    function undoText() {
        sv.pop();
        createId.textValue = "Создать товар";
        suppliersId.textValue = "Поставщики";
        categoriesButton.textValue = "Категории товаров";
        suppliesId.textValue = "Поставки";
    }
    Item {
        id: hotKeyEscape
        focus: true
        Keys.onEscapePressed:{
            undoText()
        }
    }
    Rectangle {
        opacity : 1
        anchors.fill: parent
        color: "#c8c8c8"
    }
    RowLayout {
        id: rootRowMenu
        anchors.fill: parent
        MultiEffect {
            anchors.fill: buttons
            source: buttons
            //paddingRect: Qt.rect(20, 20, 40, 30)
            shadowEnabled: true
            shadowColor: "#90000000"
            shadowVerticalOffset: 4
            shadowHorizontalOffset: 4
            shadowBlur: 0.5
        }
        Rectangle {
            // color: "#DDDDDD"
            // color: "#c8c8c8"
            color: "transparent"
            id: buttons
            Layout.preferredWidth: (parent.width * 0.2)
            Layout.fillWidth: true
            anchors {
                left: parent.left
                top: parent.top
                bottom: parent.bottom
                leftMargin: 2.5
            }
            ColumnLayout {
                id: columMenuButtons
                spacing: 10
                anchors.fill: parent
                Rectangle {
                    color: "transparent"
                }

                CustomTextArea{
                    id: searchText
                    height: 45
                    anchors{
                        left: createId.left
                        right: createId.right
                    }
                    placeholderText: "Параметр поиска"
                    maxCharacters: 40
                    Layout.preferredWidth: parent.width
                    onTextChanged: {
                        goodsPage.sorting();
                    }
                }
                MenuButton {
                    id: createId
                    textValue: "Создать товар"
                    onClicked: {
                        if (textValue === "Создать товар") {
                            undoText();
                            sv.push(createGoodsPage);
                            textValue = "Назад";
                        } else {
                            undoText();
                        }
                    }
                }
                MenuButton {
                    id: categoriesButton
                    textValue: "Категории товаров"

                    onClicked:{
                        if (textValue === "Категории товаров") {
                            undoText();
                            sv.push(categoriesPage);
                            textValue = "Назад";
                        } else {
                            undoText();
                        }
                    }
                }
                MenuButton {
                    id: suppliersId
                    textValue: "Поставщики"
                    onClicked: {
                        if (textValue === "Поставщики") {
                            undoText();
                            sv.push(suppliers);
                            textValue = "Назад";
                        } else {
                            undoText();
                        }
                    }
                }
                MenuButton {
                    id: suppliesId
                    textValue: "Поставки"
                    onClicked: {
                        if (textValue === "Поставки") {
                            undoText();
                            sv.push(suppliesPage);
                            textValue = "Назад";
                        } else {
                            undoText();
                        }
                    }
                }

                MenuButton {
                    id: createTableId
                    textValue: "Создать таблицу"
                    onClicked: {
                        createJson.open();
                    }
                    FileDialog {
                        id: createJson
                        title: "Выберите папку"
                        fileMode: FileDialog.SaveFile
                        currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                        nameFilters: ["*.json"]
                        onAccepted: {
                            myData.setPath(selectedFile);
                            myData.createFile();
                            curentOpenFile = selectedFile;
                        }
                    }
                }

                MenuButton {
                    textValue: "Открыть таблицу"
                    onClicked: {
                        openJson.open();
                    }
                    FileDialog {
                        id: openJson
                        title: "Выберите файл"
                        currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
                        nameFilters: ["Data (*.json)"]
                        onAccepted: {
                            myData.setPath(selectedFile);
                            curentOpenFile = selectedFile;
                            myData.load();
                            categoriesPage.clear();
                            suppliers.clear();
                            suppliesPage.clear();
                            goodsPage.clear();
                            createGoodsPage.clear();
                            for(let i = 0; i < myData.getCategoriesCount(); i++){
                                categoriesPage.createCat(myData.getCategoryName(i), true);
                            }
                            for(let i = 0; i < myData.getSuppliersCount(); i++){
                                suppliers.addSuplier(myData.getSupplierName(i),
                                                     myData.getSupplierNumber(i),
                                                     true)
                                for(let j = 0; j< myData.getSuppliesCountNames(i); j++){
                                    suppliesPage.startAdd(myData.getSupplyNameSupplier(i),
                                                          myData.getSupplyName(i,j),
                                                          myData.getSupplyCount(i,j),
                                                          true)
                                }
                            }
                            for(let i = 0; i < myData.getProductsCount(); i++){
                                createGoodsPage.addProduct(myData.getProductName(i),
                                                     myData.getProductDescription(i),
                                                     myData.getProductHref(i),
                                                     myData.getProductCount(i),
                                                     myData.getProductCategory(i),
                                                     myData.getProductSupplier(i),
                                                     true)
                            }
                        }
                    }
                }
                Rectangle {
                    Layout.fillHeight: true
                    color: "transparent"
                }
            }
        }

        StackView {
            id: sv

            pushEnter: null
            pushExit: null
            popEnter: null
            popExit: null

            Layout.fillWidth: true
            Layout.preferredWidth: parent.width * 0.8

            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            initialItem: goodsPage
        }
    }

    MainPage {
        WaitingScreen{}
        id: goodsPage
        anchors.fill: parent
        visible: false
    }
    CreateGoods {
        WaitingScreen{}
        id: createGoodsPage
        anchors.fill: parent
        visible: false
    }
    Categories{
        WaitingScreen{}
        id: categoriesPage
        anchors.fill: parent
        visible: false
    }
    SuppliersPage {
        WaitingScreen{}
        id: suppliers
        anchors.fill: parent
        visible: false
    }
    SuppliesPage{
        WaitingScreen{}
        id: suppliesPage
        anchors.fill: parent
        visible: false
    }
    Answer {
        id: appAnswer
    }
}
