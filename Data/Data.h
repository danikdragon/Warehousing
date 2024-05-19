#pragma once
#include <QObject>
#include <vector>
using namespace std;

//Структуры всех дб
struct Supplier{
    QString name;
    QString number;
};

struct Category{
    QString name;
};

struct Supply{
    QString supplier;
    QString number;
    vector<QString> names;
    vector<int> counts;
};

struct Product{
    QString name;
    QString description;
    QString href;
    int count;

    QString supplier;
    QString category;
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

    void addSupplier(QString name, QString number);
    void addCategory(QString name);
    void addSupply(QString supplier, QString number, vector<QString> names, vector<int> counts);
    void addProduct(QString name, QString description, QString href, int count, QString supplier, QString category);

    Supplier getSupplier(QString name);
    Category getCategory(QString name);
    Supply getSupply(QString supplier, QString number);
    Product getProduct(QString name);

    void removeSupplier(QString name);
    void removeCategory(QString name);
    void removeSupply(QString supplier, QString number);
    void removeProduct(QString name);

    void editProduct(QString name, QString description, QString href, int count, QString supplier, QString category);

    //void saveProduct();
    //void saveSupply();
    //void saveCategory();
    //void saveSupplier();
private:
    string path = "None";
    vector<Supplier> Suppliers;
    vector<Category> categories;
    vector<Supply> Supplies;
    vector<Product> Products;
};