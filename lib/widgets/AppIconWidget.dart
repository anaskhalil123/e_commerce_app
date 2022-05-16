
import 'package:flutter/cupertino.dart';

class AppIconWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        height: (MediaQuery.of(context).size.height * .2),
        child: Stack(
          alignment: Alignment.center,
          children: const <Widget>[
            Image(
              image: AssetImage('images/icons/buy_it_icon.png'),
            ),
            Positioned(
              bottom: 0,
              child: Text(
                'Buy it',
                style: TextStyle(
                    fontFamily: 'SpaceMono',
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
