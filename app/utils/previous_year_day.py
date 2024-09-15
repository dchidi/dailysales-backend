
from datetime import datetime, timedelta

def calculate_dates(str_date: str):
    days_of_week = {
        "Monday": 0,
        "Tuesday": 1,
        "Wednesday": 2,
        "Thursday": 3,
        "Friday": 4,
        "Saturday": 5,
        "Sunday": 6
    }

    date_obj = datetime.strptime(str_date, "%Y-%m-%d") if isinstance(str_date, str) else  str_date


    first_day_of_month = date_obj.replace(day=1)
    day = first_day_of_month.strftime("%A")

    previous_year = date_obj.year - 1    
    first_day_of_date_obj_prev_year = date_obj.replace(year=previous_year, day=1)
    prev_year_day =  first_day_of_date_obj_prev_year.strftime("%A")

    diff = days_of_week[day] -  days_of_week[prev_year_day]

    if diff > -1:
        # start_date = first_day_of_date_obj_prev_year + timedelta(days=diff)
        prev_year_equivalent = date_obj.replace(year=previous_year) + timedelta(days=diff)
    else:
        counter = 0
        for i in range(6,-1, -1):
            counter += 1
            if days_of_week[day] == i + diff:
                # start_date = first_day_of_date_obj_prev_year + timedelta(days=counter)        
                prev_year_equivalent = date_obj.replace(year=previous_year) + timedelta(days=counter)

    return prev_year_equivalent.isoformat()
