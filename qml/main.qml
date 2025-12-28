import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Layouts 1.15

import "qrc:/qml/Top"
import "qrc:/qml/Bottom"

Window {
    width: 1920
    height: 1080
    title: qsTr("Ana Arayüz")

    // --- DEÐÝÞÝKLÝK BURADA ---
    // 'visible: true' ve 'windowState: Qt.WindowFullScreen' satýrlarý yerine
    // daha uyumlu olan 'visibility' özelliðini kullanýyoruz.
    // Bu, pencereyi hem görünür yapar hem de tam ekrana alýr.
    visibility: Window.FullScreen

    // Küçültme butonunu kapatan bu ayar doðrudur ve kalmalýdýr.
    flags: Qt.Window | Qt.WindowCloseButtonHint | Qt.WindowMaximizeButtonHint

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        TopContainer {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        BottomContainer {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height / 3.4
        }
    }
}