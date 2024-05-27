#ifndef DATA_H
#define DATA_H
#include <QObject>
#include <vector>
#include <qqml.h>
using namespace std;

//structs
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

//class
class Data: public QObject{
    Q_OBJECT
public:
    //file
    Q_INVOKABLE void saveAll();
    Q_INVOKABLE void load();
    Q_INVOKABLE void setPath(QString t_path);
    Q_INVOKABLE void createFile();

    //product
    Q_INVOKABLE vector<Product> getProducts();
    Q_INVOKABLE void setProducts(vector<Product> products);
    Q_INVOKABLE void addProduct(QString name, QString description, QString href, int count, QString supplier, QString category);
    Q_INVOKABLE Product getProduct(QString name);
    Q_INVOKABLE void removeProduct(QString name);
    Q_INVOKABLE void removeProductSupply(QString supplier, QString nameProduct);
    Q_INVOKABLE void editProduct(QString last_name, QString name, QString description, QString href, int count, QString supplier, QString category);
    Q_INVOKABLE void addCountProduct(QString name);
    Q_INVOKABLE void removeCountProduct(QString name);

    //suppliers
    Q_INVOKABLE vector<Supplier> getSuppliers();
    Q_INVOKABLE void addSupplier(QString name, QString number);
    Q_INVOKABLE void removeSupplier(QString name);
    Q_INVOKABLE void setSuppliers(vector<Supplier> suppliers);
    Q_INVOKABLE Supplier getSupplier(QString name);

    //supplies
    Q_INVOKABLE void removeSupplyCount(QString Product_name);
    Q_INVOKABLE void addSupplyCount(QString Product_name);
    Q_INVOKABLE void addSupplys(QString supplier, QString number);
    Q_INVOKABLE vector<Supply> getSupplies();
    Q_INVOKABLE void setSupplies(vector<Supply> supplies);
    Q_INVOKABLE void addSupply(QString supplier,QString name, int count);
    Q_INVOKABLE Supply getSupply(QString supplier, QString number);
    Q_INVOKABLE void removeSupply(QString supplier);

    //category
    Q_INVOKABLE vector<Category> getCategories();
    Q_INVOKABLE void setCategories(vector<Category> categories);
    Q_INVOKABLE Category getCategory(QString name);
    Q_INVOKABLE void addCategory(QString name);
    Q_INVOKABLE void removeCategory(QString name);

public slots:
    void closeFiles() {
        saveAll();
        qDebug() << "Saved json in "+ path;
    }
private:
    QString path = "";
    vector<Supplier> Suppliers;
    vector<Category> Categories;
    vector<Supply> Supplies;
    vector<Product> Products;
};
#endif