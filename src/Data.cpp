#include "Data.h"
#include "nlohmann/json.hpp"
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QFile>
#include <QTextStream>
#include <vector>
#include <QDebug>
using namespace std;

void Data::saveAll() {
    nlohmann::json dataBase;
    qDebug()<< "Start save";
    for (auto & products : Products){
        dataBase["Data"]["Product"].push_back({
            {"category", products.category.toStdString()},
            {"supplier", products.supplier.toStdString()},
            {"count", products.count},
            {"href", products.href.toStdString()},
            {"description", products.description.toStdString()},
            {"name", products.name.toStdString()},
        });
    }
    for (auto & categories : Categories){
        dataBase["Data"]["Categories"].push_back({{"name", categories.name.toStdString()}});
    }
    for (int i = 0; i < Supplies.size(); i++) {
        nlohmann::json supply;
        supply["supplier"] = Supplies[i].supplier.toStdString();
        for (int j = 0; j < Supplies[i].names.size(); j++) {
            nlohmann::json detail;
            detail["count"] = Supplies[i].counts[j];
            detail["name"] = Supplies[i].names[j].toStdString();
            supply["goods"].push_back(detail);
        }
        dataBase["Data"]["Supplies"].push_back(supply);
    }
    for (auto & suppliers : Suppliers){
        dataBase["Data"]["Suppliers"].push_back({
            {"number", suppliers.number.toStdString()},
            {"name", suppliers.name.toStdString()},
        });
    }
    qDebug()<< "End json write";
    QFile file(path);
    qDebug()<< "start file write";
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qDebug()<< path << " file cant open";
        return;
    }

    qDebug()<< path << " file save";
    QTextStream out(&file);
    out << QString::fromStdString(dataBase.dump(4));
    file.close();

    qDebug()<< "End file write";
}
void Data::load() {
    QFile file(path);
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Failed to open file for reading: " << path;
        return;
    }

    QTextStream in(&file);
    nlohmann::json t_json = nlohmann::json::parse(in.readAll().toStdString());
    file.close();

    for(int i = 0; i < t_json["Data"]["Product"].size(); i++){
        Product temp;
        temp.name =  QString::fromStdString(t_json["Data"]["Product"][i]["name"]);
        qDebug() << "Product number " << i << " name = " << temp.name;

        temp.category =  QString::fromStdString(t_json["Data"]["Product"][i]["category"]);
        temp.count =  t_json["Data"]["Product"][i]["count"];
        temp.description =  QString::fromStdString(t_json["Data"]["Product"][i]["description"]);
        temp.href =  QString::fromStdString(t_json["Data"]["Product"][i]["href"]);
        temp.supplier =  QString::fromStdString(t_json["Data"]["Product"][i]["supplier"]);
        Products.push_back(temp);
    }
    qDebug() << "Product done!";
    for(int i = 0; i < t_json["Data"]["Suppliers"].size(); i++){
        Supplier temp;
        temp.name = QString::fromStdString(t_json["Data"]["Suppliers"][i]["name"]);
        qDebug() << "Supplier number " << i << " name = " << temp.name;

        temp.number = QString::fromStdString(t_json["Data"]["Suppliers"][i]["number"]);
        Suppliers.push_back(temp);
    }
    qDebug() << "Supplier done!";
    for(int i = 0; i < t_json["Data"]["Supplies"].size(); i++){
        Supply temp;
        //temp.number =QString::fromStdString(t_json["Data"]["Supplies"][i]["number"]);
        temp.supplier = QString::fromStdString(t_json["Data"]["Supplies"][i]["supplier"]);
        for (int j = 0; j < Suppliers.size(); ++j) {
            if(Suppliers[i].name == temp.supplier){
                temp.number = Suppliers[i].name;
                break;
            }
        }
        qDebug() << "Supply number " << i << " supplier = " << temp.supplier;

        for(int j = 0; j < t_json["Data"]["Supplies"][i]["goods"].size(); j++){
            temp.names.push_back(QString::fromStdString(t_json["Data"]["Supplies"][i]["goods"][j]["name"]));
            temp.counts.push_back(t_json["Data"]["Supplies"][i]["goods"][j]["count"]);
        }
        Supplies.push_back(temp);
    }
    qDebug() << "Supply done!";
    for(int i = 0; i < t_json["Data"]["Categories"].size(); i++){
        Category temp;
        temp.name = QString::fromStdString(t_json["Data"]["Categories"][i]["name"]);
        qDebug() << "Category number " << i << " name = " << temp.name;
        Categories.push_back(temp);
    }
    qDebug() << "Category done!";
}
void Data::createFile(){
    QFile file(path);
    file.close();
}

