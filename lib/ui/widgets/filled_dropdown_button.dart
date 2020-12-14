import 'package:flutter/material.dart';

class FilledDropdownButton extends StatefulWidget {
  Key key;
  String label;
  String hint;
  List<DropdownMenuItem> items;
  TextStyle style;
  var value;
  int elevation;
  double iconSize;
  bool isDense;
  bool loading;
  bool isExpanded;
  EdgeInsetsGeometry padding;
  bool focused;
  Function onChange;
  Function onTap;
  FilledDropdownButton({
    this.key,
    this.label = null,
    this.items = const [],
    this.focused = false,
    this.style,
    this.value,
    this.elevation = 1,
    this.iconSize = 24.0,
    this.isDense = false,
    this.isExpanded = false,
    this.hint,
    this.onTap,
    this.padding = null,
    this.loading = false,
    this.onChange,
  });
  @override
  _FilledDropdownButtonState createState() => _FilledDropdownButtonState();
}

class _FilledDropdownButtonState extends State<FilledDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: widget.padding,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: (widget.isDense) ? 9.0 : 12.5,
                  bottom: (widget.isDense) ? 9.0 : 12.5,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: (widget.value != null && widget.label != null)
                          ? Text(
                              "${widget.label}",
                              style: TextStyle(
                                  fontSize: 12.0,
                                  color: (widget.focused)
                                      ? Colors.blue
                                      : Colors.black54),
                            )
                          : Container(
                              height: 6.0,
                            ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 19.0,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          hint: Text(widget.hint ?? widget.label ?? ""),
                          items: widget.items ?? [],
                          style: widget.style,
                          value: widget.value,
                          elevation: widget.elevation,
                          iconSize: widget.iconSize,
                          icon: Container(
                            child: Flexible(child: Icon(Icons.arrow_drop_down)),
                          ),
                          isExpanded: widget.isExpanded,
                          key: widget.key,
                          onChanged: (value) {
                            widget.onChange(value);
                            widget.value = value;
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: (widget.value != null && widget.label != null)
                          ? 0.0
                          : 6.0,
                    )
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  //border: Border(bottom: BorderSide(color: Colors.blue, width: 2.0)),
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(3.0)),
                ),
              ),
              Container(
                width: double.infinity,
                height: (widget.focused) ? 2.0 : 1.0,
                color: (widget.focused)
                    ? Colors.blue
                    : (widget.loading) ? Colors.grey[300] : Colors.black87,
              ),
              (widget.loading)
                  ? Container(
                      height: 2.0,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.grey[200],
                      ),
                    )
                  : Container()
            ],
          ),
        ),
        (widget.onTap != null &&
                widget.loading != true &&
                widget.items.length > 0)
            ? GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  color: Colors.transparent,
                  height: 50.0,
                  width: double.infinity,
                ),
              )
            : Container(),
      ],
    );
  }
}

/*      (widget.onTap != null)
          ? GestureDetector(
        child: Container(
          color: Colors.red,
          height: 50.0,
          width: 20.0,
        ),
      )
          : Container(),*/
