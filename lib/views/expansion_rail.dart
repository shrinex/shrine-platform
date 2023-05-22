/*
 * Created by Archer on 2023/5/22.
 * Copyright © 2023 Archer. All rights reserved.
 * Github: https://github.com/shrinex
 * Home: http://anyoptional.com
 */

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ExpansionRail extends StatefulWidget {
  const ExpansionRail({
    super.key,
    this.backgroundColor,
    this.leading,
    this.trailing,
    required this.children,
    this.elevation = 0.3,
    this.width = 210,
  }) : assert(width == null || width > 0);

  /// Sets the color of the Container that holds all of the [ExpansionRail]'s
  /// contents.
  final Color? backgroundColor;

  /// The leading widget in the rail that is placed above the children.
  final Widget? leading;

  /// The trailing widget in the rail that is placed below the children.
  final Widget? trailing;

  /// The widgets to display, typically [ExpansionTile].
  final List<Widget> children;

  /// The rail's elevation or z-coordinate.
  final double? elevation;

  /// The smallest possible width for the rail.
  final double? width;

  @override
  State<ExpansionRail> createState() => _ExpansionRailState();
}

class _ExpansionRailState extends State<ExpansionRail> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Color backgroundColor = widget.backgroundColor ?? colorScheme.surface;
    final bool isRTLDirection = Directionality.of(context) == TextDirection.rtl;
    final double elevation = widget.elevation ?? 0.0;
    final double width = widget.width ?? 200;

    Widget body = ListView(
      primary: false,
      children: <Widget>[
        _verticalSpacer,
        if (widget.leading != null) ...<Widget>[
          widget.leading!,
          _verticalSpacer,
        ],
        ...widget.children,
        if (widget.trailing != null) widget.trailing!,
      ],
    );

    return Semantics(
      explicitChildNodes: true,
      child: Material(
        elevation: elevation,
        color: backgroundColor,
        child: SafeArea(
          right: isRTLDirection,
          left: !isRTLDirection,
          child: SizedBox(
            width: width,
            child: body,
          ),
        ),
      ),
    );
  }
}

const Widget _verticalSpacer = SizedBox(height: 8.0);
