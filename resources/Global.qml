pragma Singleton
import QtQuick
import QtQuick.Window

QtObject {
    id: root
    property color backgroundColor: '#ffffff'
    property color phantomTextColor: '#dedede';
    property color weakTextColor: '#aaaaaa';
    property color strongTextColor: '#444444';
    property color infoColor: '#aaccff';
    property color successColor: '#88ffaa'
    property color warningColor: '#ffff88';
    property color errorColor: '#ff8888'
    property string fontFamily: 'Source Code Pro'
    property int animationDuration: 200

    property int desktopHeight: Screen.desktopAvailableHeight
    property int desktopWidth: Screen.desktopAvailableWidth
    property real scale: Math.max(desktopHeight, desktopWidth) / 1920
    property real fontSize: 20 * scale
    property real largeRadius: 20 * scale
    property real smallRadius: 10 * scale
}
