// CommandMenuButton.qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Button {
    id: button
    property int menuIndex: -1
    property var onMenuActivatedCallback

    onClicked: {
        onMenuActivatedCallback(menuIndex)
    }

    contentItem: Text {
        text: button.text
        color: button.hovered ? "#ffffff" : "#bbbbbb"
        font.pixelSize: 13
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    background: Rectangle {
        color: button.hovered ? "#4a4a4a" : "transparent"
        radius: 4
        Behavior on color { ColorAnimation { duration: 150 } }
    }
}
