# Resource object code (Python 3)
# Created by: object code
# Created by: The Resource Compiler for Qt version 6.9.1
# WARNING! All changes made in this file will be lost!

from PySide6 import QtCore

qt_resource_data = b"\
\x00\x00\x02\x1c\
#\
pragma once\x0d\x0a// \
backend.h\x0d\x0a\x0d\x0a#if\
ndef CommandMiss\
ion_H\x0d\x0a#define C\
ommandMission_H\x0d\
\x0a\x0d\x0a#include <QOb\
ject>\x0d\x0a#include \
<QString>\x0d\x0a\x0d\x0acla\
ss CommandMissio\
n : public QObje\
ct\x0d\x0a{\x0d\x0a    Q_OBJ\
ECT\x0d\x0apublic:\x0d\x0a  \
  explicit Comma\
ndMission(QObjec\
t* parent = null\
ptr);\x0d\x0a\x0d\x0asignals\
:\x0d\x0a    // Bu sin\
yal, C++'tan QML\
'e anl\xfdk durum b\
ilgisi g\xf6ndermek\
 i\xe7in kullan\xfdl\xfdr\
.\x0d\x0a    void stat\
usUpdated(const \
QString& message\
);\x0d\x0a\x0d\x0apublic slo\
ts:\x0d\x0a    // Bu s\
lot (fonksiyon),\
 QML'deki butonl\
ardan \xe7a\xf0r\xfdlacak\
.\x0d\x0a    void send\
Command(const QS\
tring& command);\
\x0d\x0a};\x0d\x0a\x0d\x0a#endif /\
/ BACKEND_H\
\x00\x00\x03\xd5\
/\
/ backend.cpp\x0d\x0a\x0d\
\x0a#include \x22comma\
nd_mission.h\x22\x0d\x0a\x0d\
\x0a#include <QDebu\
g>\x0d\x0a\x0d\x0aCommandMis\
sion::CommandMis\
sion(QObject* pa\
rent) : QObject(\
parent)\x0d\x0a{\x0d\x0a}\x0d\x0a\x0d\
\x0avoid CommandMis\
sion::sendComman\
d(const QString&\
 command)\x0d\x0a{\x0d\x0a  \
  // QML'den gel\
en komutu burada\
 i\xfeleyin.\x0d\x0a    /\
/ \xd6rne\xf0in, seri \
porta veri g\xf6nde\
rebilir, bir ser\
vise istek atabi\
lir\x0d\x0a    // veya\
 ba\xfeka bir C++ m\
od\xfcl\xfcn\xfc tetikley\
ebilirsiniz.\x0d\x0a\x0d\x0a\
    qDebug() << \
\x22QML'den komut a\
l\xfdnd\xfd:\x22 << comma\
nd;\x0d\x0a\x0d\x0a    if (c\
ommand == \x22START\
_MISSION\x22) {\x0d\x0a  \
      // ... G\xf6r\
evi ba\xfelatma kod\
lar\xfd ...\x0d\x0a      \
  emit statusUpd\
ated(\x22G\xf6rev ba\xfel\
at\xfdld\xfd.\x22); // QM\
L'e durum g\xfcncel\
lemesi g\xf6nder\x0d\x0a \
   }\x0d\x0a    else i\
f (command == \x22S\
TOP_MISSION\x22) {\x0d\
\x0a        // ... \
G\xf6revi durdurma \
kodlar\xfd ...\x0d\x0a   \
     emit status\
Updated(\x22G\xf6rev d\
urduruldu.\x22);\x0d\x0a \
   }\x0d\x0a    else i\
f (command == \x22R\
ETURN_HOME\x22) {\x0d\x0a\
        // ... E\
ve d\xf6n\xfc\xfe kodlar\xfd\
 ...\x0d\x0a        em\
it statusUpdated\
(\x22Eve d\xf6n\xfc\xfe modu\
 aktif.\x22);\x0d\x0a    \
}\x0d\x0a    else {\x0d\x0a \
       emit stat\
usUpdated(\x22Bilin\
meyen komut: \x22 +\
 command);\x0d\x0a    \
}\x0d\x0a}\
"

qt_resource_name = b"\
\x00\x06\
\x07\xa6\xc8\x95\
\x00s\
\x00o\x00u\x00r\x00c\x00e\
\x00\x11\
\x0b\xa59\xa8\
\x00c\
\x00o\x00m\x00m\x00a\x00n\x00d\x00_\x00m\x00i\x00s\x00s\x00i\x00o\x00n\x00.\x00h\
\
\x00\x13\
\x059\xbd0\
\x00c\
\x00o\x00m\x00m\x00a\x00n\x00d\x00_\x00m\x00i\x00s\x00s\x00i\x00o\x00n\x00.\x00c\
\x00p\x00p\
"

qt_resource_struct = b"\
\x00\x00\x00\x00\x00\x02\x00\x00\x00\x01\x00\x00\x00\x01\
\x00\x00\x00\x00\x00\x00\x00\x00\
\x00\x00\x00\x00\x00\x02\x00\x00\x00\x02\x00\x00\x00\x02\
\x00\x00\x00\x00\x00\x00\x00\x00\
\x00\x00\x00:\x00\x00\x00\x00\x00\x01\x00\x00\x02 \
\x00\x00\x01\x99\xf1\xf2R\x22\
\x00\x00\x00\x12\x00\x00\x00\x00\x00\x01\x00\x00\x00\x00\
\x00\x00\x01\x99\xf1\xf2\xbf\xf2\
"

def qInitResources():
    QtCore.qRegisterResourceData(0x03, qt_resource_struct, qt_resource_name, qt_resource_data)

def qCleanupResources():
    QtCore.qUnregisterResourceData(0x03, qt_resource_struct, qt_resource_name, qt_resource_data)

qInitResources()
