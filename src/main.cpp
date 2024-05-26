#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "Data.h"
#include "app_environment.h"
#include "import_qml_components_plugins.h"
#include "import_qml_plugins.h"

int main(int argc, char *argv[])
{
    set_qt_environment();

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

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
        // Здесь вы можете закрыть файлы или выполнить другие действия перед завершением работы
        my_dataBase.closeFiles(); // Предположим, у вас есть метод closeFiles в классе Data
        qDebug() << "Application is about to quit. Files closed.";
    });

    return app.exec();
}
