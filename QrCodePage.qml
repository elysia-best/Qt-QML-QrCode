import QtQuick
import QtQuick.Controls.Basic
import QtQuick.Layouts
import QtQuick.Shapes
import "qrcode.js" as QrCodeLib

Rectangle {
    id: page

    color: "#f3f5f7"
    property string qrPath: ""
    property string errorText: ""

    function updateQrCode(text) {
        try {
            qrPath = QrCodeLib.QRCode.createPath(text)
            errorText = ""
        } catch (error) {
            qrPath = ""
            errorText = qsTr("地址过长，无法生成二维码")
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 28
        spacing: 18

        Label {
            text: qsTr("网页二维码")
            color: "#18212b"
            font.pixelSize: 24
            font.weight: Font.DemiBold
            Layout.alignment: Qt.AlignHCenter
        }

        Label {
            text: qsTr("输入网页地址，生成可扫描的二维码")
            color: "#596675"
            font.pixelSize: 14
            Layout.alignment: Qt.AlignHCenter
        }

        TextField {
            id: addressField
            text: "https://www.qt.io"
            placeholderText: qsTr("https://example.com")
            selectByMouse: true
            onTextEdited: page.updateQrCode(text)
            Layout.fillWidth: true
        }

        Rectangle {
            color: "white"
            radius: 8
            border.color: "#dce2e8"
            border.width: 1
            Layout.alignment: Qt.AlignHCenter
            Layout.preferredWidth: 280
            Layout.preferredHeight: 280

            Shape {
                anchors.centerIn: parent
                width: 256
                height: 256

                ShapePath {
                    fillColor: "#111820"
                    strokeColor: "transparent"
                    PathSvg {
                        path: page.qrPath
                    }
                }
            }
        }

        Label {
            text: page.errorText
            color: "#b42318"
            visible: page.errorText.length > 0
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
        }

        Item {
            Layout.fillHeight: true
        }
    }

    Component.onCompleted: updateQrCode(addressField.text)
}
