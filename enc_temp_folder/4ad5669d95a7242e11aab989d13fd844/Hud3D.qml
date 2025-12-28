// InfoDisplay3D.qml
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick3D
import QtQuick3D.Helpers
import Qt5Compat.GraphicalEffects

Rectangle {
    id: hud
    color: "transparent"
    radius: 12



    property color hudColor: "#00f7c8"
    // C++ tarafý bunlarý set ediyor:
    property real rollDeg: 0      // roll (kanat yuvarlanmasý)
    property real pitchDeg: 0    // pitch (burun yukarý-aþaðý)
    property real yawDeg: 0       // yaw (sað-sol yönelim)
    property real airspeed: 0
    property real altitude: 0

    Rectangle {
        anchors.fill: parent
        radius: 12
        color: "#0a0f14cc"
    }
     // === Heading Tape===
    // Ýpucu: Þeridin kesintisiz dönmesi için yan yana iki adet resim 
    // veya çok uzun bir Image kullanabilirsiniz.
    Image {
        
        id: compassTape
        source: "qrc:/icon/compass-dark.png" // 0-360 derece yazýlý ince uzun bir þerit
        height: parent.height *2
        anchors.left:parent.left
        anchors.top: parent.top
        width:parent.width * 2
        fillMode: Image.PreserveAspectFit
        z:5
        // Matematiksel Kaydýrma:
        // yawDeg 0 iken þeridin tam ortasý (180 derece) merkezde olsun diyorsak:
        // x = (GörünürGeniþlik / 2) - (yawDeg * dereceBaþýnaPiksel)
        readonly property real degreeWidth: 4.37 // Her 1 derece kaç piksel?
        x: (hdgContainer.width / 2) - (yawDeg * degreeWidth)

        Behavior on x {
        NumberAnimation {
            duration: 100
            easing.type: Easing.OutCubic}
        }
    }
    View3D {
        anchors.fill: parent
        anchors.margins: 0
        camera: cam

        environment: SceneEnvironment {
            clearColor: "skyBlue"
            backgroundMode: SceneEnvironment.Color
            antialiasingMode: SceneEnvironment.MSAA
            antialiasingQuality: SceneEnvironment.Medium
        }
        

        Model {
        source: "#Cube"
        scale: Qt.vector3d(500, 1, 500)   // geniþlik ve derinlik
        position: Qt.vector3d(0, -140, 0)  // biraz aþaðýya koy
        materials: PrincipledMaterial {
            baseColor: "#A0522D"   // sýcak toprak rengi
        roughness: 0.9         // mat görünüm
        metalness: 0.0         // metalik deðil
        emissiveFactor: 0.05 
        }
    }

        PerspectiveCamera {
            id: cam
            // Uçaðýn arkasýnda duran sabit kamera
            position: Qt.vector3d(0, 10, 80)
            eulerRotation.x: -10        // biraz aþaðý baksýn
            eulerRotation.y: 0
            eulerRotation.z: 0
            clipNear: 1
            clipFar: 1000
            fieldOfView: 65
        }
        DirectionalLight {
    eulerRotation.x: -90   // ýþýðý aþaðýya yönlendir
    brightness: 2.0
}



        // Uçak modeli – C++ roll/pitch/yaw ile hareket edecek
        Model {
            id: aircraft
            source: "qrc:/icon/ucak.mesh"
            scale: Qt.vector3d(0.05, 0.05, 0.05)
            position: Qt.vector3d(0, 0, 0)

            // Mesh'in kendi eksenini düzeltmek için temel açýlar
            // (bunlar sadece ilk “doðru duruþu” ayarlýyor)
            property real basePitch: -90     // sen daha önce x:-90 kullanmýþtýn
            property real baseYaw: 270      // kameraya sýrtýný dönsün (tail kamera tarafýnda)

            // NOT: QtQuick3D’de tipik mapping:
            //  X: pitch,  Y: yaw,  Z: roll
            eulerRotation: Qt.vector3d(
                basePitch + pitchDeg,    // pitch -> X
                baseYaw + yawDeg,        // yaw   -> Y  (180 + yaw = kameraya sýrtý dönük)
                rollDeg                  // roll  -> Z
            )

            materials: PrincipledMaterial {
                
                baseColor: "white"          // Rengi buradan deðiþtir
                roughness: 0.4            // Mat/parlaklýk ayarý
                metalness: 0.1            // Metalik görünüm
                emissiveFactor: 0.0       // Parlama etkisi
    

            }
        }

        // Pitch ladder
        Repeater {
            model: [-30,-20,-10,0,10,20,30]
            Model {
                source: "#Rectangle"
                scale: Qt.vector3d(60, 0.04, 1)
                y: modelData * 2
                materials: PrincipledMaterial { baseColor: hudColor; emissiveFactor: 0.2 }
                visible: modelData !== 0
            }
        }
    }




// Sabit Merkez Göstergesi (Üçgen)
    Rectangle {
        id: centerPointer
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: 2; height: 10
        color: "white"
        z: 5 // Her zaman üstte kalsýn
    }


// === GLOBAL METRIC BOX ===
Component {
    id: metricBox
    GridLayout {
        id: root
        columns: 2
        columnSpacing: 6
        rowSpacing: 0

        // Dýþarýdan doldurulacak alanlar
        property string label: ""
        property string value: ""
        property string unit: ""
        property color valueColor: hudColor
        property color labelColor: hudColor

        // SOL: LABEL
        Text {
            text: root.label
            color: labelColor
            font.pixelSize: 11
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
        }

        // SAÐ: VALUE + UNIT
        RowLayout {
            
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            spacing: 3

            Text {
                text: root.value
                color: root.valueColor
                font.pixelSize: 16
                font.bold: true
            }
            Text {
                text: root.unit
                color: "#cccccc"
                font.pixelSize: 11
            }
        }
    }
}


// === SOL BÝLGÝ BLOÐU (Ýrtifa, Þarj, GPS, Wifi, Telemetri) ===
Rectangle {
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.topMargin: 60
    anchors.leftMargin: 12
    anchors.verticalCenter: parent.verticalCenter
    width: 140
    radius: 10
    color: "#0a0f1499"
    border.color: "#444"
    border.width: 1
    z: 10

    Column {
        anchors.margins: 10
        anchors.fill: parent
        spacing: 6

        // ÝRTÝFA
        Loader {
            sourceComponent: metricBox
            onLoaded: {
                item.label = "Ýrtifa"
                item.unit  = "m"
                item.valueColor = "#00ff66"
                item.labelColor="#00BFF"
                item.value = Qt.binding(function() {
                    return altitude.toFixed(1)
                })
            }
        }

        // ÞARJ
        Loader {
            sourceComponent: metricBox
            onLoaded: {
                item.label = "Þarj"
                item.unit  = "%"
                item.valueColor = "#ffcc00"
                item.labelColor="#FFD700"
                item.value = Qt.binding(function() {
                    return batteryPercent.toFixed(0)
                })
            }
        }

        // GPS
        Loader {
            sourceComponent: metricBox
            onLoaded: {
                item.label = "GPS"
                item.unit  = ""
                item.valueColor = hudColor
                item.labelColor="#32CD32"
                item.value = Qt.binding(function() {
                    return gpsCount.toString()
                })
            }
        }

        // Wifi
        Loader {
            sourceComponent: metricBox
            onLoaded: {
                item.label = "Wifi"
                item.unit  = "%"
                item.valueColor = hudColor
                item.labelColor="#1E90FF"
                item.value = Qt.binding(function() {
                    return wifiQuality.toFixed(1)
                })
            }
        }

        // Telemetri
        Loader {
            sourceComponent: metricBox
            onLoaded: {
                item.label = "Telemetri"
                item.unit  = ""
                item.labelColor="#FF8C00"
                item.value = Qt.binding(function() {
                    return telemetryOk ? "True" : "False"
                })
                item.valueColor = Qt.binding(function() {
                    return telemetryOk ? "#00ff66" : "red"
                })
            }
        }
    }
}

// === SAÐ BÝLGÝ BLOÐU (Ev Mesafesi, Mod, Uçuþ Süresi) ===
Rectangle {
    anchors.right: parent.right
    anchors.rightMargin: 12
    anchors.top: parent.top
    anchors.topMargin: 60
    anchors.verticalCenter: parent.verticalCenter
    width: 160
    radius: 10
    color: "#0a0f1499"
    border.color: "#444"
    border.width: 1
    z: 10

    Column {
        anchors.margins: 10
        anchors.fill: parent
        spacing: 6
         // Hýz
        Loader {
            sourceComponent: metricBox
            onLoaded: {
                item.label = "Hýz"
                item.unit  = "m"
                item.valueColor = hudColor
                item.labelColor="#DC143C"
                item.value = Qt.binding(function() {    
                    return homeDistance.toFixed(1)
                })
            }
        } // RPM
        Loader {
            sourceComponent: metricBox
            onLoaded: {
                item.label = "RPM"
                item.unit  = "m"
                item.valueColor = hudColor
                item.labelColor="#8B0000"
                item.value = Qt.binding(function() {
                    return homeDistance.toFixed(1)
                })
            }
        }
        // Ev Mesafesi
        Loader {
            sourceComponent: metricBox
            onLoaded: {
                item.label = "Ev Mesafesi"
                item.unit  = "m"
                item.valueColor = hudColor
                item.labelColor="#20B2AA"
                item.value = Qt.binding(function() {
                    return homeDistance.toFixed(1)
                })
            }
        }

        // Mod
        Loader {
            sourceComponent: metricBox
            onLoaded: {
                item.label = "Mod"
                item.unit  = ""
                item.valueColor = "#ffd700"
                item.labelColor="#615ACD"
                item.value = Qt.binding(function() {
                    return flightMode.length > 0 ? flightMode : "YOK"
                })
            }
        }

        // Uçuþ Süresi
        Loader {
            sourceComponent: metricBox
            onLoaded: {
                item.label = "Uçuþ Süresi"
                item.unit  = ""
                item.valueColor = "#ffffff"
                item.labelColor="#708090"
                item.value = Qt.binding(function() {
                    return flightTime    // "00:00:00" string'i
                })
            }
        }
    }
}

// === ALT BÝLGÝ ÇUBUÐU (Roll / Pitch / Yaw) ===
Rectangle {
    anchors.left:parent.left
    anchors.leftMargin:parent.width/3
    anchors.top: parent.top
    anchors.topMargin:180
    width: 200
    height:25
    radius:10
    color: Qt.rgba(0, 0, 0, 0.5)


    Row {
        anchors.fill:parent
        anchors.leftMargin:10
        spacing: 40
        
        Loader {
            sourceComponent: metricBox
            onLoaded: {
                item.label = "Roll"
                item.unit  = ""
                item.valueColor = "#ffd700"
                item.labelColor="#FF4500"
                item.value = Qt.binding(function() {
                    return flightMode.length > 0 ? flightMode : "YOK"
                })
            }
        }
        Loader {
            sourceComponent: metricBox
            onLoaded: {
                item.label = "Pitch"
                item.unit  = ""
                item.valueColor = "#ffd700"
                item.labelColor="#00CED1"
                item.value = Qt.binding(function() {
                    return flightMode.length > 0 ? flightMode : "YOK"
                })
            }
        }
        Loader {
            sourceComponent: metricBox
            onLoaded: {
                item.label = "Yaw"
                item.unit  = ""
                item.valueColor = "#ffd700"
                item.labelColor="#9370DB"
                item.value = Qt.binding(function() {
                    return flightMode.length > 0 ? flightMode : "YOK"
                })
            }
        }
    }
}



}