void Data::addSupplier(QString name, QString number) {
    Supplier t_supplier;
    t_supplier.name = name;
    t_supplier.number = number;
    Suppliers.push_back(t_supplier);
    saveAll();
}
void Data::addCategory(QString name) {
    Category t_category;
    t_category.name = name;
    Categories.push_back(t_category);
    saveAll();
}
void Data::addSupplys(QString supplier, QString number) {
    Supply t_supply;
    t_supply.supplier = supplier;
    t_supply.number = number;
    Supplies.push_back(t_supply);
    saveAll();
}
void Data::addSupply(QString supplier,QString name, int count){
    for(int i = 0; i < Supplies.size(); i++){
        if(Supplies[i].supplier == supplier){
            Supplies[i].names.push_back(name);
            Supplies[i].counts.push_back(count);
        }
    }
    saveAll();
}
void Data::addSupplyCount(QString Product_name){
    for(int i = 0; i < Supplies.size(); i++){
        for (int j = 0; j <  Supplies[i].names.size(); ++j) {
            if(Supplies[i].names[j] == Product_name){
                Supplies[i].counts[j]++;
                saveAll();
                return;
            }
        }
    }
}
void Data::removeSupplyCount(QString Product_name){
    for(int i = 0; i < Supplies.size(); i++){
        for (int j = 0; j <  Supplies[i].names.size(); ++j) {
            if(Supplies[i].names[j] == Product_name){
                Supplies[i].counts[j]--;
                saveAll();
                return;
            }
        }
    }
}
void Data::removeProductSupply(QString supplier, QString nameProduct){
    for(int i = 0; i < Supplies.size(); i++){
        if(Supplies[i].supplier == supplier){
            for(int j = 0; j < Supplies.size(); j++){
                if(Supplies[i].names[j] == nameProduct){
                    Supplies[i].names.erase(Supplies[i].names.begin() + j);
                }
            }
        }
    }
}
void Data::addProduct(QString name, QString description, QString href, int count, QString supplier, QString category) {
    Product t_product;
    t_product.name = name;
    t_product.description = description;
    t_product.href = href;
    t_product.count = count;
    t_product.supplier = supplier;
    t_product.category = category;
    Products.push_back(t_product);
    saveAll();
}

void Data::removeSupplier(QString name) {
    for(int i = 0; i < Suppliers.size(); i++) {
        if(Suppliers[i].name == name) {
            Suppliers.erase(Suppliers.begin() + i);
            saveAll();
            break;
        }
    }
}
void Data::removeCategory(QString name) {
    for(int i = 0; i < Categories.size(); i++) {
        if(Categories[i].name == name) {
            Categories.erase(Categories.begin() + i);
            saveAll();
            break;
        }
    }
}
void Data::removeSupply(QString supplier) {
    for(int i = 0; i < Supplies.size(); i++) {
        if(Supplies[i].supplier == supplier) {
            Supplies.erase(Supplies.begin() + i);
            saveAll();
            break;
        }
    }
}
void Data::removeProduct(QString name) {
    for(int i = 0; i < Products.size(); i++) {
        if(Products[i].name == name) {
            Products.erase(Products.begin() + i);
            saveAll();
            break;
        }
    }
}
void Data::editProduct(QString last_name, QString name, QString description, QString href, int count, QString supplier, QString category) {
    for(int i = 0; i < Products.size(); i++) {
        if(Products[i].description == last_name) {
            Products[i].name = name;
            Products[i].description = description;
            Products[i].href = href;
            Products[i].count = count;
            Products[i].supplier = supplier;
            Products[i].category = category;
            if(Products[i].name != ""){
                for(int j = 0; j < Supplies.size(); j++){
                    if(Supplies[j].supplier == Products[i].name){
                        for (int k = 0; k < Supplies[j].names.size(); ++k) {
                            if(Supplies[j].names[k] == last_name){
                                Supplies[j].names[k] = description;
                                break;
                            }
                        }
                        break;
                    }
                }
            }
            saveAll();
            break;
        }
    }
}
void Data::addCountProduct(QString name){
    for (int i = 0; i < Products.size(); ++i) {
        if(Products[i].name == name){
            Products[i].count++;
            saveAll();
            break;
        }
    }
}
void Data::removeCountProduct(QString name){
    for (int i = 0; i < Products.size(); ++i) {
        if(Products[i].name == name){
            Products[i].count--;
            saveAll();
            break;
        }
    }
}

QString Data::getSupplierName(int number) {
    return Suppliers[number].name;
}
QString Data::getSupplierNumber(int number) {
    return Suppliers[number].number;
}
QString Data::getCategoryName(int number) {
    return Categories[number].name;
}
QString Data::getSupplyName(int number1, int number2){
    return Supplies[number1].names[number2];
}
int Data::getSupplyCount(int number1, int number2){
    return Supplies[number1].counts[number2];
}

QString Data::getProductName(int number){
    return Products[number].name;
}
QString Data::getProductDescription(int number){
    return Products[number].description;
}
QString Data::getProductHref(int number){
    return Products[number].href;
}
int Data::getProductCount(int number){
    return Products[number].count;
}
QString Data::getProductSupplier(int number){
    return Products[number].supplier;
}
QString Data::getProductCategory(int number){
    return Products[number].category;
}
