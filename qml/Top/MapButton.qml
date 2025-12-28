import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Rectangle {
    id: button
    Layout.preferredWidth: 40
    Layout.preferredHeight: 40
    radius: 20
    color: mouseArea.pressed ? "#44FFFFFF" : (mouseArea.containsMouse ? "#22FFFFFF" : "transparent")
    border.color: "#33FFFFFF"
    border.width: 1

    // Dışarıdan ikon ve açıklama alabilmek için property'ler
    property string iconSource: ""
    property string tooltipText: ""

    signal clicked

    Image {
        id: icon
        anchors.centerIn: parent
        width: 24
        height: 24
        source: button.iconSource
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: button.clicked()
    }

    ToolTip.visible: mouseArea.containsMouse
    ToolTip.text: tooltipText
    ToolTip.delay: 300 // ms cinsinden gecikme süresi
}