#pragma once
#include <QObject>
#include <vector>
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
struct Data{
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

    void addSupplier(string name, string number);
    void addCategory(string name);
    void addSupply(string supplier, string number, vector<string> names, vector<int> counts);
    void addProduct(string name, string description, string href, int count, string supplier, string category);

    Supplier getSupplier(string name);
    Category getCategory(string name);
    Supply getSupply(string supplier, string number);
    Product getProduct(string name);

    void removeSupplier(string name);
    void removeCategory(string name);
    void removeSupply(string supplier, string number);
    void removeProduct(string name);

    void editProduct(string name, string description, string href, int count, string supplier, string category);

    void setPath(string t_path);
private:
    string path = "None";
    vector<Supplier> Suppliers;
    vector<Category> Categories;
    vector<Supply> Supplies;
    vector<Product> Products;
};