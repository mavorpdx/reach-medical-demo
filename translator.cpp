#include <QIODevice>
#include <QTextStream>
#include <QMap>
#include <QDebug>

#include "translator.h"
#include "common.h"
#include "myStyle.h"
#include "myGlobal.h"

extern StyleValues MyStyle;
extern GlobalValues MyGlobal;

Translator::Translator(QObject * parent): QObject(parent), m_settings(APP_SETTINGS_PATH, QSettings::NativeFormat) {
  qDebug() << "Translator constructor --";
  m_settings.beginGroup("Translate");
  m_translateFile.setFileName(m_settings.value("translate_file").value < QString > ());
  m_settings.endGroup();
}

Translator::~Translator() {
  if (m_translateFile.isOpen()) {
    m_translateFile.close();
  }
}


QStringList Translator::translateGui(QString msg) {
  QStringList list = msg.split("=");
  return list;
}

QStringList Translator::translateSerial(QString msg) {
  QStringList split = msg.split("=");

  if (split.length() != 2) {
    qDebug() << "ERROR - Message in wrong format, missing equals";
    return split;
  }

  qDebug() << "Data = " << split[0];

  if (MyGlobal.contains(split[0])) {
    qDebug() << "myGlobal = " << split[0];
    QVariant myType = MyGlobal.value(split[0]);
    int theType = myType.type();

    if (theType == 1) //Bool
    {
      qDebug() << "BOOL";
      bool b = (strcmp("true", split[1].toLocal8Bit()) == 0) ? true : false;
      MyGlobal.insert(split[0], b);
    } else if (theType == 2) //Int
    {
      qDebug() << "INT";
      MyGlobal.insert(split[0], split[1].toInt());
    } else if (theType == 6) //Double
    {
      qDebug() << "DOUBLE";
      MyGlobal.insert(split[0], split[1].toDouble());
    } else if (theType == 10) //String
    {
      qDebug() << "STRING";
      MyGlobal.insert(split[0], split[1]);
    } else {
      qDebug() << "ERROR - Did not find a valid match for Type " << theType;
    }
    qDebug() << "Set S Var" << split[0] << "to" << MyGlobal.value(split[0]);
  }
  else if (MyStyle.contains(split[0])) {
    qDebug() << "MyStyle = " << split[0];
    QVariant myType = MyStyle.value(split[0]);
    int theType = myType.type();

    if (theType == 1) //Bool
    {
      bool b = (strcmp("true", split[1].toLocal8Bit()) == 0) ? true : false;
      MyStyle.insert(split[0], b);
    } else if (theType == 2) //Int
    {
      MyStyle.insert(split[0], split[1].toInt());
    } else if (theType == 6) //Double
    {
      MyStyle.insert(split[0], split[1].toDouble());
    } else if (theType == 10) //String
    {
      MyStyle.insert(split[0], split[1]);
    } else {
      qDebug() << "ERROR - Did not find a valid match for Type " << theType;
    }
    qDebug() << "Set G Var" << split[0] << "to" << MyStyle.value(split[0]);
  } else {
    qDebug() << "ERROR No item " << split[0] << " found in Style or Global";
  }

  QStringList lst;
  return lst;
}
