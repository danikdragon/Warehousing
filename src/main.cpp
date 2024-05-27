#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QIcon>
#include "Data.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    app.setWindowIcon(QIcon(":/image/icon.ico"));
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
    QObject::connect(&app, &QGuiApplication::aboutToQuit, [&my_dataBase]() {
        my_dataBase.closeFiles();
        qDebug() << "Application is about to quit. Files closed.";
    });

    return app.exec();
}
