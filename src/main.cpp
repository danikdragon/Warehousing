#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include "Data.h"

#include "nlohmann/json.hpp"
#include <QFile>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    app.setWindowIcon(QIcon(":/image/icon1.ico"));
    Data my_dataBase;
    engine.rootContext()->setContextProperty("myData", &my_dataBase);

    const QUrl url(u"qrc:/qt/qml/Main/main.qml"_qs);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    engine.addImportPath(QCoreApplication::applicationDirPath() + "/qml");
    engine.addImportPath(":/");

    engine.load(url);

    if (engine.rootObjects().isEmpty()) {
        return -1;
    }

    nlohmann::json dataBase;
    qDebug()<< "Start save";
    for (int i = 0; i < 1000; i++){
        dataBase["Data"]["Product"].push_back({
            {"category", std::to_string(i)},
                {"supplier", std::to_string(i)},
                {"count", i},
                {"href", "qrc:/qt/qml/content/image/Pc.png"},
                {"description", std::to_string(i)},
                {"name", std::to_string(i)},
                });
    }
    for (int i = 0; i < 1000; i++){
        dataBase["Data"]["Categories"].push_back({{"name", std::to_string(i)}});
    }
    for (int i = 0; i < 1000; i++) {
        nlohmann::json supply;
        supply["supplier"] = std::to_string(i);
        for (int j = 0; j < 10; j++) {
            nlohmann::json detail;
            detail["count"] = j;
            detail["name"] = std::to_string(j);
            supply["goods"].push_back(detail);
        }
        dataBase["Data"]["Supplies"].push_back(supply);
    }
    for (int i = 0; i < 1000; i++){
        dataBase["Data"]["Suppliers"].push_back({
                {"number", std::to_string(i)},
                {"name", std::to_string(i)},
                });
    }
    QFile file("C:/Users/Даниил/Downloads/Новая папка/1000goods.json");
    QTextStream out(&file);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        qDebug()<< "C:/Users/Даниил/Downloads/Новая папка/1000goods.json" << " file cant open";
    }
    out << QString::fromStdString(dataBase.dump(4));
    file.close();
    qDebug()<< "End 1000goods write";

    return app.exec();
}
