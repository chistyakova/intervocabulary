import QtQuick 2.7
import QtQuick.Controls 1.4

Rectangle {
    color: "#eeffee"
    ListView {
        anchors.top: parent.top
        width: parent.width
        height: parent.height
        model: {
            var m = []
            var row = []
            for (var i=0; i<iconsModel.length; i++) {
                if (i%(controller.columns+1)) {
                    row.push(iconsModel[i])
                } else {
                    m.push(row)
                    row = []
                }
            }
            m
        }
        delegate: Rectangle {
            width: parent.width
            height: controller.tileSize
            Row {
                Repeater {
                    model:modelData
                    Image {
                        width: controller.tileSize
                        height: width
                        source: modelData
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                newTableIcon = modelData
                                stack.pop()
                            }
                        }
                    }
                }
            }
        }
    }
    Rectangle {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        width: controller.tileSize
        height: width
        color: "red"

        Text {
            anchors.centerIn: parent
            color: "yellow"
            text: "<"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                stack.pop()
            }
        }
    }
}
