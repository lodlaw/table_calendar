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
    @required this.rowHeight,
    @required this.calendarStyle,
  })  : assert(text != null),
        assert(calendarStyle != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    const margin = 6.0;
    final width = rowHeight + margin * 2;
    print(width);

    return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: _buildCellDecoration(),
        margin: const EdgeInsets.all(margin),
        alignment: Alignment.center,
        child: Container(
          decoration: hasEvent
              ? BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: calendarStyle.eventColor)
              : null,
          height: double.infinity,
          width: rowHeight - margin * 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                text,
                style: _buildCellTextStyle(),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ));
  }

  Decoration _buildCellDecoration() {
    Color color;
    if (isSelected) {
      color = calendarStyle.selectedColor;
    } else if (isToday) {
      color = calendarStyle.todayColor;
    }
    return BoxDecoration(
      color: color,
      image: isSelected
          ? DecorationImage(
              image: AssetImage("assets/images/selectedDayBackground.png"),
              fit: BoxFit.cover,
            )
          : null,
    );
  }

  TextStyle _buildCellTextStyle() {
    if (isUnavailable) {
      return calendarStyle.unavailableStyle;
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
    } else if (isOutsideMonth && isHoliday) {
      return calendarStyle.outsideHolidayStyle;
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
