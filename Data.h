#pragma once
#include <QObject>
#include <vector>
#include "nlohmann/json.hpp"
#include <fstream>
#include "string"
using namespace std;

//Структуры всех дб
struct Supplier{
    string name;
    string number;
};

struct Category{
    string name;
};

struct Supply{
    string supplier;
    string number;
    vector<string> names;
    vector<int> counts;
};

struct Product{
    string name;
    string description;
    string href;
    int count;
    string supplier;
    string category;
};

//Класс
class Data: public QObject{
    Q_OBJECT
public:
    void saveAll();
    void load();

    vector<Supplier> getSuppliers();
    vector<Category> getCategories();
    vector<Supply> getSupplies();
    vector<Product> getProducts();

    void setSuppliers(vector<Supplier> suppliers);
    void setCategories(vector<Category> categories);
    void setSupplies(vector<Supply> supplies);
    void setProducts(vector<Product> products);

    void addSupplier(string name, string number);//
    void addCategory(string name);//
    void addSupplys(string supplier, string number);//
    void addSupply(string supplier,string name, int count);//
    void addProduct(string name, string description, string href, int count, string supplier, string category);//

    Supplier getSupplier(string name);
    Category getCategory(string name);
    Supply getSupply(string supplier, string number);
    Product getProduct(string name);

    void removeSupplier(string name);//
    void removeCategory(string name);//
    void removeSupply(string supplier);//
    void removeProductSupply(string supplier, string nameProduct);//
    void removeProduct(string name);//

    void editProduct(string last_name, string name, string description, string href, int count, string supplier, string category);//

    void setPath(string t_path);//
private:
    string path = "None";
    vector<Supplier> Suppliers;
    vector<Category> Categories;
    vector<Supply> Supplies;
    vector<Product> Products;
};