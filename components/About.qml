import QtQuick 2.0

Item {
    property Item header: Component {
        Rectangle {
            anchors.fill: parent
            Text {
                anchors.centerIn: parent
                text: "О программе"
            }
        }
    }
    property Item body: Component {
        Rectangle {
            anchors.fill: parent
            color: "yellow"
            Text {
                anchors.centerIn: parent
                text: "Тут должена быть информация о программе"
            }
        }
    }
}
