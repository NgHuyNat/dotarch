import QtQuick
import Quickshell
import Quickshell.Hyprland

Item {
    Component.onCompleted: {
        for (var prop in Hyprland) {
            console.log(prop + ": " + typeof Hyprland[prop]);
        }
        Qt.quit();
    }
}
