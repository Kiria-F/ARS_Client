import QtQuick

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Allocated Rendering System")
    color: Global.backgroundColor

    Login {
        anchors.centerIn: parent
    }
}
