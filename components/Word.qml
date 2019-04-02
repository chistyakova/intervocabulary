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
    Column {
        anchors.bottom: parent.verticalCenter
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 5
        anchors.margins: 5
        Text {
            width: parent.width
            text: "На родном языке"
        }
        TextField {
            placeholderText: qsTr("Слово")
            width: parent.width
            id: nativeWordTextField
        }
        Text {
            width: parent.width
            text: "На иностранном"
        }
        TextField {
            placeholderText: qsTr("Перевод")
            width: parent.width
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
