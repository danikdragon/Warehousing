#ifndef DATA_H
#define DATA_H
#include <QObject>
#include <vector>
#include <QFile>
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
    Q_INVOKABLE void setPath(QString t_path) {path = t_path.remove(0, 8);}
    Q_INVOKABLE QString getPath() {return path;}
    Q_INVOKABLE void createFile();

    //product for save
    Q_INVOKABLE void addProduct(QString name, QString description, QString href, int count, QString supplier, QString category);
    Q_INVOKABLE void removeProduct(QString name);
    Q_INVOKABLE void removeProductSupply(QString supplier, QString nameProduct);
    Q_INVOKABLE void editProduct(QString last_name, QString name, QString description, QString href, int count, QString supplier, QString category);
    Q_INVOKABLE void addCountProduct(QString name);
    Q_INVOKABLE void removeCountProduct(QString name);
    //product for load
    Q_INVOKABLE int getProductsCount(){ return Products.size(); }
    Q_INVOKABLE QString getProductName(int number);
    Q_INVOKABLE QString getProductDescription(int number);
    Q_INVOKABLE QString getProductHref(int number);
    Q_INVOKABLE int getProductCount(int number);
    Q_INVOKABLE QString getProductSupplier(int number);
    Q_INVOKABLE QString getProductCategory(int number);

    //category for save
    Q_INVOKABLE void addCategory(QString name);
    Q_INVOKABLE void removeCategory(QString name);
    //category for load
    Q_INVOKABLE int getCategoriesCount(){return Categories.size();}
    Q_INVOKABLE QString getCategoryName(int number);

    //suppliers for save
    Q_INVOKABLE void addSupplier(QString name, QString number);
    Q_INVOKABLE void removeSupplier(QString name);
    //suppliers for load
    Q_INVOKABLE int getSuppliersCount(){ return Suppliers.size(); };
    Q_INVOKABLE QString getSupplierName(int numbere);
    Q_INVOKABLE QString getSupplierNumber(int numbere);

    //supplies for save
    Q_INVOKABLE void setSupplyCount(QString Product_name, int count);
    Q_INVOKABLE void addSupplys(QString supplier, QString number);
    Q_INVOKABLE void addSupply(QString supplier,QString name, int count);
    Q_INVOKABLE void removeSupply(QString supplier);
    //supplies for load
    Q_INVOKABLE int getSuppliesCount(){return Supplies.size(); }
    Q_INVOKABLE int getSuppliesCountNames(int number){ return Supplies[number].names.size(); }
    Q_INVOKABLE QString getSupplyName(int number1, int number2);
    Q_INVOKABLE int getSupplyCount(int number1, int number2);
    Q_INVOKABLE QString getSupplyNameSupplier(int number){return Supplies[number].supplier;}
private:
    QString path = "";
    vector<Product> Products;
    vector<Category> Categories;
    vector<Supplier> Suppliers;
    vector<Supply> Supplies;
};
#endif
