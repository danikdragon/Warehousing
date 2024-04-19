#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <nlohmann/json.hpp>
#include <string>
#include <ostream>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/Warehousing/QML/Main.qml"_qs);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.load(url);

    return QGuiApplication::exec();

}
class Lol1{
public:

    void foo (){

    }
    Lol1(int value, const std::string &name) : value(value), name(name) {}

    bool operator<(const Lol1 &rhs) const {
        if (value < rhs.value)
            return true;
        if (rhs.value < value)
            return false;
        if (name < rhs.name)
            return true;
        if (rhs.name < name)
            return false;
    }

    bool operator>(const Lol1 &rhs) const {
        return rhs < *this;
    }

    bool operator<=(const Lol1 &rhs) const {
        return !(rhs < *this);
    }

    bool operator>=(const Lol1 &rhs) const {
        return !(*this < rhs);
    }

    friend std::ostream &operator<<(std::ostream &os, const Lol1 &o) {
        os << "value: " << o.value << " name: " << o.name << " id: ";
        return os;
    }


private:
    int value = 0;
    std::string name = "";
};
class LolOlO : public Lol1{
public:

    bool operator<(const LolOlO &rhs) const {
        if (value < rhs.value)
            return true;
        if (rhs.value < value)
            return false;
        if (name < rhs.name)
            return true;
        if (rhs.name < name)
            return false;
        return id < rhs.id;
    }

    bool operator>(const LolOlO &rhs) const {
        return rhs < *this;
    }

    bool operator<=(const LolOlO &rhs) const {
        return !(rhs < *this);
    }

    bool operator>=(const LolOlO &rhs) const {
        return !(*this < rhs);
    }

    virtual ~LolOlO() {

    }

    friend std::ostream &operator<<(std::ostream &os, const LolOlO &o) {
        os << "value: " << o.value << " name: " << o.name << " id: " << o.id;
        return os;
    }


private:
    int value = 0;
    std::string name = "";
    int *id = &value;
};