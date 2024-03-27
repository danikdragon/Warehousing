#ifndef WAREHOUSING_MAINWINDOW_H
#define WAREHOUSING_MAINWINDOW_H
#include <QtCore/QVariant>
#include <QtWidgets/QApplication>
#include <QtWidgets/QFrame>
#include <QtWidgets/QGridLayout>
#include <QtWidgets/QMainWindow>
#include <QtWidgets/QPushButton>
#include <QtWidgets/QSpacerItem>
#include <QtWidgets/QVBoxLayout>
#include <QtWidgets/QWidget>
#include <QGraphicsDropShadowEffect>
#include <vector>
#include <QTimer>

using namespace std;
QT_BEGIN_NAMESPACE

class Ui_MainWindow
{
public:
    QWidget *centralwidget;

    QGridLayout *gridLayout_2;
    QGridLayout *gridLayout;

    QVBoxLayout *verticalLayout;

    QFrame *verticalFrame_2;
    QVBoxLayout *verticalLayout_2;

    QSpacerItem *verticalSpacer;
    vector<QPushButton*> buttons;
    vector<QVBoxLayout*> goods;

    void setupUi(QMainWindow *MainWindow)
    {
        if (MainWindow->objectName().isEmpty())
            MainWindow->setObjectName("MainWindow");

        MainWindow->setWindowModality(Qt::NonModal);
        MainWindow->resize(1100, 550);
        MainWindow->setStyleSheet(QString::fromUtf8("background-color: rgb(217,217,217);"));
        centralwidget = new QWidget(MainWindow);
        centralwidget->setObjectName("centralwidget");
        centralwidget->setMinimumSize(QSize(800, 0));
        gridLayout_2 = new QGridLayout(centralwidget);
        gridLayout_2->setObjectName("gridLayout_2");
        gridLayout_2->setContentsMargins(0, 0, 0, 0);
        gridLayout = new QGridLayout();
        gridLayout->setObjectName("gridLayout");
        verticalLayout = new QVBoxLayout();
        verticalLayout->setObjectName("verticalLayout");

        gridLayout->addLayout(verticalLayout, 0, 1, 1, 1);

        verticalFrame_2 = new QFrame(centralwidget);

        QGraphicsDropShadowEffect *shadowEffect = new QGraphicsDropShadowEffect(verticalFrame_2);
        shadowEffect->setBlurRadius(10);
        shadowEffect->setXOffset(5);
        shadowEffect->setYOffset(10);
        shadowEffect->setColor(QColor(0, 0, 0, 20));
        verticalFrame_2->setGraphicsEffect(shadowEffect);

        verticalFrame_2->setObjectName("verticalFrame_2");
        verticalFrame_2->setStyleSheet(QString::fromUtf8("background-color: rgb(221, 221, 221);\n"));
        verticalLayout_2 = new QVBoxLayout(verticalFrame_2);
        verticalLayout_2->setSpacing(14);
        verticalLayout_2->setObjectName("verticalLayout_2");
        verticalLayout_2->setSizeConstraint(QLayout::SetMinAndMaxSize);
        verticalLayout_2->setContentsMargins(-1, 16, -1, -1);


        for (int i = 0; i < 7; ++i)
        {
            buttons.push_back(new QPushButton);

            QFont font("Inter", 13);
            QGraphicsDropShadowEffect *shadowEffect = new QGraphicsDropShadowEffect(buttons[i]);
            shadowEffect->setBlurRadius(20);
            shadowEffect->setXOffset(0);
            shadowEffect->setYOffset(4);
            shadowEffect->setColor(QColor(0, 0, 0, 100));

            buttons[i]->setObjectName("MenuButtons_" + i);
            buttons[i]->setMinimumSize(QSize(220, 40));
            buttons[i]->setFont(font);
            buttons[i]->setStyleSheet(QString::fromUtf8("background-color: rgb(90, 90, 90);\n"
                                                             "color: rgb(233, 233, 233);\n"
                                                             "border: none;\n"));
            buttons[i]->setGraphicsEffect(shadowEffect);
            QObject::connect(buttons[i], &QPushButton::pressed, [&,i](){
                buttons[i]->setStyleSheet(QString::fromUtf8("background-color: rgb(70, 70, 70);\n"
                                                            "color: rgb(200, 200, 200);\n"
                                                            "border: none;\n"));
                QTimer::singleShot(150,[&,i](){
                    buttons[i]->setStyleSheet(QString::fromUtf8("background-color: rgb(90, 90, 90);\n"
                                                                "color: rgb(233, 233, 233);\n"
                                                                "border: none;\n"));
                });

            });
            verticalLayout_2->addWidget(buttons[i]);
        }
        verticalSpacer = new QSpacerItem(20, 40, QSizePolicy::Policy::Minimum, QSizePolicy::Policy::Expanding);
        verticalLayout_2->addItem(verticalSpacer);

        gridLayout->addWidget(verticalFrame_2, 0, 0, 1, 1);

        gridLayout->setColumnStretch(0, 1);
        gridLayout->setColumnStretch(1, 4);

        gridLayout_2->addLayout(gridLayout, 0, 0, 1, 1);

        MainWindow->setCentralWidget(centralwidget);

        retranslateUi(MainWindow);

        QMetaObject::connectSlotsByName(MainWindow);
    } // setupUi

    void retranslateUi(QMainWindow *MainWindow)
    {
        MainWindow->setWindowTitle(QCoreApplication::translate("MainWindow", "Warehousing"));
        buttons[0]->setText(QCoreApplication::translate("MainWindow", "Создать новый товар"));
        buttons[1]->setText(QCoreApplication::translate("MainWindow", "Создать новую таблицу"));
        buttons[2]->setText(QCoreApplication::translate("MainWindow", "Открыть таблицу"));
        buttons[3]->setText(QCoreApplication::translate("MainWindow", "Поставки"));
        buttons[4]->setText(QCoreApplication::translate("MainWindow", "Поставщики"));
        buttons[5]->setText(QCoreApplication::translate("MainWindow", "Категории товаров"));
        buttons[6]->setText(QCoreApplication::translate("MainWindow", "Фильтр"));

        QObject::connect(buttons[0],&QPushButton::clicked, [&](){

        });

    }
private:
    bool tableIsOpen = false;
};

namespace Ui {
    class MainWindow: public Ui_MainWindow {};
}

QT_END_NAMESPACE
#endif