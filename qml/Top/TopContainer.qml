// TopContainer.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: topContainer
    color: "black"

    property var backend

    RowLayout {
        anchors.fill: parent
        spacing: 0

        Map {
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        //MapButtons {
        //    Layout.preferredWidth: 20
        //    Layout.fillHeight: true
        //}
    }
}