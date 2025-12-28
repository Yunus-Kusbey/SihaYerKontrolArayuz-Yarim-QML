import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Item {
    id: hud3DLabel
    property string label: ""
    property string value: ""
    property color valueColor: "white"
    property color labelColor: "#aaaaaa"
    property bool warning: false   // ek özellik: uyarı durumları için

    width: 120
    height: 50

    Column {
        anchors.fill: parent
        spacing: 2

        Text {
            text: root.label
            font.bold: true
            font.pixelSize: 12
            color: root.labelColor
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            width: parent.width
            height: 24
            radius: 4
            color: warning ? "#442222" : "transparent"
            border.color: warning ? "#ff4444" : "transparent"

            Text {
                anchors.centerIn: parent
                text: root.value
                color: root.valueColor
                font.pixelSize: 14
                font.bold: true
            }
        }
    }
}