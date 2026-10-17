import QtQuick
import QtQuick.Controls.Basic

ApplicationWindow {
    width: 520
    height: 560
    minimumWidth: 360
    minimumHeight: 480
    visible: true
    title: qsTr("网页二维码")

    QrCodePage {
        anchors.fill: parent
    }
}
