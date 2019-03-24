import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    property string vocabulary_title
    property alias native_word: nativeWordTextField.text
    property alias foreign_word: foreignWordTextField.text
    function save() {
        console.log("SAVE WORD")
    }
    ColumnLayout {
        anchors.centerIn: parent
        Text {
            text: "На родном языке"
        }
        TextField {
            id: nativeWordTextField
        }
        Text {
            text: "На иностранном"
        }
        TextField {
            id: foreignWordTextField
        }
    }
    // Здесь мы определяем фукнцию, вызываемую при клике по кнопке SAVE
    // универсального компонента SaveCancelContainer.
    Component.onCompleted: {
        parent.parent.parent.save = function() {
            controller.saveWord(vocabulary_title, native_word, foreign_word)
        }
    }
}
