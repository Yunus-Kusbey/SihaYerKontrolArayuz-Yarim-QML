// CommandPanel.qml
import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

GroupBox {
    id: commandPanel
    property int currentMenu: -1

    label: Text {
        text: commandPanel.title
        color: "#ccc"
        font.pixelSize: 16
        font.bold: true
        padding: 10
    }

    background: Rectangle {
        color: "transparent"
        radius: 10
        border.color: "#444"
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        // --- MENÜ ÇUBUĞU ---
        RowLayout {
            id: menuBar
            Layout.fillWidth: true
            spacing: 4

            function showMenu(index) {
                commandPanel.currentMenu = commandPanel.currentMenu === index ? -1 : index
            }

            CommandMenuButton { text: "Dosya";   menuIndex: 0; onMenuActivatedCallback: menuBar.showMenu }
            CommandMenuButton { text: "Görünüm"; menuIndex: 1; onMenuActivatedCallback: menuBar.showMenu }
            CommandMenuButton { text: "Ayarlar"; menuIndex: 2; onMenuActivatedCallback: menuBar.showMenu }
            CommandMenuButton { text: "Araçlar"; menuIndex: 3; onMenuActivatedCallback: menuBar.showMenu }
            CommandMenuButton { text: "Yardım";  menuIndex: 4; onMenuActivatedCallback: menuBar.showMenu }
            CommandMenuButton { text: "Kapat";   menuIndex: 5; onMenuActivatedCallback: menuBar.showMenu }
        }

        // --- DEĞİŞEN IZGARA ALANI ---
        Rectangle {
            id: menuContent
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 8
            color: "transparent"
            border.color: "#3a3a3a"

            Loader {
                id: gridLoader
                anchors.fill: parent
                sourceComponent: {
                    switch (commandPanel.currentMenu) {
                        case 0: return dosyaGrid
                        case 1: return gorunumGrid
                        case 2: return ayarlarGrid
                        case 3: return araclarGrid
                        case 4: return yardimGrid
                        case 5: return kapatGrid
                        default: return null
                    }
                }
            }
        }
    }

    // === GRİDLER ===
    Component {
        id: dosyaGrid
        GridLayout {
            anchors.fill: parent; anchors.margins: 12
            columns: 3; rowSpacing: 8; columnSpacing: 8
            Button { text: "Yeni Görev"; onClicked: console.log("Yeni görev oluşturuldu") }
            Button { text: "Görev Yükle"; onClicked: console.log("Yüklendi") }
            Button { text: "Kaydet"; onClicked: console.log("Kaydedildi") }
            Button { text: "Dışa Aktar"; onClicked: console.log("Dışa aktarıldı") }
            Button { text: "Kapat"; onClicked: commandPanel.currentMenu = -1 }
        }
    }

    Component {
        id: gorunumGrid
        GridLayout {
            anchors.fill: parent; anchors.margins: 12
            columns: 2; rowSpacing: 8; columnSpacing: 8
            CheckBox { text: "Tam Ekran" }
            CheckBox { text: "Koyu Tema"; checked: true }
            CheckBox { text: "3D Model Görünümü" }
            CheckBox { text: "HUD Göster" }
        }
    }

    Component {
        id: ayarlarGrid
        GridLayout {
            anchors.fill: parent; anchors.margins: 12
            columns: 2; rowSpacing: 8; columnSpacing: 8
            Button { text: "Bağlantı Ayarları" }
            Button { text: "Simülasyon Parametreleri" }
            Button { text: "Telemetri Ayarları" }
            Button { text: "Video Ayarları" }
        }
    }

    Component {
        id: araclarGrid
        GridLayout {
            anchors.fill: parent; anchors.margins: 12
            columns: 3; rowSpacing: 8; columnSpacing: 8
            Button { text: "Kalibrasyon Sihirbazı" }
            Button { text: "Teşhis Raporu" }
            Button { text: "Log Görüntüle" }
        }
    }

    Component {
        id: yardimGrid
        GridLayout {
            anchors.fill: parent; anchors.margins: 12
            columns: 2; rowSpacing: 8; columnSpacing: 8
            Button { text: "Belgeler" }
            Button { text: "Kısayollar" }
            Button { text: "Hakkında" }
        }
    }

    Component {
        id: kapatGrid
        GridLayout {
            anchors.fill: parent; anchors.margins: 12
            columns: 1
            Button {
                text: "Programı Kapat"
                onClicked: Qt.quit()
            }
        }
    }
}
