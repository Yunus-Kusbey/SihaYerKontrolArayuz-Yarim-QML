import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Button {
    id: button

    // Dışarıdan açılacak menüyü alması için
    property Menu menu

    // Tıklanınca menüyü butonun altında aç
    onClicked: {
        if (menu) {
            menu.popup()
        }
    }

    // Butonun içeriği (metin)
    contentItem: Text {
        text: button.text
        color: button.hovered ? "#ffffff" : "#bbbbbb"
        font.pixelSize: 13
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    // Butonun arka planı
    background: Rectangle {
        color: button.hovered ? "#4a4a4a" : "transparent"
        radius: 4
        
        Behavior on color { ColorAnimation { duration: 150 } }
    }
}