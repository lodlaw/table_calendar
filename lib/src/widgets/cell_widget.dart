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
  final String mode;

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
    this.mode = "single",
    @required this.rowHeight,
    @required this.calendarStyle,
  })  : assert(text != null),
        assert(calendarStyle != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    const margin = 3.0;
    final width = rowHeight + margin * 4;

    return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: _buildCellDecoration(),
        margin: const EdgeInsets.all(margin),
        alignment: Alignment.center,
        child: Container(
          height: double.infinity,
          width: width,
          child: Container(
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 5.0),
                        decoration: hasEvent
                            ? BoxDecoration(
                                shape: BoxShape.circle,
                                color: calendarStyle.eventColor)
                            : null,
                        child: Text(
                          text,
                          style: _buildCellTextStyle(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                if (mode == "multiple" && isSelected)
                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(bottom: 1, right: 1),
                            child: Image.asset('assets/images/tick.png')),
                      ],
                    ),
                  ),
              ],
            ),
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
    return BoxDecoration(color: color, borderRadius: BorderRadius.circular(8));
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
