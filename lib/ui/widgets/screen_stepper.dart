import 'package:flutter/material.dart';
import 'package:solutech_sat/ui/widgets/footer.dart';

class ScreenStepper extends StatelessWidget {
  int currentScreen;
  bool showSave;
  List<Widget> screens;
  Function onNext;
  Function onPrev;
  Function onSave;
  ScreenStepper({
    @required this.screens,
    this.onSave,
    this.showSave = true,
    this.currentScreen = 0,
    this.onNext,
    this.onPrev,
  });
  @override
  Widget build(BuildContext context) {
    print("Showing screens of length: ${screens.length}");
    return (screens.length > 0)
        ? Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: (screens.length > 0) ? screens[currentScreen] : null,
                ),
              ),
              Stepper(
                screens: screens,
                currentScreen: currentScreen,
                showPrev: currentScreen - 1 >= 0,
                showNext: currentScreen + 1 < screens.length,
                showSave: showSave,
                onPrev: () {
                  if (currentScreen - 1 >= 0) {
                    int value = currentScreen - 1;
                    onPrev(value);
                  }
                },
                onNext: () {
                  if (currentScreen + 1 < screens.length) {
                    int value = currentScreen + 1;
                    onNext(value);
                  }
                },
                onSave: onSave,
              ),
              Footer()
            ],
          )
        : Container();
  }
}

class Stepper extends StatelessWidget {
  bool showPrev;
  bool showNext;
  bool showSave;
  Function onPrev;
  Function onNext;
  Function onSave;
  String prevText;
  String nextText;
  List<Widget> screens;
  int currentScreen;
  Stepper(
      {@required this.screens,
      this.onSave,
      this.showSave = true,
      this.showPrev = true,
      this.prevText = "PREV",
      this.nextText = "NEXT",
      this.showNext = true,
      @required this.currentScreen,
      this.onPrev,
      this.onNext});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: double.infinity,
      child: Row(
        children: <Widget>[
          StepperButton(
            icon: Icons.chevron_left,
            iconPosition: 'left',
            onTap: onPrev,
            show: showPrev,
            text: prevText,
          ),
          StepperIndicator(
            currentScreen: currentScreen,
            screens: screens,
          ),
          StepperButton(
            icon: Icons.chevron_right,
            iconPosition: 'right',
            onTap: (showNext) ? onNext : onSave,
            show: true,
            text: (showNext) ? nextText : showSave ? "SAVE" : "",
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(1.0, 0.1),
            blurRadius: .4,
          ),
        ],
      ),
    );
  }
}

class StepperButton extends StatelessWidget {
  bool show;
  String text;
  Function onTap;
  IconData icon;
  String iconPosition;

  List<Widget> _buildWidgets(context) {
    List<Widget> widgets = [
      (["NEXT", "PREV"].contains(text))
          ? Icon(
              icon,
              color: Theme.of(context).primaryColor,
            )
          : Container(),
      Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor),
        ),
      ),
    ];
    return (iconPosition != 'right') ? widgets : widgets.reversed.toList();
  }

  StepperButton(
      {@required this.text = "",
      this.onTap,
      this.icon,
      this.show = true,
      this.iconPosition = 'left'});
  @override
  Widget build(BuildContext context) {
    return (show)
        ? InkWell(
            onTap: onTap,
            child: Container(
              height: double.infinity,
              width: 100.0,
              color: Colors.white,
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: (iconPosition != 'right')
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: _buildWidgets(context),
              ),
            ),
          )
        : Container(
            width: 100.0,
          );
  }
}

class StepperIndicator extends StatelessWidget {
  List<Widget> screens;
  int currentScreen;
  StepperIndicator({@required this.screens, @required this.currentScreen});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: screens.map((element) {
            int index = screens.indexOf(element);
            return Icon(
              Icons.brightness_1,
              color: (index == currentScreen)
                  ? Theme.of(context).primaryColor
                  : Color(0xFFd3d3d3),
              size: (index == currentScreen) ? 11.0 : 8.0,
            );
          }).toList(),
        ),
      ),
    );
  }
}
