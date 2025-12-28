// HUDContainer.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: bottomContainer
    color: Qt.rgba(0, 0, 0, 0.5)

    property var backend

    RowLayout {
        anchors.fill: parent
        spacing: 5

        CameraPanel {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width / 3.7
        }

        Hud3D {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width / 2.5

        }

        CommandPanel {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width / 4.55
            //backend: hudContainer.backend
        }
    }
}