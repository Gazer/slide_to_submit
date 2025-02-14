library slide_to_submit;

import 'dart:math';

import 'package:flutter/material.dart';

/// Callback that will receive the caller when the user submit the action.
typedef SlideToSubmitCallback = void Function(
    Function onFinish, Function onError);

/// Create a widget that when is slided triggers a submit action
///
/// The [icon] argument sets the image for the drag area. The recommended one is
/// [Icons.arrow_forward].
///
/// The [text] argument should not be too long, because may trigger some render
/// issues. Keep it simple, like a button text.
///
/// The [color] sets how the background is render. Keep in mind that ligth colors
/// may not result dut white is used as text color. Will be improved in the future.
class SlideToSubmitWidget extends StatefulWidget {
  final IconData icon;
  final String text;
  final Color color;
  final SlideToSubmitCallback onSubmit;
  final double height;

  const SlideToSubmitWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.onSubmit,
    this.height = 80,
  }) : super();

  @override
  _SlideToSubmitWidgetState createState() => _SlideToSubmitWidgetState();
}

class _SlideToSubmitWidgetState extends State<SlideToSubmitWidget>
    with SingleTickerProviderStateMixin {
  double slidePercent = 0.0;
  double widgetWidth = 0;
  bool dragging = false;
  bool loading = false;
  bool success = false;
  double dragStartAt = 0;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    _controller.addListener(() {
      setState(() {
        slidePercent = _controller.value;
      });
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          dragging = false;
          widgetWidth = 0;
          dragStartAt = 0;
          slidePercent = 0;
        });
      }
    });
  }

  _dragStart(DragStartDetails details) {
    setState(() {
      dragging = true;
      dragStartAt = details.globalPosition.dx;
      widgetWidth = context.size?.width ?? 0.0;
    });
  }

  _dragUpdate(DragUpdateDetails details) {
    if (dragging) {
      var maxDragDistance = widgetWidth - widget.height;

      var distance =
          min(maxDragDistance, details.globalPosition.dx - dragStartAt);

      if (distance > 0) {
        setState(() {
          slidePercent = distance / widgetWidth;
        });
      }
    }
  }

  _dragEnd(DragEndDetails details) {
    setState(() {
      print(
          "${(widgetWidth * (1.0 - slidePercent)).toInt()} <= ${widget.height.toInt()}");
      if ((widgetWidth * (1.0 - slidePercent)).toInt() <=
          widget.height.toInt()) {
        widget.onSubmit(_onFinish, _onError);

        loading = true;
        _controller.reverse(from: slidePercent);
      } else {
        _controller.reverse(from: slidePercent);
      }
    });
  }

  _onFinish() {
    setState(() {
      success = true;
    });
  }

  _onError() {
    setState(() {
      dragging = false;
      loading = false;
      slidePercent = 0;
      widgetWidth = 0;
    });
  }

  Widget _normal() {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.height / 2),
        color: widget.color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(width: widget.height * 0.125),
          GestureDetector(
            onHorizontalDragStart: _dragStart,
            onHorizontalDragUpdate: _dragUpdate,
            onHorizontalDragEnd: _dragEnd,
            child: Container(
              width: widget.height * 0.75,
              height: widget.height * 0.75,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.height * 0.375),
                color: Colors.white,
              ),
              child: Icon(
                widget.icon,
                size: widget.height / 2,
                color: widget.color,
              ),
            ),
          ),
          Container(
            width: dragging
                ? (widgetWidth * (1.0 - slidePercent) - widget.height)
                : null,
            child: Padding(
              padding: EdgeInsets.only(
                  left: widget.height * 0.2, right: widget.height * 0.45),
              child: Text(
                widget.text,
                maxLines: 1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: widget.height / 4,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _loading() {
    return Container(
      height: widget.height,
      width: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.height / 2),
        color: widget.color,
      ),
      child: AnimatedCrossFade(
        firstChild: Center(
          child: Padding(
            padding: EdgeInsets.all(widget.height / 4),
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.white),
            ),
          ),
        ),
        secondChild: Center(
          child: Icon(
            Icons.check,
            size: widget.height * 0.375,
            color: Colors.white,
          ),
        ),
        crossFadeState:
            success ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 750),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: dragging ? widgetWidth * slidePercent : 0,
        ),
        loading ? _loading() : Expanded(child: _normal()),
      ],
    );
  }
}
