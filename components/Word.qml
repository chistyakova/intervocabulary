import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    property string vocabulary
    property alias own: ownTextField.text
    property alias foreign: foreignTextField.text
    function save() {
        console.log("SAVE WORD")
    }
    ColumnLayout {
        anchors.centerIn: parent
        Text {
            text: "На родном языке"
        }
        TextField {
            id: ownTextField
        }
        Text {
            text: "На иностранном"
        }
        TextField {
            id: foreignTextField
        }
    }
    // Здесь мы определяем фукнцию, вызываемую при клике по кнопке SAVE
    // универсального компонента SaveCancelContainer.
    Component.onCompleted: {
        parent.parent.parent.save = function() {
            controller.saveWord(vocabulary, own, foreign)
        }
    }
}
