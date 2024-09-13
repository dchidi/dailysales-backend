
from datetime import datetime, timedelta

def calculate_dates(str_date: str):
        # Convert the input string to a datetime object
        # try:
        #     str_date = datetime.strptime(date_str, "%Y-%m-%d")
        # except ValueError:
        #     return "Invalid date format"

        # Get the current year and month
        # current_year = str_date.year
        # current_month = str_date.month

        # Find the week number in the current month
        start_of_month = str_date.replace(day=1)
        # current_weekday = str_date.weekday()  # Monday is 0 and Sunday is 6
        start_weekday = start_of_month.weekday()
        week_number = (str_date.day + start_weekday - 1) // 7 + 1

        # Calculate the start date of the target week in the current year
        start_of_target_week = start_of_month + timedelta(weeks=week_number - 1)
        start_of_target_week -= timedelta(days=start_of_target_week.weekday())

        # Calculate the dates for that week in the previous year
        start_of_last_year = start_of_target_week - timedelta(days=365)

        # Handle leap years by adjusting dates accordingly
        def adjust_for_leap_year(date):
            try:
                return date
            except ValueError:
                if date.month == 2 and date.day == 29:
                    # Handle February 29 for leap years
                    return date.replace(year=date.year + 1, day=28)
                raise

        week_dates_last_year = {}
        for i in range(7):
            date = start_of_last_year + timedelta(days=i)
            # Adjust for leap year issues
            adjusted_date = adjust_for_leap_year(date)
            # Add date and day to the dictionary
            week_dates_last_year[adjusted_date.strftime("%A")] = adjusted_date.strftime("%Y-%m-%d")

        str_day = str_date.strftime("%A")

        # 
        return week_dates_last_year[str_day]

    