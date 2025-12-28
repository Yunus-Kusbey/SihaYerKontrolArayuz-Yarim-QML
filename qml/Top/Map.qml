import QtQuick 2.15
import QtQuick.Controls 2.15
import QtLocation 5.15
import QtPositioning 5.15
import QtQuick.Layouts 1.15

Map {
    id: map
    anchors.fill: parent

    //----------------------------------------------------------------
    // 1. GENEL AYARLAR VE ÖZELLİKLER
    //----------------------------------------------------------------

    // Başlangıç koordinatını bir property olarak tanımlayalım ki kolayca erişebilelim
    property var initialCoordinate: QtPositioning.coordinate(38.35, 38.33)

    // Tema değiştirme işlevi için property
    property bool isDarkMode: true

    plugin: Plugin {
        id: mapPlugin
        name: "osm" // Modern harita stilleri için Mapbox eklentisi
    }

    center: initialCoordinate
    zoomLevel: 14

    //----------------------------------------------------------------
    // 2. HARİTA ÜZERİNDEKİ GÖRSEL ELEMANLAR
    //----------------------------------------------------------------

    // -- Animasyonlu İşaretçi --
    MapQuickItem {
        coordinate: map.center
        anchorPoint.y: markerImage.height
        anchorPoint.x: markerImage.width / 2

        sourceItem: Image {
            id: markerImage
            source: "qrc:/icons/marker.png" // Özel bir marker ikonu kullanabilirsiniz
            width: 48
            height: 48
            smooth: true

            SequentialAnimation on opacity {
                loops: Animation.Infinite
                NumberAnimation { from: 1.0; to: 0.4; duration: 1500; easing.type: Easing.InOutQuad }
                NumberAnimation { from: 0.4; to: 1.0; duration: 1500; easing.type: Easing.InOutQuad }
                PauseAnimation { duration: 500 }
            }
        }
    }

    // -- Koordinatları Gösteren Panel --
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottomMargin: 20
        width: 300
        height: 40
        radius: 20
        color: "#AA000000"
        border.color: "#55FFFFFF"
        border.width: 1

        Text {
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 14
            text: "Lat: %1, Lon: %2".arg(map.center.latitude.toFixed(4)).arg(map.center.longitude.toFixed(4))
        }
    }

    //----------------------------------------------------------------
    // 3. KONTROL BUTONLARI
    //----------------------------------------------------------------
    Rectangle {
        id: buttonContainer
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.margins: 10
        width: 40
        height: childrenRect.height
        color: "#AA212121"
        radius: 24

        ColumnLayout {
            spacing: 4

            // Buton 1: Yakınlaş
            MapButton {
                iconSource: "qrc:/icon/home.png"
                onClicked: map.zoomLevel++
            }

            // Buton 2: Uzaklaş
            MapButton {
                iconSource: "qrc:/icon/home.png"
                onClicked: map.zoomLevel--
            }

            // Buton 3: Merkeze Dön
            MapButton {
                iconSource: "qrc:/icon/home.png"
                onClicked: map.center = initialCoordinate
            }

            // Buton 4: Tema Değiştir
            MapButton {
                iconSource: "qrc:/icon/home.png"
                tooltipText: "Tema Değiştir"
                onClicked: isDarkMode = !isDarkMode
            }

            // Buton 5: Konumum
            MapButton {
                iconSource: "qrc:/icon/home.png"
                onClicked: {
                    console.log("Konumum butonuna tıklandı!")
                    // Buraya konum servisinden koordinat alma kodu eklenebilir.
                }
            }
        }
    }
}