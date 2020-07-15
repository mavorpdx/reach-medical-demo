#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QSettings>
#include <QQmlContext>
#include <QDebug>
#include <QCoreApplication>
#include <QJsonDocument>
#include <QJsonObject>
#include <QScreen>

#include "signal.h"
#include "common.h"
#include "mainviewcontroller.h"
#include "serialcontroller.h"
#include "translator.h"
#include "network.h"
//#include "beeper.h"
#include "gpiopin.h"
#include "backlight.h"
#include "system.h"
#include "myGlobal.h"
#include "myStyle.h"

StyleValues  MyStyle;
GlobalValues MyGlobal;


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("MyGlobal", & MyGlobal);
    qDebug() << "The global count is => " << MyGlobal.count();

    engine.rootContext()->setContextProperty("MyStyle", & MyStyle);
    qDebug() << "The style count is => " << MyStyle.count();

    SerialController serialController;
    /* Need to register before the MainviewController is instantiated */
    qmlRegisterType < Network > ("net.reachtech", 1, 0, "Network");
    //qmlRegisterType < Beeper > ("sound.reachtech", 1, 0, "Beeper");
    qmlRegisterType < GpioPin > ("gpio.reachtech", 1, 0, "GpioPin");
    qmlRegisterType < Backlight > ("backlight.reachtech", 1, 0, "Backlight");
    qmlRegisterType < System > ("system.reachtech", 1, 0, "System");

    QScreen *screen = QGuiApplication::primaryScreen();
    QRect  screenGeometry = screen->geometry();
    MyGlobal.insert("screenWidth", screenGeometry.width());
    MyGlobal.insert("screenHeight", screenGeometry.height());
    MyGlobal.insert("screenFactor", screenGeometry.height());
    qDebug() << "Screen Size is"  << MyGlobal.value("screenWidth").toInt() << "x" <<  MyGlobal.value("screenHeight").toInt();

    engine.load(QUrl(QStringLiteral("qrc:/MainScreen.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    QObject * topLevel = engine.rootObjects().value(0);
    QQuickWindow * window = qobject_cast < QQuickWindow * > (topLevel);
    if (window == nullptr) {
      qDebug() << "Can't instantiate window";
    }

    QObject::connect(window, SIGNAL(submitTextField(QString)), & serialController, SLOT(send(QString)));
    return app.exec();
}









