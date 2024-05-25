#include "Data.h"
#include "nlohmann/json.hpp"
#include <QFile>
#include <QTextStream>
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
        dataBase["Data"]["Categories"].push_back({"name", categories.name.toStdString()});
    }
    for (int i = 0; i < Supplies.size(); i++) {
        nlohmann::json supply;
        supply["supplier"] = Supplies[i].supplier.toStdString();

        for (int j = 0; j < Supplies[i].names.size(); j++) {
            nlohmann::json detail;
            supply["goods"].push_back(detail);
            detail["count"] = Supplies[i].counts[j];
            detail["name"] = Supplies[i].names[j].toStdString();
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
    QString fileContent = in.readAll();
    file.close();

    nlohmann::json t_json = nlohmann::json::parse(fileContent.toStdString());

    Products = static_cast<const vector<Product>>(t_json["Data"]["Products"]);
    Categories = static_cast<const vector<Category>>(t_json["Data"]["Categories"]);
    Supplies = static_cast<const vector<Supply>>(t_json["Data"]["Supplies"]);
    Suppliers = static_cast<const vector<Supplier>>(t_json["Data"]["Suppliers"]);
}


void Data::setPath(QString t_path){
    path = t_path.remove(0, 8);
    qDebug()<< path;
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
        if(Products[i].name == last_name) {
            Products[i].name = name;
            Products[i].description = description;
            Products[i].href = href;
            Products[i].count = count;
            Products[i].supplier = supplier;
            Products[i].category = category;
            saveAll();
            break;
        }
    }
}

vector<Supplier> Data::getSuppliers() {
    return Suppliers;
}
vector<Category> Data::getCategories() {
    return Categories;
}
vector<Supply> Data::getSupplies() {
    return Supplies;
}
vector<Product> Data::getProducts() {
    return Products;
}
//-----------------------------------
Supplier Data::getSupplier(QString name) {
    return Supplier();
}
Category Data::getCategory(QString name) {
    return Category();
}
Supply Data::getSupply(QString supplier, QString number) {
    return Supply();
}
Product Data::getProduct(QString name) {
    return Product();
}
//-----------------------------------
void Data::setSuppliers(vector<Supplier> suppliers) {
    Suppliers = suppliers;
}
void Data::setCategories(vector<Category> categories) {
    Categories = categories;
}
void Data::setSupplies(vector<Supply> supplies) {
    Supplies = supplies;
}
void Data::setProducts(vector<Product> products) {
    Products = products;
}
