import "./EventList.css"

function EventList() {
  return (
    <div className="eventList">
      <h3 className="eventListTitle">Up Comming Events</h3>
      <table className="eventListTable">
        <tr className="eventListTr">
          <th className="eventListTh">Customer</th>
          <th className="eventListTh">Date</th>
        </tr>
        <tr className="eventListTr">
          <td className="eventListUser">
            <img
              src="https://w7.pngwing.com/pngs/253/892/png-transparent-computer-icons-calendar-date-event-table-calendar-text-rectangle.png"
              alt=""
              className="eventListImg"
            />
            <span className="eventListName">Kasun Fernando</span>
          </td>
          <td className="eventListDate">2 May 2023</td>
        </tr>
        <tr className="eventListTr">
          <td className="eventListUser">
            <img
              src="https://w7.pngwing.com/pngs/253/892/png-transparent-computer-icons-calendar-date-event-table-calendar-text-rectangle.png"
              alt=""
              className="eventListImg"
            />
            <span className="eventListName">Aruni Peris</span>
          </td>
          <td className="eventListDate">14 May 2023</td>
        </tr>
        <tr className="eventListTr">
          <td className="eventListUser">
            <img
              src="https://w7.pngwing.com/pngs/253/892/png-transparent-computer-icons-calendar-date-event-table-calendar-text-rectangle.png"
              alt=""
              className="eventListImg"
            />
            <span className="eventListName">Saman Perera</span>
          </td>
          <td className="eventListDate">2 Jun 2023</td>
        </tr>
        <tr className="eventListTr">
          <td className="eventListUser">
            <img
              src="https://w7.pngwing.com/pngs/253/892/png-transparent-computer-icons-calendar-date-event-table-calendar-text-rectangle.png"
              alt=""
              className="eventListImg"
            />
            <span className="eventListName">Dilan Senanayaka</span>
          </td>
          <td className="eventListDate">21 Jun 2023</td>
        </tr>
      </table>
    </div>
  )
}

export default EventList