// backend.cpp

#include "command_mission.h"

#include <QDebug>

CommandMission::CommandMission(QObject* parent) : QObject(parent)
{
}

void CommandMission::sendCommand(const QString& command)
{
    // QML'den gelen komutu burada iþleyin.
    // Örneðin, seri porta veri gönderebilir, bir servise istek atabilir
    // veya baþka bir C++ modülünü tetikleyebilirsiniz.

    qDebug() << "QML'den komut alýndý:" << command;

    if (command == "START_MISSION") {
        // ... Görevi baþlatma kodlarý ...
        emit statusUpdated("Görev baþlatýldý."); // QML'e durum güncellemesi gönder
    }
    else if (command == "STOP_MISSION") {
        // ... Görevi durdurma kodlarý ...
        emit statusUpdated("Görev durduruldu.");
    }
    else if (command == "RETURN_HOME") {
        // ... Eve dönüþ kodlarý ...
        emit statusUpdated("Eve dönüþ modu aktif.");
    }
    else {
        emit statusUpdated("Bilinmeyen komut: " + command);
    }
}