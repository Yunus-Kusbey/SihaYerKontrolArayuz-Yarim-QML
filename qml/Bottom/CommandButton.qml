//CommandButton.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Button {
    id: button

    // Dışarıdan alınacak özellikler
    property string command: ""
    property var backend
    property string iconSource: ""
    property color baseColor: "#333333"
    property color hoverColor: "#444444"
    property color pressedColor: "#222222"

    onClicked: {
        if (backend && command) {
            backend.sendCommand(command)
        }
    }

    // Butonun içeriğini tamamen kendimiz çiziyoruz
    contentItem: Item {
        implicitWidth: 120
        implicitHeight: 40

        RowLayout {
            anchors.fill: parent
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            spacing: 8

            Image {
                source: button.iconSource
                width: 20
                height: 20
                Layout.alignment: Qt.AlignVCenter
                fillMode: Image.PreserveAspectFit
            }

            Text {
                text: button.text
                color: "white"
                font.pixelSize: 13
                font.bold: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignVCenter
                elide: Text.ElideRight // Uzun metinler sığmazsa ... ile bitir
            }
        }
    }

    // Butonun arka planını ve animasyonlarını tanımlıyoruz
    background: Rectangle {
        // Renk, butonun durumuna göre (normal, hover, basılı) değişir
        color: button.pressed ? button.pressedColor : (button.hovered ? button.hoverColor : button.baseColor)
        radius: 8
        border.color: Qt.darker(color, 1.5)
        border.width: 1

        // Renk değişimini yumuşak hale getiren animasyon
        Behavior on color {
            ColorAnimation { duration: 150 }
        }
    }

    // Tıklama efekti için butonu hafifçe küçültüyoruz
    scale: pressed ? 0.98 : 1.0
    Behavior on scale {
        NumberAnimation { duration: 100 }
    }
}