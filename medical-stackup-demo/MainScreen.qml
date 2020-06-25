import QtQuick 2.9
import QtQuick 2.12
import QtQuick.Window 2.2
import QtCharts 2.2
import QtQuick.Controls 2.3
import QtPositioning 5.4
import QtSensors 5.9
import QtQuick.Scene2D 2.9
import QtQuick 2.1
import QtQuick.Layouts 1.11
import QtQuick 2.9
import QtQuick.Window 2.12
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls.Private 1.0
import QtGraphicalEffects 1.12
import QtQuick.Controls 2.12

import "."

Window {
    id: mainWindow
    visible: true
    width: MyGlobal.screenWidth
    height: MyGlobal.screenHeight
    color: MyStyle.backgroundColor
    title: qsTr("Reach Technologies -- Medical Demo")

    property int theValue: MyGlobal.screenFactor

    property int fontSize80: theValue / 6
    property int fontSize60: theValue / 8
    property int fontSize50: theValue / 10
    property int fontSize40: theValue / 12
    property int fontSize35: theValue / 14
    property int fontSize32: theValue / 15
    property int fontSize30: theValue / 16
    property int fontSize25: theValue / 19
    property int fontSize24: theValue / 20
    property int fontSize20: theValue / 24
    property int fontSize18: theValue / 27
    property int fontSize14: theValue / 34
    property int fontSize13: theValue / 37
    property int fontSize12: theValue / 40
    property int fontSize11: theValue / 44
    property int fontSize10: theValue / 48
    property int fontSize8: theValue / 60
    property int fontSize6: theValue / 80
    property int fontSize5: theValue / 96
    property int fontSize2: theValue / 240

    property int boxSize: theValue / 6
    property int boxSize1: theValue / 5
    property int textMargin: fontSize12 / 2
    property int mainLeftMargin: fontSize30
    property int column1: fontSize80 + fontSize40 + fontSize24
    property int myBarNum: 20
    property int myBarSpace: fontSize2
    property int myBarHeight: fontSize8
    property int myBarBase: myBarNum * (myBarSpace + myBarHeight)

    signal submitTextField(string text)

    //  StackLayout {
    //    id: stackMain
    //    currentIndex: 0

    Rectangle {
        id: main
        signal sendPreviousScreen(int screen)
        signal startAnimation()

        width: MyGlobal.screenWidth
        height: MyGlobal.screenHeight

        anchors {
            top: parent.top
            left: parent.left
        }


        FontLoader {
            id: sourceSansLight;
            source: "Fonts/SourceSansPro-Light.otf";
        }

        property
        var screen: {
            "main": 0,
            "schedule": 1,
            "patients": 2,
            "alarm": 3
        }

        property int buttonsAnimationX: 760
/*        property color mustard: "#c2b59b"
        property color purple: "#662D91"
        property color green: "#39B54A"
        property color blue: "#2075BC"
        //property color textButtoncolor: MyStyle.propertyValueColor
*/

        property int circleDuration: 10
        property int gifDuration: 150
        property int gifDelay: 10
        property int textDuration: 20
        property int textDelay: 10

        property string gender: "Male"
        property var patientObj

        property double subTextOpacity: 0.8
        property int opacityAnimation: 0

        function receivePatientInfo(patientJSON) { //TO DO: change to patientInfo (object)
            patientObj = JSON.parse(patientJSON);
            patient = patientObj;
        }

        function restartYAnimations() {
            patientAnimation.restart();
            secondRowAnimation.restart();
            conditionRowAnimation.restart();
            greenDotAnimation.restart();
            hospitalAnimation.restart();
            paNumAnimation.restart();
            clockAnimation.restart();
        }

        function restartOpacityAnimations() {

            gifAnimation.restart();
            circleAnimation.restart();
            textAnimation.restart();
            valueAnimation.restart();
            bloodPressureLeftAnimation.restart()
            bloodPressureRightAnimation.restart()
            buttonAnimation.restart()
            alarmButtonAnimation.restart()
            temperatureAnimation.restart()
        }

        function initializeOpacity() {
            //Initialize the target elements on opacity 0
            gifEKGLine.opacity = 0;
            gifPulseLine.opacity = 0;
            greenCircle.opacity = 0;
            purpleCircle.opacity = opacityAnimation;
            blueCircle.opacity = opacityAnimation;
            textEKG.opacity = opacityAnimation;
            textEKGValue.opacity = opacityAnimation;
            textBMP.opacity = opacityAnimation;
            textPulse.opacity = opacityAnimation;
            textPulseValue.opacity = opacityAnimation;
            textSpO.opacity = opacityAnimation;
            textInsulinPump.opacity = opacityAnimation;
            textUHr.opacity = opacityAnimation;
            insulinP.opacity = opacityAnimation;
            temperatureLeft.opacity = opacityAnimation;
            temperatureRight.opacity = opacityAnimation;
            salineTimer.sliderNumber = 25;
        }


        function restartSliders() {
            console.log("RESTART SLIDERS");
            for (var i = 0; i < 25; ++i) {
                if (repeater.itemAt(i) !== null) {
                    repeater.itemAt(i).color = MyGlobal.barGraphOffColor
                }

                if (repeater1.itemAt(i) !== null) {
                    repeater1.itemAt(i).color = MyGlobal.barGraphOffColor
                }

                if (repeater2.itemAt(i) !== null) {
                    repeater2.itemAt(i).color = MyGlobal.barGraphOffColor
                }
            }
            salineAnimation.restart()
            salineTimer.restart()
            salineTextAnimation.restart()

            hicorAnimation.restart()
            hicorTimer.restart()
            hicorTextAnimation.restart()

            glucagonAnimation.restart()
            glucagonTimer.restart()
            glucagonTextAnimation.restart()

        }

        function receiveAnimation() {
            initializeOpacity();
            restartYAnimations();
            restartOpacityAnimations();
            restartSliders();
        }

        color: MyStyle.backgroundColor


        //----- Patient Info
        Rectangle {
            id: topRow
            height: MyGlobal.screenHeight / 6
            width: MyGlobal.screenWidth

            Rectangle {
                id: patientBox
                anchors.left: parent.left
                width: MyGlobal.screenWidth / 3 //- fontSize40
                height: parent.height
                color: MyStyle.backgroundColor

                Text {
                    anchors {
                        bottom: parent.bottom
                        bottomMargin: fontSize50
                        left: parent.left
                        leftMargin: fontSize12
                    }

                    objectName: "textPatientName"
                    id: textPatientName
                    color: MyStyle.titleColor
                    text: MyGlobal.patientName
                    font.pixelSize: fontSize20
                }

                Text {
                    objectName: "textPatientGender"
                    id: textPatientGender
                    anchors {
                        bottom: parent.bottom
                        bottomMargin: fontSize25
                        left: parent.left
                        leftMargin: mainLeftMargin
                    }

                    color: MyStyle.propertyValueColor
                    text: MyGlobal.patientGender
                    font.pixelSize: fontSize14
                }

                Text {
                    id: textPatientAgeTitle
                    anchors {
                        bottom: textPatientGender.bottom
                        right: textPatientAgeValue.left
                        rightMargin: fontSize11
                    }

                    color: MyStyle.propertyTitleColor
                    text: qsTr("Age:")
                    font.pixelSize: fontSize13
                }

                Text {
                    objectName: "textPatientAge"
                    id: textPatientAgeValue
                    anchors {
                        bottom: textPatientGender.bottom
                        left: parent.left
                        leftMargin: column1
                    }
                    color: MyStyle.propertyValueColor
                    text: MyGlobal.patientAge
                    font.pixelSize: fontSize14
                }

                //Patient Condition
                Rectangle {
                    id: rectCond
                    anchors {
                        bottom: parent.bottom
                        left: parent.left
                        leftMargin: mainLeftMargin
                    }

                    radius: width / 2
                    color: MyGlobal.patientConditionColor
                    width: fontSize18
                    height: width
                    smooth: true
                } //Icon rectangle

                Text {
                    id: textCondition
                    anchors {
                        bottom: rectCond.bottom
                        right: textConditionValue.left
                        rightMargin: fontSize11
                    }
                    color: MyStyle.propertyTitleColor
                    text: "Condition:"
                    font.pixelSize: fontSize13
                }

                Text {
                    objectName: "textConditionValue"
                    id: textConditionValue
                    anchors {
                        bottom: rectCond.bottom
                        left: parent.left
                        leftMargin: column1
                    }
                    color: MyStyle.propertyValueColor
                    text: MyGlobal.patientCondition
                    font.pixelSize: fontSize14
                }
            } //Patient Box rectangle

            Rectangle {
                id: admitBox
                color: MyStyle.backgroundColor
                anchors.left: patientBox.right
                anchors.bottom: patientBox.bottom
                width: MyGlobal.screenWidth / 3 + 25
                height: parent.height

                Text {
                    objectName: "paNumValue"
                    id: paNumValue
                    anchors {
                        bottom: parent.bottom
                        bottomMargin: fontSize50
                        left: parent.left
                    }
                    color: MyStyle.titleColor
                    text: MyGlobal.patientNumber
                    renderType: Text.NativeRendering
                    font.pixelSize: fontSize18
                }
                NumberAnimation {
                    id: paNumAnimation
                    target: paNumValue
                    property: "y"
                    duration: 500
                    from: -10
                    to: 20
                    running: true
                }

                Text {
                    id: textAdmission
                    anchors {
                        bottom: parent.bottom
                        bottomMargin: fontSize25
                        left: parent.left
                    }
                    color: MyStyle.propertyTitleColor
                    text: qsTr("Admission:")
                    font.pixelSize: fontSize13
                }

                Text {
                    objectName: "admissionDateTime"
                    id: admissionDateValue
                    anchors {
                        bottom: textAdmission.bottom
                        left: textAdmission.right
                        leftMargin: fontSize11
                    }
                    color: MyStyle.propertyValueColor
                    text: MyGlobal.patientAdmitDate + " / " + MyGlobal.patientAdmitTime
                    font.pixelSize: fontSize14
                }

                //Room Number
                Text {
                    id: textRoomNo
                    anchors {
                        bottom: parent.bottom
                        right: textAdmission.right
                    }
                    color: MyStyle.propertyTitleColor
                    text: qsTr("Room:")
                    font.pixelSize: fontSize14
                }

                Text {
                    objectName: "roomNumber"
                    id: roomValue
                    anchors {
                        bottom: textRoomNo.bottom
                        left: textAdmission.right
                        leftMargin: fontSize11
                    }
                    color: MyStyle.propertyValueColor
                    text: MyGlobal.hospitalRoom
                    font.pixelSize: fontSize14
                }
            } //rectangle

            //Hospital Name
            Rectangle {
                id: hospitalBox

                color: MyStyle.backgroundColor

                anchors.left: admitBox.right
                anchors.bottom: patientBox.bottom
                width: MyGlobal.screenWidth / 3 - 100
                height: parent.height

                Text {
                    objectName: "hospitalName"
                    id: textHospitalName
                    anchors {
                        bottom: parent.bottom
                        bottomMargin: fontSize50
                        left: parent.left
                    }

                    color: MyStyle.titleColor
                    text: MyGlobal.hospitalName
                    font.pixelSize: fontSize14
                }
                NumberAnimation {
                    id: hospitalAnimation
                    target: textHospitalName
                    property: "y"
                    duration: 500
                    from: -10
                    to: 18
                    running: true
                }

                //Date and Time
                Rectangle {
                    id: clockRow
                    width: 50
                    height: hourLabel.implicitHeight
                    color: MyStyle.backgroundColor

                    anchors {
                        bottom: parent.bottom
                        bottomMargin: fontSize25
                        left: parent.left
                    }

                    //Function to split and set the time
                    function setTime() {
//                        console.log("Global = " + MyGlobal.screenHeight + " Main = " + MyGlobal.screenHeight);
                        var time = new Date().toLocaleTimeString([], {
                            hour: '2-digit'
                        }, {
                            minute: '2-digit'
                        }).toString()
                        var hour = time.slice(1, 2) === ":" ? time.slice(0, 1) : time.slice(0, 2)
                        var minute = time.slice(1, 2) === ":" ? time.slice(2, 4) : time.slice(3, 5)
                        var am_pm = time.slice(1, 2) === ":" ? time.slice(5, 7) : time.slice(6, 8)
                        hourLabel.text = hour
                        minutesLabel.text = minute
                        am_pmLabel.text = am_pm
                    }

                    Text {
                        id: hourLabel
                        font.pixelSize: fontSize14
                        color: MyStyle.propertyValueColor
                        anchors {
                            left: parent.left
                        }

                        Text {
                            id: colonLabel
                            font.pixelSize: fontSize14
                            text: ":"
                            anchors {
                                left: hourLabel.right;
                                bottom: parent.bottom
                            }
                            color: MyStyle.propertyValueColor
                        }

                        Text {
                            id: minutesLabel
                            font.pixelSize: fontSize14
                            color: MyStyle.propertyValueColor
                            anchors {
                                left: colonLabel.right;
                                bottom: parent.bottom
                            }
                        }

                        Text {
                            id: am_pmLabel
                            font.pixelSize: fontSize13
                            leftPadding: 5
                            bottomPadding: 1
                            color: MyStyle.propertyValueColor
                            anchors {
                                left: minutesLabel.right;
                                bottom: parent.bottom
                            }
                        }
                    }
                    //Timer to update the time using the setTime() function"
                    Timer {
                        id: timeTimer
                        interval: 1000
                        repeat: true
                        running: true
                        triggeredOnStart: true
                        onTriggered: clockRow.setTime()
                    }

                } //rectangle

                NumberAnimation {
                    id: clockAnimation
                    target: clockRow
                    property: "y"
                    from: -10
                    to: 40
                    duration: 500
                    running: true
                }

                Label {
                    id: currentDateLabel
                    property date currentDate: new Date()
                    //elide: Text.ElideRight
                    font.pixelSize: fontSize13
                    //horizontalAlignment: Text.AlignRight
                    anchors {
                        bottom: parent.bottom;
                        left: parent.left;
                    }
                    color: MyStyle.propertyValueColor

                    //Function to set the date with the format "Weekday, Month day (Eg. Monday, June 10)"
                    function setDate() {
                        var date = new Date();
                        var weekdays = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
                        var months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];

                        var weekday = weekdays[date.getDay()];
                        var month = months[date.getMonth()];
                        var day = date.getDate();

                        var secs = date.getTime();

                        currentDateLabel.text = weekday + ", " + month + " " + day
                    }
                }

                //Timer to update the date using the setDate() function"
                Timer {
                    id: dateTimer
                    interval: 1000
                    repeat: true
                    running: true
                    triggeredOnStart: true
                    onTriggered: currentDateLabel.setDate()
                }
            }  //HospitalName
        } //row


        //----- Temperature
        Rectangle {
            id: tempBox
            height: fontSize80
            width: MyGlobal.screenWidth / 2 - fontSize40
            color: MyStyle.backgroundColor
            anchors {
                left: parent.left
                top: topRow.bottom
            }

            Text {
                id: textTemperature
                anchors {
                    left: tempBox.left
                    leftMargin: mainLeftMargin
                    top: tempBox.top
                    topMargin: fontSize18
                }
                color: MyStyle.titleColor
                text: qsTr("Temperature")
                font.pixelSize: fontSize13
            }

            Text {
                id: textCelsius
                anchors {
                    left: textTemperature.right
                    leftMargin: fontSize14
                    bottom: textTemperature.bottom
                }
                color: MyStyle.propertyValueColor
                text: MyGlobal.temperatureCelsius
                font.pixelSize: fontSize11
            }

            Text {
                id: temperatureLeft
                anchors {
                    top: textTemperature.top;
                    topMargin: fontSize12
                    left: parent.left;
                    leftMargin: fontSize30
                }

                color: MyStyle.propertyValueColor
                text: MyGlobal.temperature1
                font.pixelSize: fontSize32
                font.family: sourceSansLight.name
            }

            Rectangle {
                id: imageCircleArrow
                height: fontSize20
                width: height
                radius: width / 2
                color: MyGlobal.temperatureArrowColor
                anchors {
                    left: temperatureLeft.right;
                    verticalCenter: temperatureLeft.verticalCenter;
                    leftMargin: fontSize10;
                }

                Image {
                    id: imageArrow
                    fillMode: Image.PreserveAspectFit
                    sourceSize: Qt.size(parent.width, parent.height)
                    source: "Images/arrow_50x50.png"
                    smooth: true
                    rotation: MyGlobal.temperatureArrowRotation
                }
            }

            Text {
                id: temperatureRight
                anchors {
                    top: temperatureLeft.top;
                    left: imageCircleArrow.right;
                    leftMargin: fontSize10
                }
                color: MyStyle.propertyValueColor
                text: MyGlobal.temperature2
                font.pixelSize: fontSize32
                font.family: sourceSansLight.name
            }

            Text {
                id: textHighest
                anchors {
                    left: temperatureRight.right;
                    leftMargin: fontSize24;
                    verticalCenter: temperatureLeft.verticalCenter;
                }
                color: MyStyle.propertyTitleColor
                text: qsTr("Highest")
                font.pixelSize: fontSize12
                font.family: sourceSansLight.name
            }

            Text {
                objectName: "tempHighest"
                id: tempHighest
                anchors {
                    left: textHighest.right;
                    leftMargin: fontSize14;
                    verticalCenter: temperatureLeft.verticalCenter;
                }
                color: MyStyle.propertyValueColor
                text: MyGlobal.temperatureHigh
                font.pixelSize: fontSize24
                font.family: sourceSansLight.name
            }
        }

        //----- Blood Pressure
        Rectangle {
            id: bpBox

            height: MyGlobal.screenHeight / 4
            width: MyGlobal.screenWidth / 2 - fontSize40

            anchors {
                left: parent.left
                top: tempBox.bottom
            }

            color: MyStyle.backgroundColor

            Text {
                id: textBloodPressure
                anchors {
                    left: parent.left
                    leftMargin: mainLeftMargin
                    top: parent.top
                }
                color: MyStyle.titleColor
                text: qsTr("Blood Pressure")
                font.pixelSize: fontSize14
            }

            Text {
                id: textmmHg
                anchors {
                    left: textBloodPressure.right
                    leftMargin: fontSize18
                    bottom: textBloodPressure.bottom
                }
                color: MyStyle.propertyTitleColor
                text: qsTr("mmHg")
                font.pixelSize: fontSize12
            }

            Text {
                id: textSYS
                anchors {
                    left: textBloodPressure.left
                    top: textBloodPressure.bottom
                }
                color: MyStyle.propertyTitleColor
                text: qsTr("SYS")
                font.pixelSize: fontSize10
            }

            Text {
                id: textDIA
                anchors {
                    left: bpDia.left
                    bottom: textSYS.bottom
                }
                color: MyStyle.propertyTitleColor
                text: qsTr("DIA")
                font.pixelSize: fontSize10
            }

            Text {
                objectName: "bpSys"
                id: bpSys
                anchors {
                    left: parent.left;
                    leftMargin: fontSize30
                    verticalCenter: imageBackSlashLarge.verticalCenter;
                }
                color: MyStyle.propertyBPColor
                text: MyGlobal.bpSysValue
                font.pixelSize: fontSize60
            }

            Image {
                id: imageBackSlashLarge
                anchors {
                    left: bpSys.right
                    leftMargin: fontSize14
                    bottom: parent.bottom
                    bottomMargin: fontSize14
                }
                fillMode: Image.PreserveAspectFit
                source: "Images/back-slash-large.png"
            }

            Text {
                objectName: "bpDia"
                id: bpDia
                anchors {
                    left: imageBackSlashLarge.right;
                    leftMargin: fontSize14
                    verticalCenter: imageBackSlashLarge.verticalCenter;
                }
                color: MyStyle.propertyBPColor
                text: MyGlobal.bpDiaValue
                font.pixelSize: fontSize60
            }
        }


        //----- Medications
        Rectangle {
            id: medsBox

            height: MyGlobal.screenFactor / 2
            width: MyGlobal.screenWidth / 2 - fontSize40

            anchors {
                left: tempBox.right
                top: topRow.bottom
                topMargin: fontSize18
            }

            color: MyStyle.backgroundColor

            Text {
                id: elementTextMedication

                anchors {
                    left: parent.left
                    top: medsBox.top
                }
                color: MyStyle.titleColor
                text: qsTr("Medications")
                font.pixelSize: fontSize14
            }

            //-----------------------------------  Saline
            Rectangle {
                id: salineBox
                anchors {
                    left: parent.left
                    top: elementTextMedication.bottom
                    topMargin: fontSize10
                }

                width: fontSize80 + fontSize20
                height: fontSize80 * 2 + fontSize40
                color: MyStyle.backgroundColor

                function doIt(val) {
                    var theNum = parseInt(repeater.count - (val / 5))
                    for (var i = 0; i < repeater.count; i++) {
                        if (theNum > i ) {
                            repeater.itemAt(i).color = MyStyle.barGraphOffColor
                        } else {
                            repeater.itemAt(i).color = MyStyle.barGraphOnColor
                        }
                    }
                }

                Text {
                    id: elementTextSaline
                    anchors {
                        left: rectangleRepeaterComponent.right
                        leftMargin: fontSize5
                        top: parent.top
                    }
                    color: MyStyle.propertyTitleColor
                    text: qsTr("Saline")
                    font.pixelSize: fontSize14
                }

                Text {
                    objectName: "elementTextSalineVal"
                    id: elementTextSalineVal
                    anchors {
                        left: elementTextSaline.left
                        top: elementTextSaline.bottom
                    }
                    color: MyStyle.propertyValueColor
                    text: MyGlobal.salineValue
                    font.pixelSize: fontSize40
                    font.family: sourceSansLight.name

                    onTextChanged: {
                        salineBox.doIt(MyGlobal.salineValue);
                    }
                }

                Text {
                    id: salinePercentage
                    color: MyStyle.propertyValueColor
                    text: "%"
                    font.pixelSize: fontSize30
                    font.family: sourceSansLight.name
                    anchors {
                        left: elementTextSalineVal.right;
                        top: elementTextSalineVal.top;
                    }
                }

                Rectangle {
                    id: rectangleRepeaterComponent
                    anchors {
                        left: parent.left
                        top: elementTextSaline.top
                    }
                    width: fontSize25
                    height: fontSize80 + fontSize80 + fontSize30
                    color: MyStyle.backgroundColor

                    Column {
                        x: 0
                        y: 0
                        spacing: myBarSpace
                        Repeater {
                            id: repeater
                            model: myBarNum
                            Rectangle {
                                width: fontSize25
                                height: myBarHeight
                                color: MyStyle.barGraphOffColor
                            }
                        }
                    }

                    Timer {
                        id: salineTimer
                        interval: 2000
                        repeat: true
                        running: true
                        triggeredOnStart: true
                        onTriggered: {
                            salineBox.doIt(MyGlobal.salineValue);
                        }
                    }  //Timer

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            var base = myBarNum * (myBarSpace + myBarHeight)
                            var Y = mouseY
                            if (Y < 0) Y = 0;
                            if (Y > myBarBase) Y = myBarBase;
                            var val = parseInt((myBarBase - Y) / 2)
                            elementTextSalineVal.text = val
                            MyGlobal.salineValue = val
                            salineBox.doIt(val);
                        }  //onClicked

                        onReleased: {
                                var Y = mouseY
                                if (Y < 0) Y = 0;
                                if (Y > myBarBase) Y = myBarBase;
                                var val = parseInt((myBarBase - Y) / 2)
                                elementTextSalineVal.text = val
                                MyGlobal.salineValue = val
                                salineBox.doIt(val);
                                submitTextField("Saline.value = " + elementTextSalineVal.text)
                        }  //onReleased:

                        onPositionChanged: {
                            var myI = 0;
                            for (myI = 0; myI < repeater.count; myI++) {
                                if (repeater.itemAt(myI).y >= mouseY) {
                                    repeater.itemAt(myI).color = MyStyle.barGraphOnColor
                                } else {
                                    repeater.itemAt(myI).color = MyStyle.barGraphOffColor
                                }
                                var Y = mouseY
                                if (Y < 0) Y = 0;
                                if (Y > myBarBase) Y = myBarBase;
                                var val = parseInt((myBarBase - Y) / 2)
                                elementTextSalineVal.text = val
                                MyGlobal.salineValue = val
                            }
                        } //onPositionChanged
                    }  //MouseArea
                }  //Rectangle
            } // Saline



            //-----  HiCor
            Rectangle {
                id: hiCorBox
                anchors {
                    left: salineBox.right
                    leftMargin: fontSize20

                    top: elementTextMedication.bottom
                    topMargin: fontSize10
                }

                width: fontSize80 + fontSize20
                height: fontSize80 * 2 + fontSize40
                color: MyStyle.backgroundColor


                function doIt(val) {
                    var theNum = parseInt(repeater1.count - (val / 5))
                    for (var i = 0; i < repeater1.count; i++) {
                        if (theNum > i ) {
                            repeater1.itemAt(i).color = MyStyle.barGraphOffColor
                        } else {
                            repeater1.itemAt(i).color = MyStyle.barGraphOnColor
                        }
                    }
                }

                Text {
                    id: elementTextHiCor
                    anchors {
                        left: rectangleRepeaterComponent1.right
                        leftMargin: fontSize5
                        top: parent.top
                    }
                    color: MyStyle.propertyTitleColor
                    text: qsTr("HiCor")
                    font.pixelSize: fontSize14
                }

                Text {
                    objectName: "elementTextHicorVal"
                    id: elementTextHicorVal
                    anchors {
                        left: elementTextHiCor.left
                        top: elementTextHiCor.bottom
                    }
                    color: MyStyle.propertyValueColor
                    text: MyGlobal.hiCorValue
                    font.pixelSize: fontSize40
                    font.family: sourceSansLight.name

                    onTextChanged: {
                        hiCorBox.doIt((MyGlobal.hiCorValue))
                    }
                }

                Text {
                    id: hiCorPercentage
                    color: MyStyle.propertyValueColor
                    text: "%"
                    font.pixelSize: fontSize30
                    font.family: sourceSansLight.name
                    anchors {
                        left: elementTextHicorVal.right;
                        top: elementTextHicorVal.top;
                    }
                }

                Rectangle {
                    id: rectangleRepeaterComponent1
                    anchors {
                        left: parent.left
                        top: elementTextHiCor.top
                    }
                    width: fontSize25
                    height: fontSize80 + fontSize80 + fontSize30
                    color: MyStyle.backgroundColor
            
                    Column {
                        x: 0
                        y: 0
                        spacing: myBarSpace
                        Repeater {
                            id: repeater1
                            model: myBarNum
                            Rectangle {
                                width: fontSize25
                                height: myBarHeight
                                color: MyStyle.barGraphOffColor
                            }
                        }
                    }  //Column
                    
                    Timer {
                        id: hiCorTimer
                        interval: 2000
                        repeat: true
                        running: true
                        triggeredOnStart: true
                        onTriggered: {
                            hiCorBox.doIt(MyGlobal.hiCorValue);
                        }
                    }  //Timer

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            var base = myBarNum * (myBarSpace + myBarHeight)
                            var Y = mouseY
                            if (Y < 0) Y = 0;
                            if (Y > myBarBase) Y = myBarBase;
                            var val = parseInt((myBarBase - Y) / 2)
                            elementTextHicorVal.text = val
                            MyGlobal.hiCorValue = val
                            hiCorBox.doIt(val);
                        } //onClicked:

                        onReleased: {
                                var Y = mouseY
                                if (Y < 0) Y = 0;
                                if (Y > myBarBase) Y = myBarBase;
                                var val = parseInt((myBarBase - Y) / 2)
                                elementTextHicorVal.text = val
                                MyGlobal.hiCorValue = val
                                hiCorBox.doIt(val);
                                submitTextField("Hicor.value = " + elementTextHicorVal.text)
                        }  //onReleased:

                        onPositionChanged: {
                            var myI = 0;
                            for (myI = 0; myI < repeater1.count; myI++) {

                                if (repeater1.itemAt(myI).y >= mouseY) {
                                    repeater1.itemAt(myI).color = MyStyle.barGraphOnColor
                                } else {
                                    repeater1.itemAt(myI).color = MyStyle.barGraphOffColor
                                }

                                var Y = mouseY
                                if (Y < 0) Y = 0;
                                if (Y > myBarBase) Y = myBarBase;
                                var val = parseInt((myBarBase - Y) / 2)
                                elementTextHicorVal.text = val
                            }
                        } //onPositionChanged
                    }  //MouseArea
                }  //Rectangle
            }  //HiCor


            //-----  Glucagon
            Rectangle {
                id: glucagonBox
                anchors {
                    left: hiCorBox.right
                    leftMargin: fontSize20

                    top: elementTextMedication.bottom
                    topMargin: fontSize10
                }

                width: fontSize80 + fontSize20
                height: fontSize80 * 2 + fontSize40
                color: MyStyle.backgroundColor

                function doIt(val) {
                    var theNum = parseInt(repeater2.count - (val / 5))
                    for (var iii = 0; iii < repeater2.count; iii++) {
                        if (theNum > iii ) {
                            repeater2.itemAt(iii).color = MyStyle.barGraphOffColor
                        } else {
                            repeater2.itemAt(iii).color = MyStyle.barGraphOnColor
                        }
                    }
                }

                Text {
                    id: elementTextGlucagon
                    anchors {
                        left: rectangleRepeaterComponent2.right
                        leftMargin: fontSize5
                        top: parent.top
                    }
                    color: MyStyle.propertyTitleColor
                    text: qsTr("Glucagon")
                    font.pixelSize: fontSize14
                }

                Text {
                    objectName: "elementTextGlucagonVal"
                    id: elementTextGlucagonVal
                    anchors {
                        left: elementTextGlucagon.left
                        top: elementTextGlucagon.bottom
                    }
                    color: MyStyle.propertyValueColor
                    text: MyGlobal.glucagonValue
                    font.pixelSize: fontSize40
                    font.family: sourceSansLight.name

                    onTextChanged: {
                        glucagonBox.doIt((MyGlobal.glucagonValue))
                    }
                }

                Text {
                    id: glucagonPercentage
                    color: MyStyle.propertyValueColor
                    text: "%"
                    font.pixelSize: fontSize30
                    font.family: sourceSansLight.name
                    anchors {
                        left: elementTextGlucagonVal.right;
                        top: elementTextGlucagonVal.top;
                    }
                }

                Rectangle {
                    id: rectangleRepeaterComponent2
                    anchors {
                        left: parent.left
                        top: elementTextGlucagon.top
                    }
                    width: fontSize25
                    height: fontSize80 + fontSize80 + fontSize30
                    color: MyStyle.backgroundColor
                    property int glucagonValue: 0

                    Column {
                        x: 0
                        y: 0
                        spacing: myBarSpace
                        Repeater {
                            id: repeater2
                            model: myBarNum
                            Rectangle {
                                width: fontSize25
                                height: myBarHeight
                                color: MyStyle.barGraphOffColor
                            }
                        }
                    }  //Column


                    Timer {
                        id: glucagonTimer
                        interval: 2000
                        repeat: true
                        running: true
                        triggeredOnStart: true
                        onTriggered: {
                            glucagonBox.doIt(MyGlobal.glucagonValue);
                        }
                    }  //Timer

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            var base = myBarNum * (myBarSpace + myBarHeight)
                            var Y = mouseY
                            if (Y < 0) Y = 0;
                            if (Y > myBarBase) Y = myBarBase;
                            var val = parseInt((myBarBase - Y) / 2)
                            elementTextGlucagonVal.text = val
                            MyGlobal.glucagonValue = val
                            glucagonBox.doIt((MyGlobal.glucagonValue));
                        } //onClicked:

                        onReleased: {
                                var Y = mouseY
                                if (Y < 0) Y = 0;
                                if (Y > myBarBase) Y = myBarBase;
                                var val = parseInt((myBarBase - Y) / 2)
                                elementTextGlucagonVal.text = val
                                MyGlobal.glucagonValue = val
                                glucagonBox.doIt(val);
                                submitTextField("Glucagon.value = " + elementTextGlucagonVal.text)
                        }  //onReleased:

                        onPositionChanged: {
                            var myI = 0;
                            for (myI = 0; myI < repeater2.count; myI++) {

                                if (repeater2.itemAt(myI).y >= mouseY) {
                                    repeater2.itemAt(myI).color = MyStyle.barGraphOnColor
                                } else {
                                    repeater2.itemAt(myI).color = MyStyle.barGraphOffColor
                                }

                                var Y = mouseY
                                if (Y < 0) Y = 0;
                                if (Y > myBarBase) Y = myBarBase;
                                var val = parseInt((myBarBase - Y) / 2)
                                elementTextGlucagonVal.text = val
                            }
                        } //onPositionChanged
                    }  //MouseArea
                }  //Rectangle
            }  //Glucagon

        } //Medications





        //---------------------------------------------------------------------------------------------  EKG
        Rectangle {
            id: ekgBox
            width: MyGlobal.screenWidth / 3
            height: fontSize80
            color: MyStyle.backgroundColor
            anchors {
                left: parent.left
                leftMargin: mainLeftMargin
                top: bpBox.bottom
                topMargin: fontSize14
            }

            Rectangle {
                id: greenCircle
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: ekgBox.left
                }
                width: fontSize80
                height: width
                radius: width / 2
                color: MyStyle.greenColor
                opacity: main.opacityAnimation
            }

            Text {
                id: textEKG
                color: MyStyle.propertyTitleColorDark
                text: qsTr("EKG")
                font.pixelSize: fontSize12
                anchors {
                    horizontalCenter: greenCircle.horizontalCenter;
                    top: greenCircle.top;
                    topMargin: fontSize10
                }
                opacity: 0
            }

            Text {
                objectName: "textEKGValue"
                id: textEKGValue
                color: MyStyle.propertyValueColor
                text: MyGlobal.ekgValue
                font.pixelSize: fontSize35
                font.family: sourceSansLight.name
                anchors.centerIn: greenCircle
                opacity: 0
            }

            Text {
                id: textBMP
                color: MyStyle.propertyTitleColorDark
                text: qsTr("BMP")
                font.pixelSize: fontSize11
                anchors {
                    horizontalCenter: greenCircle.horizontalCenter;
                    bottom: greenCircle.bottom;
                    bottomMargin: fontSize10
                }
                opacity: 0
            }

            AnimatedImage {
                id: gifEKGLine
                anchors {
                    left: greenCircle.right
                    verticalCenter: ekgBox.verticalCenter
                }
                source: "Images/ekg-line.gif"
                opacity: 0
            }
        }




        //---------------------------------------------------------------------------------
        SequentialAnimation {
            id: circleAnimation
            running: true
            PauseAnimation {
                duration: 10
            }
            NumberAnimation {
                targets: [greenCircle, purpleCircle, purpleCircle, blueCircle]
                property: 'opacity'
                from: 0
                to: 1
                duration: main.circleDuration
            }
        }

        SequentialAnimation {
            id: gifAnimation
            running: true
            PauseAnimation {
                duration: main.gifDelay
            }

            NumberAnimation {
                targets: [gifEKGLine, gifPulseLine]
                property: "opacity"
                easing.type: Easing.InOutQuad
                duration: main.gifDuration
                from: 0
                to: 1
            }
        }



        //----  SpO2
        Rectangle {
            id: spoxBox
            width: MyGlobal.screenWidth / 3
            height: fontSize80
            color: MyStyle.backgroundColor
            anchors {
                left: parent.left
                leftMargin: mainLeftMargin
                top: ekgBox.bottom
                topMargin: fontSize14
            }

            Rectangle {
                id: blueCircle
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: spoxBox.left
                }
                width: fontSize80
                height: width
                radius: width / 2
                color: MyStyle.blueColor
                opacity: 0
            }

            Text {
                id: textPulse
                color: MyStyle.propertyTitleColorDark
                text: qsTr("Pulse")
                font.pixelSize: fontSize12
                anchors {
                    horizontalCenter: blueCircle.horizontalCenter;
                    top: blueCircle.top;
                    topMargin: fontSize10
                }
                opacity: 0
            }

            Text {
                id: textPulseValue
                color: MyStyle.propertyValueColor
                text: MyGlobal.spo2Value
                font.pixelSize: fontSize35
                font.family: sourceSansLight.name
                opacity: 0
                anchors.centerIn: blueCircle
            }

            Text {
                id: textSpO
                textFormat: Text.RichText
                text: "SpO<sub>2</sub>"
                color: MyStyle.propertyTitleColorDark
                font.pixelSize: fontSize11
                anchors {
                    horizontalCenter: blueCircle.horizontalCenter;
                    bottom: blueCircle.bottom;
                    bottomMargin: fontSize10
                }
                opacity: 0
            }

            AnimatedImage {
                id: gifPulseLine
                anchors {
                    left: blueCircle.right
                    verticalCenter: spoxBox.verticalCenter
                }
                source: "Images/pulse-line.gif"
                opacity: 0
            }

        }




        Item {
            id: functionEKGContainer
            property int value: MyGlobal.ekgValue
            property bool up: true
            property int increment: 1
            property int ceiling: (MyGlobal.ekgValue + 10)
            property int bottomValue: (MyGlobal.ekgValue - 5)

            function increaseDecreaseNumber() {
                if (up === true && value <= ceiling) {
                    value += increment

                    if (value >= ceiling) {
                        up = false;
                    }
                } else {
                    up = false
                    value -= increment;

                    if (value <= bottomValue) {
                        up = true;
                    }
                }
                textEKGValue.text = value;

            }

            Timer {
                interval: 1000
                running: true
                repeat: true
                triggeredOnStart: true
                onTriggered: functionEKGContainer.increaseDecreaseNumber()
            }
        }






        Item {
            id: functionPulseContainer
            property int value: MyGlobal.spo2Value
            property bool up: true
            property int increment: 1
            property int ceiling: (MyGlobal.spo2Value + 5)
            property int bottomValue: (MyGlobal.spo2Value - 10)

            function increaseDecreaseNumber() {
                if (up === true && value <= ceiling) {
                    value += increment

                    if (value >= ceiling) {
                        up = false;
                    }
                } else {
                    up = false
                    value -= increment;

                    if (value <= bottomValue) {
                        up = true;
                    }
                }
                textPulseValue.text = value;
            }

            Timer {
                interval: 1500
                running: true
                repeat: true
                triggeredOnStart: true
                onTriggered: functionPulseContainer.increaseDecreaseNumber()
            }
        }

        SequentialAnimation {
            id: valueAnimation
            running: true
            PauseAnimation {
                duration: main.textDelay
            }
            NumberAnimation {
                targets: [textEKGValue, textPulseValue]
                property: 'opacity'
                to: 1
                duration: main.textDuration
            }
        }

        SequentialAnimation {
            id: textAnimation
            running: true
            PauseAnimation {
                duration: main.textDelay
            }
            NumberAnimation {
                targets: [textEKG, textBMP, textPulse, textSpO, textInsulinPump, textUHr, insulinP]
                property: 'opacity'
                to: main.subTextOpacity
                duration: main.textDuration
            }
        }


        //----- Insulin
        Rectangle {
            id: insulin
            anchors {
                left: medsBox.left
                leftMargin: -fontSize20
                top: medsBox.bottom
                topMargin: fontSize8
            }

            width: MyGlobal.screenWidth / 2 - fontSize60
            height: MyGlobal.screenFactor / 4
            color: MyStyle.backgroundColor

            Rectangle {
                id: purpleCircle
                anchors {
                    verticalCenter: insulin.verticalCenter
                    left: insulin.left
                }

                width: boxSize1 + fontSize12
                height: width
                radius: width / 2
                color: MyStyle.purpleColor
                opacity: 1

                Text {
                    id: textInsulinPump
                    color: MyStyle.propertyTitleColorDark
                    text: qsTr("Insulin Pump")
                    font.pixelSize: fontSize13
                    anchors {
                        horizontalCenter: purpleCircle.horizontalCenter;
                        top: purpleCircle.top;
                        topMargin: fontSize20
                    }
                    opacity: 0
                }

                Text {
                    id: textUHr
                    color: MyStyle.propertyTitleColorDark
                    text: qsTr("U/Hr")
                    font.pixelSize: fontSize13
                    anchors {
                        horizontalCenter: purpleCircle.horizontalCenter;
                        bottom: purpleCircle.bottom;
                        bottomMargin: fontSize20
                    }
                    opacity: 0
                }

                Text {
                    objectName: "insulinP"
                    id: insulinP
                    color: MyStyle.propertyValueColor
                    text: MyGlobal.insulinValue
                    font.pixelSize: fontSize40
                    font.family: sourceSansLight.name
                    anchors.centerIn: purpleCircle
                    opacity: 0
                }
            }

            //Last Bolus
            Rectangle {
                id: lastBBox
                anchors {
                    verticalCenter: purpleCircle.verticalCenter
                    left: purpleCircle.right
                    leftMargin: fontSize8
                }
                width: boxSize
                height: boxSize
                color: MyStyle.backgroundColor

                Text {
                    id: textLastBolus
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        top: parent.top;
                        topMargin: textMargin
                    }
                    color: MyStyle.propertyTitleColor
                    text: qsTr("Last Bolus")
                    font.pixelSize: fontSize13
                }

                Text {
                    objectName: "lastBolusValue"
                    id: lastBolusValue
                    anchors {
                        horizontalCenter: parent.horizontalCenter;verticalCenter: parent.verticalCenter;
                    }
                    color: MyStyle.propertyValueColor
                    text: MyGlobal.lastBolusValue
                    font.family: sourceSansLight.name
                    font.pixelSize: fontSize40
                }

                Text {
                    id: textU
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        bottom: parent.bottom
                        bottomMargin: textMargin
                    }
                    color: MyStyle.propertyTitleColor
                    text: qsTr("Hr")
                    font.pixelSize: fontSize13
                }
            }

            //IOB
            Rectangle {
                id: iobBox
                anchors {
                    verticalCenter: purpleCircle.verticalCenter
                    left: lastBBox.right
                    leftMargin: fontSize8
                }

                width: boxSize
                height: boxSize
                color: MyStyle.backgroundColor

                Text {
                    id: textIOB
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        top: parent.top;
                        topMargin: textMargin
                    }
                    color: MyStyle.propertyTitleColor
                    text: qsTr("IOB")
                    font.pixelSize: fontSize13
                }

                Text {
                    objectName: "iobValue"
                    id: iobValue
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        verticalCenter: parent.verticalCenter;
                    }
                    color: MyStyle.propertyValueColor
                    text: MyGlobal.iOBValue
                    font.family: sourceSansLight.name
                    font.pixelSize: fontSize40
                }

                Text {
                    id: textU1
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        bottom: parent.bottom
                        bottomMargin: textMargin
                    }
                    color: MyStyle.propertyTitleColor
                    text: qsTr("U")
                    font.pixelSize: fontSize12
                }
            }

            //Glucose
            Rectangle {
                id: glucoseBox

                anchors {
                    verticalCenter: purpleCircle.verticalCenter
                    leftMargin: fontSize8
                    left: iobBox.right
                }

                width: boxSize
                height: boxSize
                color: MyStyle.backgroundColor

                Text {
                    id: textGlucose
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        top: parent.top;
                        topMargin: textMargin
                    }
                    color: MyStyle.propertyTitleColor
                    text: qsTr("Glucose")
                    font.pixelSize: fontSize13
                }

                Text {
                    objectName: "glucoseValue"
                    id: glucoseValue
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        verticalCenter: parent.verticalCenter;
                    }
                    color: MyStyle.propertyValueColor
                    text: MyGlobal.glucoseValue
                    font.family: sourceSansLight.name
                    font.pixelSize: fontSize40
                }

                Text {
                    id: textMgDL
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        bottom: parent.bottom
                        bottomMargin: textMargin
                    }
                    color: MyStyle.propertyTitleColor
                    text: qsTr("Mg/DL")
                    font.pixelSize: fontSize13
                }
            }
        }

        Rectangle { //Right Side
            id: rightBox
            height: MyGlobal.screenHeight
            width: MyGlobal.screenWidth / 10

            anchors {
                top: main.top;
                right: main.right;
            }
            color: MyStyle.backgroundColor

            //----- Alarm
            Rectangle {
                id: buttonAlarmOn
                width: parent.width - fontSize2
                height: width
                color: MyStyle.alarmBtnBckGOff
                radius: fontSize8
                antialiasing: true
                anchors {
                    top: rightBox.top;
                    topMargin: fontSize40
                    left: parent.left
                }

                Text {
                    id: elementTextAlarmButton
                    color: MyStyle.alarmFontColor
                    text: qsTr("Alarm")
                    font.pixelSize: fontSize10
                    anchors {
                        bottom: parent.bottom;
                        horizontalCenter: parent.horizontalCenter;
                        bottomMargin: fontSize5
                    }
                }

                Accessible.role: Accessible.Button
                Accessible.onPressAction: {
                    button.clicked()
                }

                signal clicked
                Image {
                    id: alarmImage
                    width: fontSize60
                    height: fontSize60
                    anchors {
                        bottom: parent.bottom;
                        bottomMargin: fontSize18
                        horizontalCenter: parent.horizontalCenter
                    }
                    fillMode: Image.PreserveAspectFit
                    source: "Images/icon-alarm.png"

                    ColorOverlay {
                        id: alarmImageColor
                        anchors.fill: alarmImage
                        source: alarmImage
                        color: MyStyle.alarmColorOff
                    }
                }

                MouseArea {
                    id: mouseAreaAlarmOn
                    anchors.fill: parent
                    onClicked: buttonAlarmOn.clicked()
                }

                Keys.onSpacePressed: clicked()
                onClicked: {
                    MyStyle.alarmImageBool = !MyStyle.alarmImageBool;
                    if (MyStyle.alarmImageBool) {
                        alarmImageColor.color = MyStyle.alarmColorOn;
                        buttonAlarmOn.color = MyStyle.alarmBtnBckGOn;
                    } else {
                        alarmImageColor.color = MyStyle.alarmColorOff;
                        buttonAlarmOn.color = MyStyle.alarmBtnBckGOff;
                    }

                    submitTextField("btnAlarm.value=" + (MyStyle.alarmImageBool ? "On" : "Off"));
                    console.log("Button ALARM pressed " + (MyStyle.alarmImageBool ? "On" : "Off"));
                }
            } //end AlarmScreen




            //Vitals
            Rectangle {
                objectName: "buttonVitalsOn"
                id: buttonVitalsOn
                width: parent.width - fontSize2
                height: width
                color: MyStyle.vitalsBtnBckGOff
                radius: fontSize8
                antialiasing: true

                anchors {
                    top: buttonAlarmOn.bottom
                    topMargin: fontSize40
                    left: parent.left
                }

                Text {
                    id: elementTextVitalsOnButton
                    color: MyStyle.vitalsFontColor
                    text: qsTr("Vitals")
                    font.pixelSize: fontSize10
                    anchors {
                        bottom: parent.bottom;
                        bottomMargin: fontSize5
                        horizontalCenter: parent.horizontalCenter;
                    }
                }

                Accessible.role: Accessible.Button
                Accessible.onPressAction: {
                    button.clicked()
                }

                signal clicked
                Image {
                    id: vitalsImage
                    width: fontSize60
                    height: fontSize60

                    anchors {
                        bottom: parent.bottom;
                        bottomMargin: fontSize18
                        horizontalCenter: parent.horizontalCenter;
                    }

                    fillMode: Image.PreserveAspectFit
                    source: "Images/icon-vitals-on.png"
                }

                ColorOverlay {
                    id: vitalsImageColor
                    anchors.fill: vitalsImage
                    source: vitalsImage
                    color: MyStyle.vitalsColorOff
                }

                MouseArea {
                    id: mouseAreaVitalsOn
                    anchors.fill: parent
                    onClicked: buttonVitalsOn.clicked()
                }

                Keys.onSpacePressed: clicked()
                onClicked: {
                    MyStyle.vitalsImageBool = !MyStyle.vitalsImageBool;
                    if (MyStyle.vitalsImageBool) {
                        vitalsImageColor.color = MyStyle.vitalsColorOn;
                        buttonVitalsOn.color = MyStyle.vitalsBtnBckGOn;
                    } else {
                        vitalsImageColor.color = MyStyle.vitalsColorOff;
                        buttonVitalsOn.color = MyStyle.vitalsBtnBckGOff;
                    }

                    submitTextField("btnVitals.value=" + (MyStyle.vitalsImageBool ? "On" : "Off"));
                    console.debug("Button VITALS pressed " + (MyStyle.vitalsImageBool ? "On" : "Off"));
                }
            } //end Vitals




            //Help
            Rectangle {
                objectName: "buttonGetHelpOn"
                id: buttonGetHelpOn
                width: parent.width - fontSize2
                height: width
                color: MyStyle.helpBtnBckGOff
                radius: fontSize8
                antialiasing: true
                anchors {
                    top: buttonVitalsOn.bottom;
                    topMargin: fontSize40
                    left: parent.left
                }

                Text {
                    id: elementTextHelpOnButton
                    color: MyStyle.helpFontColor
                    text: qsTr("Help")
                    font.pixelSize: fontSize10
                    anchors {
                        bottom: parent.bottom;
                        horizontalCenter: parent.horizontalCenter;
                        bottomMargin: 5
                    }
                }

                Accessible.role: Accessible.Button
                Accessible.onPressAction: {
                    button.clicked()
                }

                signal clicked

                Image {
                    id: helpImage
                    width: fontSize60
                    height: fontSize60
                    anchors {
                        bottom: parent.bottom;
                        bottomMargin: fontSize18
                        horizontalCenter: parent.horizontalCenter
                    }

                    fillMode: Image.PreserveAspectFit
                    source: "Images/icon-get-help.png"

                    ColorOverlay {
                        id: helpImageColor
                        anchors.fill: helpImage
                        source: helpImage
                        color: MyStyle.helpColorOff
                    }
                }

                MouseArea {
                    id: mouseAreaGetHelpOn
                    anchors.fill: parent
                    onClicked: buttonGetHelpOn.clicked()
                }
                Keys.onSpacePressed: clicked()
                onClicked: {
                    MyStyle.helpImageBool = !MyStyle.helpImageBool;
                    if (MyStyle.helpImageBool) {
                        helpImageColor.color = MyStyle.helpColorOn;
                        buttonGetHelpOn.color = MyStyle.helpBtnBckGOn;
                    } else {
                        helpImageColor.color = MyStyle.helpColorOff;
                        buttonGetHelpOn.color = MyStyle.helpBtnBckGOff;
                    }

                    submitTextField("btnHelp.value=" + (MyStyle.helpImageBool ? "On" : "Off"));
                    console.debug("Button HELP pressed " + (MyStyle.helpImageBool ? "On" : "Off"));
                }
            } //end Help

            NumberAnimation {
                id: buttonAnimation
                targets: [buttonGetHelpOn, buttonVitalsOn]
                property: "x"
                duration: 800
                from: main.buttonsAnimationX
                to: 730
                running: true
            }

            NumberAnimation {
                id: alarmButtonAnimation
                target: buttonAlarmOn
                property: "x"
                duration: 800
                from: main.buttonsAnimationX
                to: 745
                running: true
            }

            Component.onCompleted: {
                //  sendPreviousScreen.connect(alarmsId.receivePreviousScreen)
                //  startAnimation.connect(alarmsId.receiveAnimation)
            }

            //--- Reach Logo
            Rectangle {
                height: fontSize12
                width: rightBox.width - 3
                anchors {
                    bottom: rightBox.bottom;
                    horizontalCenter: rightBox.horizontalCenter
                }
                color: MyStyle.backgroundColor
                Image {
                    id: imageLogoReach
                    fillMode: Image.PreserveAspectFit
                    width: parent.width - 3
                    height: parent.height - 3

                    anchors {
                        bottom: parent.bottom
                        bottomMargin: fontSize5
                    }

                    source: "Images/logo-reach.png"
                }
            } //end Logo
        } //Rectangle - right side
    } //Rectangle - main stackup


    /*
    AlarmScreen {
      id: alarmsId
      stack: stackMain
      isRunning: stackMain.currentIndex === 3
      previousScreen: stackMain.currentIndex

      Component.onCompleted: {
        startAnimation.connect(main.receiveAnimation)
        startAnimation.connect(alarmsId.receiveAnimation)
      }
    }
*/

} //Window
