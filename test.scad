use <fcad/fcad.scad>;

module testAxes(translation=[0, 0, 0], rotation=[0, 0, 0]) {
  color("red") fDraw(fTranslate(fRotate(fRotate(fCylinder(h=100, r=1), "start", [0, 90, 0]), "start", rotation), translation));
  color("green") fDraw(fTranslate(fRotate(fRotate(fCylinder(h=100, r=1), "start", [-90, 0, 0]), "start", rotation), translation));
  color("blue") fDraw(fTranslate(fRotate(fRotate(fCylinder(h=100, r=1), "start", [0, 0, 0]), "start", rotation), translation));
}

testAxes(translation=[0, 0, 200], rotation=[0, 0, 0]);
testAxes(translation=[0, 200, 0], rotation=[270, 90, 0]);
testAxes(translation=[0, 0, -200], rotation=[0, 180, 180]);
testAxes(translation=[0, -200, 0], rotation=[90, 90, 0]);
testAxes(translation=[200, 0, 0], rotation=[90, 0, 90]);
testAxes(translation=[-200, 0, 0], rotation=[270, 0, 90]);

//result = fAttach(fCube(10), "top", fCube(5), "bottom5");
//result = fRotate(fCube(5), "front", [0, 360, 360]);

//echo(result);
//#fDraw(result);