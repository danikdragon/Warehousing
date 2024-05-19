#include "Data.h"
#include "nlohmann/json.hpp"
#include <fstream>
#include "string"

using namespace std;
using json = nlohmann::json;

void Data::saveAll() {
    json t_json = {{"Data",
        {"Products",
            for (int i = 0; i < Products.size(); i++) {
                {"Name", Suppliers[i].name},
                {"Description", Suppliers[i].description},
                {"Href", Suppliers[i].href},
                {"Supplies", Suppliers[i].count},
                {"Supplier", Suppliers[i].supplier},
                {"Category", Suppliers[i].category};
            }
        },
        {"Categories",
            for (int i = 0; i < Categories.size(); i++) {
                {"Name", Categories[i].name};
            }
        },
        {"Suppliers",
            for (int i = 0; i < Suppliers.size(); i++) {
                {"Name", Suppliers[i].name},
                {"Number", Suppliers[i].number};
            }
        },
        {"Supplies",
            for (int i = 0; i < Supplies.size(); i++) {
                {"Supplier", Supplies[i].supplier},
                {"Number", Supplies[i].number},
                for(int j = 0; j < Supplies[i].names.size(); j++){
                    {"Names", Supplies[i].names[j]},
                    {"Counts", Supplies[i].counts[j]}
                }
            }
        }
    }};
    ofstream file(path);
    if (!file.is_open()) {
        return;
    }
    file << t_json.dump(4);
    file.close();
}
void Data::load() {
    ifstream file(path);
    if (!file.is_open()) {
        return;
    }
    json t_json;
    file >> t_json;
    file.close();

    Products = t_json["Data"]["Products"];
    Categories = t_json["Data"]["Categories"];
    Supplies = t_json["Data"]["Supplies"];
    Suppliers = t_json["Data"]["Suppliers"];
}

void Data::addSupplier(QString name, QString number) {
    Supplier t_supplier;
    t_supplier.name = name;
    t_supplier.number = number;
    Suppliers.push_back(t_supplier);
}
void Data::addCategory(QString name) {
    Category t_category;
    t_category.name = name;
    categories.push_back(t_category);
}
void Data::addSupply(QString supplier, QString number, vector<QString> names, vector<int> counts) {
    Supply t_supply;
    t_supply.supplier = supplier;
    t_supply.number = number;
    t_supply.names = names;
    t_supply.counts = counts;
    Supplies.push_back(t_supply);
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
}

void Data::removeSupplier(QString name) {
    for(int i = 0; i < Suppliers.size(); i++) {
        if(Suppliers[i].name == name) {
            Suppliers.erase(Suppliers.begin() + i);
            break;
        }
    }
}
void Data::removeCategory(QString name) {
    for(int i = 0; i < categories.size(); i++) {
        if(categories[i].name == name) {
            categories.erase(categories.begin() + i);
            break;
        }
    }
}
void Data::removeSupply(QString supplier, QString number) {
    for(int i = 0; i < Supplies.size(); i++) {
        if(Supplies[i].supplier == supplier && Supplies[i].number == number) {
            Supplies.erase(Supplies.begin() + i);
            break;
        }
    }
}
void Data::removeProduct(QString name) {
    for(int i = 0; i < Products.size(); i++) {
        if(Products[i].name == name) {
            Products.erase(Products.begin() + i);
            break;
        }
    }
}
void Data::editProduct(QString name, QString description, QString href, int count, QString supplier, QString category) {
    for(int i = 0; i < Products.size(); i++) {
        if(Products[i].name == name) {
            Products[i].description = description;
            Products[i].href = href;
            Products[i].count = count;
            Products[i].supplier = supplier;
            Products[i].category = category;
            break;
        }
    }
}

vector<Supplier> Data::getSuppliers() {
    return Suppliers;
}
vector<Category> Data::getCategories() {
    return categories;
}
vector<Supply> Data::getSupplies() {
    return Supplies;
}
vector<Product> Data::getProducts() {
    return Products;
}

void Data::setSuppliers(vector<Supplier> suppliers) {
    Suppliers = suppliers;
}
void Data::setCategories(vector<Category> categories) {
    categories = categories;
}
void Data::setSupplies(vector<Supply> supplies) {
    Supplies = supplies;
}
void Data::setProducts(vector<Product> products) {
    Products = products;
}

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

//void Data::saveProduct() {
//    json t_json = {
//        {"name", Suppliers[Suppliers.back()].name},
//        {"description", Suppliers[Suppliers.back()].description},
//        {"href", Suppliers[Suppliers.back()].href},
//        {"supplies", Suppliers[Suppliers.back()].count},
//        {"supplier", Suppliers[Suppliers.back()].supplier},
//        {"category", Suppliers[Suppliers.back()].category}
//    };
//    ofstream t_file(path);
//    t_file << t_jsondump(4);
//    t_file.close();
//}
//void Data::saveSupply() {
//    json t_json = {
//        {"supplier", Supplies[Supplies.back()].supplier},
//        {"number", Supplies[Supplies.back()].number},
//        for(){
//            {"names", Supplies[Supplies.back()].names},
//            {"counts", Supplies[Supplies.back()].counts}
//        }
//    };
//    ofstream t_file(path);
//    t_file << t_json.dump(4);
//    t_file.close();
//}
//void Data::saveCategory() {
//    json t_json = {
//        {"name", Categories[Categories.back()].name}
//    };
//    ofstream t_file(path);
//    t_file << t_jsondump(4);
//    t_file.close();
//}
//void Data::saveSupplier() {
//    json t_json = {
//        {"name", Suppliers[Suppliers.back()].name},
//        {"number", Suppliers[Suppliers.back()].number}
//    };
//    ofstream t_file(path);
//    t_file << t_jsondump(4);
//    t_file.close();
//}