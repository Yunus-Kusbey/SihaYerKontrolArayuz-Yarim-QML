#pragma once
// backend.h

#ifndef CommandMission_H
#define CommandMission_H

#include <QObject>
#include <QString>

class CommandMission : public QObject
{
    Q_OBJECT
public:
    explicit CommandMission(QObject* parent = nullptr);

signals:
    // Bu sinyal, C++'tan QML'e anlýk durum bilgisi göndermek için kullanýlýr.
    void statusUpdated(const QString& message);

public slots:
    // Bu slot (fonksiyon), QML'deki butonlardan çaðrýlacak.
    void sendCommand(const QString& command);
};

#endif // BACKEND_H