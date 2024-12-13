
import moment from 'moment';

export default function displayDaysSinceLaunch() {
    // Read launch date from data attribute
    requestAnimationFrame(this.displayDaysSinceLaunch.bind(this));
    const launchDateString = this.element.dataset.launchDate;
    const launchDate = moment(launchDateString, "YYYY-MM-DD HH:mm:ss", true);

    // Validate the launch date
    if (!launchDate.isValid()) {
      console.error("Invalid launch date format. Please use YYYY-MM-DD.");
      return;
    }

    // Get today's date
    const today = moment();

    const diffDays = today.diff(launchDate, 'days');


    const daysElement = document.getElementById('days-since-launch');
    const hrsElement = document.getElementById('hrs-since-launch');
    const minsElement = document.getElementById('mins-since-launch');
    const secsElement = document.getElementById('secs-since-launch');
    if (daysElement) {
      daysElement.textContent = `Day: ${diffDays}`;
      hrsElement.textContent = `Hrs: ${today.hours()}`;
      minsElement.textContent = `Mins: ${today.minutes()}`;
      secsElement.textContent = `Secs: ${today.seconds()}`;
    } else {
      console.warn("Element with id 'days-since-launch' not found.");
    }
  }; 