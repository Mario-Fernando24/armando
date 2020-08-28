import 'package:flutter/cupertino.dart';

double calcFromH(context, paddingToGet) {
  return MediaQuery.of(context).size.height * paddingToGet;
}

double calcFromW(context, paddingToGet) {
  return MediaQuery.of(context).size.width * paddingToGet;
}
