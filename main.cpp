#include <QApplication>
#include "MainWindow.h"

int main(int argc, char *argv[]) {
    QApplication a(argc, argv);
    Ui_MainWindow ui;
    QMainWindow w;

    ui.setupUi(&w);
    w.show();
    return QApplication::exec();
}
