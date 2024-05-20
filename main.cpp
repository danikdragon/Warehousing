#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "Data.h"
#include "nlohmann/json.hpp"

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
    Data my_dataBase;
    // Зарегистрируйте тип, чтобы он был доступен в QML
    qmlRegisterType<Data>("DataBase.json", 1, 0, "DataBase");
    // Передайте объект в контекст QML
    engine.rootContext()->setContextProperty("myData", &my_dataBase);

    return QGuiApplication::exec();
}
#include "main.moc"