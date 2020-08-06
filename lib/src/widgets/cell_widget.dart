//  Copyright (c) 2019 Aleksander Woźniak
//  Licensed under Apache License v2.0

part of table_calendar;

class _CellWidget extends StatelessWidget {
  final String text;
  final bool isUnavailable;
  final bool isSelected;
  final bool isToday;
  final bool isWeekend;
  final bool isOutsideMonth;
  final bool isHoliday;
  final CalendarStyle calendarStyle;
  final bool hasEvent;
  final double rowHeight;
  final SelectionMode selectionMode;

  const _CellWidget({
    Key key,
    @required this.text,
    this.isUnavailable = false,
    this.isSelected = false,
    this.isToday = false,
    this.isWeekend = false,
    this.isOutsideMonth = false,
    this.isHoliday = false,
    this.hasEvent = false,
    @required this.selectionMode,
    @required this.rowHeight,
    @required this.calendarStyle,
  })  : assert(text != null),
        assert(calendarStyle != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final margin = calendarStyle.cellMargin;

    return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: _buildCellDecoration(),
        margin: EdgeInsets.all(margin),
        alignment: Alignment.center,
        child: Container(
          child: Container(
            color: (isSelected && !calendarStyle.isRoundSelected)
                ? calendarStyle.selectedColor
                : (isWeekend ? calendarStyle.weekendBackgroundColor : null),
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Container(
                        padding: EdgeInsets.all(5.25),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (calendarStyle.isRoundSelected && isSelected)
                                ? calendarStyle.selectedColor
                                : hasEvent ? calendarStyle.eventColor : null),
                        child: Text(
                          key: ValueKey('${text}${isSelected + "Selected" : ""}'),
                          text,
                          style: _buildCellTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Decoration _buildCellDecoration() {
    Color color;
    if (isSelected && !calendarStyle.isRoundSelected) {
      color = calendarStyle.selectedColor;
    } else if (isToday) {
      color = calendarStyle.todayColor;
    } else if (isWeekend) {
      color = calendarStyle.weekendColor;
    }
    return BoxDecoration(color: color);
  }

  TextStyle _buildCellTextStyle() {
    if (isUnavailable) {
      return calendarStyle.unavailableStyle;
    } else if (isOutsideMonth && isHoliday) {
      return calendarStyle.outsideHolidayStyle;
    } else if (isHoliday) {
      return calendarStyle.holidayStyle;
    } else if (hasEvent) {
      return calendarStyle.eventStyle;
    } else if (isSelected && calendarStyle.renderSelectedFirst) {
      return calendarStyle.selectedStyle;
    } else if (isToday) {
      return calendarStyle.todayStyle;
    } else if (isSelected) {
      return calendarStyle.selectedStyle;
    } else if (isOutsideMonth && isWeekend) {
      return calendarStyle.outsideWeekendStyle;
    } else if (isOutsideMonth) {
      return calendarStyle.outsideStyle;
    } else if (isWeekend) {
      return calendarStyle.weekendStyle;
    } else {
      return calendarStyle.weekdayStyle;
    }
  }
}
