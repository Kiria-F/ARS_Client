import QtQuick

Text {
    id: root

    property real sizeScale: 1

    color: Global.weakTextColor
    font {
        family: Global.fontFamily
        pixelSize: Global.fontSize * root.sizeScale
        bold: true
    }
}
