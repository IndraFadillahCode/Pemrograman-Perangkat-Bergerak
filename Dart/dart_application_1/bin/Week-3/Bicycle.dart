class Bicycle {
  int speed = 0;
  int gear = 0;
// method
  void changeGear(int newValue) {
    gear = gear + newValue;
    print(" \nGear: $gear");
  }

  void speedUp(int increment) {
    speed = speed + increment;
    print(" \nSpeed: $speed");
  }
}
