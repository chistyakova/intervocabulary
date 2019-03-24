import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    property string own
    property string foreign
    function save() {
        console.log("SAVE WORD")
    }
    ColumnLayout {
        anchors.centerIn: parent
        Text {
            text: "На родном языке"
        }
        TextField {
            text: parent.own
        }
        Text {
            text: "На иностранном"
        }
        TextField {
            text: parent.foreign
        }
    }
}
//onClicked: controller.addNewWord(newWordNative.text, newWordTranslation.text)

