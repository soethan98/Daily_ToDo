class Note {
  int _id;
  String _title;
  String _description;
  int _date;
  int _isAlarm;
  int _priority;

  Note(this._title,
      [this._description, this._date, this._isAlarm, this._priority]);

  Note.withId(this._id, this._title,
      [this._description, this._date, this._isAlarm, this._priority]);

  int get id => _id;
  String get title => _title;
  String get description => _description;
  int get date => _date;
  int get isAlarm => _isAlarm;
  int get priority => _priority;

  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }

  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  set priority(int newPriority) {
    if (newPriority >= 1 && newPriority <= 3) {
      this._priority = newPriority;
    }
  }

  set alarm(int alarmStatus) {
    if (alarmStatus == 0 || alarmStatus == 1) {
      this._isAlarm = alarmStatus;
    }
  }

  set date(int newDate) {
    this._date = newDate;
  }

  // Convert a Note object into a Map object
	Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = _id;
		}
		map['title'] = _title;
		map['description'] = _description;
		map['priority'] = _priority;
		map['date'] = _date;
    map['isAlarm'] = _isAlarm;

		return map;
	}

	// Extract a Note object from a Map object
	Note.fromMapObject(Map<String, dynamic> map) {
		this._id = map['id'];
		this._title = map['title'];
		this._description = map['description'];
		this._priority = map['priority'];
		this._date = map['date'];
    this._isAlarm = map['isAlarm'];
	}
}
