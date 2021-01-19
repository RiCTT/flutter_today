import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class RippleWrapper extends StatelessWidget {
  final Widget child;
  const RippleWrapper({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.purple,
      borderRadius: BorderRadius.all(
        Radius.circular(120.0)
      ),
      child: new InkWell(
        onTap: () {},
        borderRadius: BorderRadius.all(
          Radius.circular(120.0)
        ),
        child: this.child
      ),
    );
  }
}