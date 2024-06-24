pragma Singleton
import QtQuick
import QtQuick.Window

QtObject {
    property color backgroundColor: '#eee'
    property color phantomTextColor: "#dedede";
    property color weakTextColor: "#aaaaaa";
    property color strongTextColor: "#646464";
    property string fontFamily: "Source Code Pro"

    property int desktopHeight: Screen.desktopAvailableHeight
    property int desktopWidth: Screen.desktopAvailableWidth
    property real scale: Math.max(desktopHeight, desktopWidth) / 1920
    property real fontSize: 20 * scale
    property real radius: 20 * scale
}
