#pragma once
#include "Data.h"
#include "nlohmann/json.hpp"
#include <fstream>
#include "string"
using namespace std;

void Data::saveAll() {
    nlohmann::json dataBase;
    for (auto & products : Products){
        dataBase["Data"]["Product"].push_back({{
            {"name", products.name},
            {"description", products.description},
            {"href", products.href},
            {"count", products.count},
            {"supplier", products.supplier},
            {"category", products.category},
        }});
    }
    for (auto & categories : Categories){
        dataBase["Data"]["Categories"].push_back({{
            {"name", categories.name},
        }});
    }
    for (int i = 0; i < Supplies.size(); i++) {
        nlohmann::json supply;
        supply["supplier"] = Supplies[i].supplier;
        supply["number"] = Supplies[i].number;

        for (int j = 0; j < Supplies[i].names.size(); j++) {
            nlohmann::json detail;
            detail["name"] = Supplies[i].names[j];
            detail["count"] = Supplies[i].counts[j];
            supply["goods"].push_back(detail);
        }
        dataBase["Data"]["Supplies"].push_back(supply);
    }
    for (auto & suppliers : Suppliers){
        dataBase["Data"]["Suppliers"].push_back({{
            {"name", suppliers.name},
            {"number", suppliers.number},
        }});
    }
    ofstream file(path);
    if (!file.is_open()) {
        return;
    }
    file << dataBase.dump(4);
    file.close();
}
void Data::load() {
    ifstream file(path);
    if (!file.is_open()) {
        return;
    }
    nlohmann::json t_json;
    file >> t_json;
    file.close();

    Products = static_cast<const vector<Product>>(t_json["Data"]["Products"]);
    Categories = static_cast<const vector<Category>>(t_json["Data"]["Categories"]);
    Supplies = static_cast<const vector<Supply>>(t_json["Data"]["Supplies"]);
    Suppliers = static_cast<const vector<Supplier>>(t_json["Data"]["Suppliers"]);
}
void Data::setPath(string t_path){
    path = t_path;
}

void Data::addSupplier(string name, string number) {
    Supplier t_supplier;
    t_supplier.name = name;
    t_supplier.number = number;
    Suppliers.push_back(t_supplier);
    saveAll();
}
void Data::addCategory(string name) {
    Category t_category;
    t_category.name = name;
    Categories.push_back(t_category);
    saveAll();
}
void Data::addSupplys(string supplier, string number) {
    Supply t_supply;
    t_supply.supplier = supplier;
    t_supply.number = number;
    Supplies.push_back(t_supply);
    saveAll();
}
void Data::addSupply(string supplier,string name, int count){
    for(int i = 0; i < Supplies.size(); i++){
        if(Supplies[i].supplier == supplier){
            Supplies[i].names.push_back(name);
            Supplies[i].counts.push_back(count);
        }
    }
}
void Data::removeProductSupply(string supplier, string nameProduct){
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
void Data::addProduct(string name, string description, string href, int count, string supplier, string category) {
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

void Data::removeSupplier(string name) {
    for(int i = 0; i < Suppliers.size(); i++) {
        if(Suppliers[i].name == name) {
            Suppliers.erase(Suppliers.begin() + i);
            saveAll();
            break;
        }
    }
}
void Data::removeCategory(string name) {
    for(int i = 0; i < Categories.size(); i++) {
        if(Categories[i].name == name) {
            Categories.erase(Categories.begin() + i);
            saveAll();
            break;
        }
    }
}
void Data::removeSupply(string supplier) {
    for(int i = 0; i < Supplies.size(); i++) {
        if(Supplies[i].supplier == supplier) {
            Supplies.erase(Supplies.begin() + i);
            saveAll();
            break;
        }
    }
}
void Data::removeProduct(string name) {
    for(int i = 0; i < Products.size(); i++) {
        if(Products[i].name == name) {
            Products.erase(Products.begin() + i);
            saveAll();
            break;
        }
    }
}
void Data::editProduct(string last_name, string name, string description, string href, int count, string supplier, string category) {
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
Supplier Data::getSupplier(string name) {
    return Supplier();
}
Category Data::getCategory(string name) {
    return Category();
}
Supply Data::getSupply(string supplier, string number) {
    return Supply();
}
Product Data::getProduct(string name) {
    return Product();
}

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