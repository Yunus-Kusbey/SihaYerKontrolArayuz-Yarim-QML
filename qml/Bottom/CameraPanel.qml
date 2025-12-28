// CameraPanel.qml
import QtQuick
import QtQuick.Controls
import QtMultimedia

Rectangle {
    id: cameraPanel
    color: Qt.rgba(0, 0, 0, 0.5)

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
        // source: camera
    }

    Label {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 5
        text: "Kamera Görüntüsü"
        color: "white"
        font.pixelSize: 12
        background: Rectangle {
            color: "#66000000"
            radius: 3
        }
        padding: 5
    }
}